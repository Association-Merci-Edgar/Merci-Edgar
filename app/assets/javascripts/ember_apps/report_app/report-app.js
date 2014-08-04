//= require_self
//= require moment-with-langs
//= require_tree ./templates

Ember.Handlebars.registerBoundHelper('formattedDate', function(date) {
	moment.lang('fr')
	now = moment(Date.now());
	moment_date = moment(date);
	if (now.diff(moment_date, 'days') > 2) {
		return moment_date.format('LLL')
	} else {
	  return moment_date.fromNow();		
	}
});

Ember.Handlebars.registerBoundHelper('simple_format', function(text) {
  var carriage_returns, newline, paragraphs;
	text = Handlebars.Utils.escapeExpression(text);
  carriage_returns = /\r\n?/g;
  paragraphs = /\n\n+/g;
  newline = /([^\n]\n)(?=[^\n])/g;
  text = text.replace(carriage_returns, "\n");
  text = text.replace(paragraphs, "</p>\n\n<p>");
  text = text.replace(newline, "$1<br/>");
  text = "<p>" + text + "</p>";
  return new Handlebars.SafeString(text);
});

if ($("#ember-activity").length > 0 ) {
	ReportApp = Ember.Application.create({
		rootElement: '#ember-activity',
		ready: function() {
		    console.log("Ember.TEMPLATES: ", Ember.TEMPLATES);
		},
		Resolver: Ember.DefaultResolver.extend({
	    resolveTemplate: function(parsedName) {
	      parsedName.fullNameWithoutType = "ember_apps/report_app/" + parsedName.fullNameWithoutType;
	      return this._super(parsedName);
	    }
	  })
	})
	
}

ReportApp.IndexRoute = Ember.Route.extend({
	contactId: $('#contactable').data('contact-id'),
	model: function() {
		// assetId = $('#contact_id').data('asset-id');
		return this.store.find('reporting', { contact_id: this.get('contactId') });
	},
	setupController: function(controller, model) {
		controller.set('model', model);
		controller.set('assetId', this.get('contactId'));
		controller.set('assetType', 'Contact')
	}
})

ReportApp.IndexController = Ember.ArrayController.extend({
	itemController: 'report',	
	needs: ['projects'],
	sortProperties: ['created_at'],
  sortAscending: false,
	note_report_content: null,
	actions: {
		createNote: function(){
			selectedProject = this.get('controllers.projects.selectedProject');
			
			reporting = this.store.createRecord('reporting', {
				asset_id: this.get('assetId'),
				asset_type: this.get('assetType'),
				note_report_content: this.get('note_report_content'),
				project: selectedProject
			})

			controller = this;
      reporting.save().then(function(reporting) {
         controller.set('note_report_content', null);
         controller.get('model').addObject(reporting);
       });
		},
		deleteNote: function(reporting) {
			if (confirm('Etes-vous sûr de supprimer cette note ?')) {
				//reporting = this.get('model');
				controller = this
				reporting.destroyRecord().then(function(){
					controller.get('model').removeObject(reporting);
				});				
			}
		}
		
	}

	// assetId: $('#contact_id').data('asset-id')
})

ReportApp.ReportController = Ember.ObjectController.extend({
	needs: ['projects'],
	isEditing: false,
	selectedProject: function() {
		return this.get('project')
	}.property('project'),
	actions: {
		toggleEdit: function() {
			this.toggleProperty('isEditing')
		},
		updateNote: function(reporting) {
			controller = this;
			reporting.set('project', this.get('selectedProject'))
			reporting.save().then(function(reporting){
				controller.toggleProperty('isEditing')
			});
		},
		cancelEdit: function(reporting) {
			reporting.rollback();
			this.set('selectedProject', reporting.get('project'))
			this.toggleProperty('isEditing')
		}
		
	}
})


ReportApp.ReportView = Ember.View.extend({
	tagName: 'li',
	didInsertElement: function() {
		this.$().hide().fadeIn(1000)
	}/* NOT WORKING,
	willDestroyElement: function() {
		console.log('just before destroy element...')
		clone = this.$().clone();
		clone.attr('id', 'ember-view-clone');
		this.$().after(clone);
		clone.fadeOut(1000);
	}*/
})

ReportApp.ProjectsController = Ember.ArrayController.extend({
	init: function() {
		this._super();
		this.set('model', this.store.find('project'))
	},
	selectedProject: Ember.computed.alias('content.firstObject'),
	anyProject: Ember.computed.gt('content.length', 0)
})


ReportApp.Project = DS.Model.extend({
	name: DS.attr('string'),
	avatar_url: DS.attr('string')
})

ReportApp.Reporting = DS.Model.extend({
	project: DS.belongsTo('project'),
	created_at: DS.attr('date', {readOnly: true}),
	user: DS.belongsTo('user', {readOnly: true}), 
	note_report_content: DS.attr(),
	asset_id: DS.attr('number'),
	asset_type: DS.attr('string')
})

ReportApp.User = DS.Model.extend({
	avatar_url: DS.attr('string'),
	nickname: DS.attr('string')
})

ReportApp.ApplicationSerializer = DS.RESTSerializer.extend({
  serializeAttribute: function(record, json, key, attribute) {
    if (attribute.options && attribute.options.readOnly) {
      return
    } else {
      this._super(record, json, key, attribute);
    }
  },

	serializeBelongsTo: function(record, json, relationship) {
		if (relationship.options && relationship.options.readOnly) {
			return
		} else {
			this._super(record, json, relationship)
		}
	}
});




