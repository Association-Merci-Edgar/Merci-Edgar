(function(window) {
  var I18n, assert, findTemplate, get, set, isBinding, lookupKey, pluralForm,
      PlainHandlebars, EmHandlebars, keyExists,
      compileTemplate, compileWithHandlebars;

  PlainHandlebars = window.Handlebars;
  EmHandlebars = Ember.Handlebars;
  get = EmHandlebars.get;
  set = Ember.set;
  assert = Ember.assert;

  function warn(msg) { Ember.Logger.warn(msg); }

  if (typeof CLDR !== "undefined" && CLDR !== null) pluralForm = CLDR.pluralForm;

  if (pluralForm == null) {
    warn("CLDR.pluralForm not found. Ember.I18n will not support count-based inflection.");
  }

  lookupKey = function(key, hash) {
    var firstKey, idx, remainingKeys;

    if (hash[key] != null) { return hash[key]; }

    if ((idx = key.indexOf('.')) !== -1) {
      firstKey = key.substr(0, idx);
      remainingKeys = key.substr(idx + 1);
      hash = hash[firstKey];
      if (hash) { return lookupKey(remainingKeys, hash); }
    }
  };

  findTemplate = function(key, setOnMissing) {
    assert("You must provide a translation key string, not %@".fmt(key), typeof key === 'string');
    var result = lookupKey(key, I18n.translations);

    if (setOnMissing) {
      if (result == null) {
        result = I18n.translations[key] = function() { return "Missing translation: " + key; };
        result._isMissing = true;
        warn("Missing translation: " + key);
        I18n[(typeof I18n.trigger === 'function' ? 'trigger' : 'fire')]('missing', key); //Support 0.9 style .fire
      }
    }

    if ((result != null) && !jQuery.isFunction(result)) {
      result = I18n.translations[key] = I18n.compile(result);
    }

    return result;
  };

  keyExists = function(key) {
    var translation = lookupKey(key, I18n.translations);
    return translation != null && !translation._isMissing;
  };

  function eachTranslatedAttribute(object, fn) {
    var isTranslatedAttribute = /(.+)Translation$/,
        isTranslatedAttributeMatch;

    for (var key in object) {
      isTranslatedAttributeMatch = key.match(isTranslatedAttribute);
      if (isTranslatedAttributeMatch) {
        fn.call(object, isTranslatedAttributeMatch[1], I18n.t(object[key]));
      }
    }
  }

  compileWithHandlebars = (function() {
    Ember.warn("Ember.I18n will no longer include Handlebars compilation by default in the future; instead, it will supply its own default compiler. Set Ember.I18n.I18N_COMPILE_WITHOUT_HANDLEBARS to true to opt-in now.");

    if (typeof PlainHandlebars.compile === 'function') {
      return function compileWithHandlebars(template) {
        return PlainHandlebars.compile(template);
      };
    } else {
      return function cannotCompileTemplate() {
        throw new Ember.Error('The default Ember.I18n.compile function requires the full Handlebars. Either include the full Handlebars or override Ember.I18n.compile.');
      };
    }
  }());

  function compileWithoutHandlebars(template) {
    return function (data) {
      return template.replace(/\{\{(.*?)\}\}/g, function(i, match) {
        return data[match];
      });
    };
  }

  if (Ember.ENV.I18N_COMPILE_WITHOUT_HANDLEBARS === true) {
    compileTemplate = compileWithoutHandlebars;
  } else {
    compileTemplate = compileWithHandlebars;
  }

  I18n = Ember.Evented.apply({
    compile: compileTemplate,

    translations: {},

    // Ember.I18n.eachTranslatedAttribute(object, callback)
    //
    // Iterate over the keys in `object`; for each property that ends in "Translation",
    // call `callback` with the property name (minus the "Translation" suffix) and the
    // translation whose key is the property's value.
    eachTranslatedAttribute: eachTranslatedAttribute,

    template: function(key, count) {
      var interpolatedKey, result, suffix;
      if ((count != null) && (pluralForm != null)) {
        suffix = pluralForm(count);
        interpolatedKey = "%@.%@".fmt(key, suffix);
        result = findTemplate(interpolatedKey, false);
      }
      return result != null ? result : result = findTemplate(key, true);
    },

    t: function(key, context) {
      var template;
      if (context == null) context = {};
      template = I18n.template(key, context.count);
      return template(context);
    },

    exists: keyExists,

    TranslateableProperties: Ember.Mixin.create({
      init: function() {
        var result = this._super.apply(this, arguments);
        eachTranslatedAttribute(this, function(attribute, translation) {
          this.addObserver(attribute + 'Translation', this, function(){
            set(this, attribute, I18n.t(this.get(attribute + 'Translation')));
          });
          set(this, attribute, translation);
        });

        return result;
      }
    }),

    TranslateableAttributes: Ember.Mixin.create({
      didInsertElement: function() {
        var result = this._super.apply(this, arguments);
        eachTranslatedAttribute(this, function(attribute, translation) {
          this.$().attr(attribute, translation);
        });
        return result;
      }
    })
  });

  Ember.I18n = I18n;

  isBinding = /(.+)Binding$/;

  function uniqueElementId() {
    return ++Ember.uuid;
  }

  EmHandlebars.registerHelper('t', function(key, options) {
    var attrs, context, data, elementID, result, tagName, view;
    context = this;
    attrs = options.hash;
    data = options.data;
    view = data.view;
    tagName = attrs.tagName || 'span';
    delete attrs.tagName;
    elementID = uniqueElementId();

    Ember.keys(attrs).forEach(function(property) {
      var bindPath, currentValue, invoker, isBindingMatch, normalized, normalizedPath, observer, propertyName, root, _ref;
      isBindingMatch = property.match(isBinding);

      if (isBindingMatch) {
        propertyName = isBindingMatch[1];
        bindPath = attrs[property];
        currentValue = get(context, bindPath, options);
        attrs[propertyName] = currentValue;
        invoker = null;
        normalized = EmHandlebars.normalizePath(context, bindPath, data);
        _ref = [normalized.root, normalized.path], root = _ref[0], normalizedPath = _ref[1];

        observer = function() {
          var elem, newValue;
          if (view.$() == null) {
            Ember.removeObserver(root, normalizedPath, invoker);
            return;
          }
          newValue = get(context, bindPath, options);
          elem = view.$("#" + elementID);
          attrs[propertyName] = newValue;
          return elem.html(I18n.t(key, attrs));
        };

        invoker = function() {
          Ember.run.scheduleOnce('afterRender', observer);
        };

        return Ember.addObserver(root, normalizedPath, invoker);
      }
    });

    result = '<%@ id="%@">%@</%@>'.fmt(tagName, elementID, I18n.t(key, attrs), tagName);
    return new EmHandlebars.SafeString(result);
  });

  var attrHelperFunction = function(options) {
    var attrs, result;
    attrs = options.hash;
    result = [];

    Ember.keys(attrs).forEach(function(property) {
      var translatedValue;
      translatedValue = I18n.t(attrs[property]);
      return result.push('%@="%@"'.fmt(property, translatedValue));
    });

    return new EmHandlebars.SafeString(result.join(' '));
  };

  EmHandlebars.registerHelper('translateAttr', attrHelperFunction);
  EmHandlebars.registerHelper('ta', attrHelperFunction);

}).call(undefined, this);
