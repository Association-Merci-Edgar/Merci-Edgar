//= require_self
//= require_tree ./templates
//= require_tree ./components

Ember.I18n.I18N_COMPILE_WITHOUT_HANDLEBARS = true;
Em.I18n.translations = {
  'Venue': 'Lieu',
  'ShowBuyer': 'Organisateur de spectacles',
  'Festival': 'Festival',
  'Structure': 'Structure',
  'Person': 'Personne',

  'bar': 'Bar',
  'cultural_center': 'Centre culturel',
  'smac': 'SMAC',
  'music_venue': 'Salle de concerts',
  'theater': 'Théâtre',
  'mjc': 'MJC',
  'theater_cafe': 'Café-Théâtre',
  'other': 'Autre'

};

Ember.Handlebars.registerBoundHelper("pt", function(value) {
    return Ember.I18n.t(value);
});

if ($("#ember-contacts").length > 0 ) {
	//EmberENV = {FEATURES: {'query-params-new': true}};

	
	App = Ember.Application.create({
		rootElement: '#ember-contacts',
		Resolver: Ember.DefaultResolver.extend({
	    resolveTemplate: function(parsedName) {
	      parsedName.fullNameWithoutType = "ember_apps/contacts_app/" + parsedName.fullNameWithoutType;
	      return this._super(parsedName);
	    }
	  })
	})
	
}

App.Router.map(function() {
	this.resource('contacts')
})

// App.ApplicationAdapter = DS.FixtureAdapter.extend();
App.ApplicationAdapter = DS.ActiveModelAdapter.extend();

App.ApplicationController = Ember.Controller.extend({
	appName: 'Mon appli'
})


App.IndexRoute = Ember.Route.extend({
	model: function(params){
		return this.store.find('contact', params)
	},
	actions: {
		queryParamsDidChange: function() {
			console.log("query params changed")
			this.refresh();
		}
	}
})

App.IndexController = Ember.ArrayController.extend({
	queryParams: ['style_list', 'network_list', 'capacity_range', 'venue_kind', 'custom_list', 'contract_list'],
	style_list: null,
	network_list: null,
	capacity_range: null,
	venue_kind: null,
	custom_list: null,
	contract_list: null
})

App.Contact = DS.Model.extend({
	type: DS.attr(),
	name: DS.attr(),
	avatar_url: DS.attr(),
	people_structures: DS.hasMany('people_structure', { async: true}),
	city: DS.attr(),
	email_address: DS.attr(),
	phone_number: DS.attr(),
	capacity_list: DS.attr(),
	network_list: DS.attr(),
	custom_list: DS.attr(),
	style_list: DS.attr(),
	venue_kind: DS.attr(),
	contract_list: DS.attr(),
	show_link: DS.attr(),
	edit_link: DS.attr(),
	isPerson: function() {
		return this.get('type') == "Person"
	}.property()
})

App.PeopleStructure = DS.Model.extend({
	person: DS.belongsTo('contact'),
	structure: DS.belongsTo('contact'),
	title: DS.attr()
})
App.Contact.FIXTURES = [
	{
		id:1,
		type: 'Venue',
		name: 'Le Clan Destin',
		avatar_url: '/assets/fallback/venue_default.png',
		city: 'Saint-Arnoult-en-Yvelines',
		email: 'info@lafabriqueacocktail.com',
		phone: '+33 6 61 74 69 69',
		capacity_list: ['100-400'],
		network_list: ['Cocktails Events'],
		custom_list: ['Girlfriend'],
		style_list: ['Reggae', 'Country', 'Musette'],
		venue_kind: 'bar',
		contract_list: ['Location'],
		show_link: 'http://www.lafabriqueacocktail.com',
		edit_link: 'http://www.google.fr',
		people_structures: [1]
	},
	{
		id:2,
		type: 'Person',
		name: 'Bob Sinclar',
		people_structures: [1]
	}
]

App.PeopleStructure.FIXTURES = [
	{
		id: 1,
		person: 2,
		structure: 1,
		title: 'Dirlot'
	}
]

App.LinkTagComponent = Ember.Component.extend({
	tagName: 'a',
	cssTag: function() {
		return "tag-" + this.get('linkTagKind')
	}.property(),
	classNameBindings: ['cssTag'],
	classNames: ['tag'],
	attributeBindings: ['href'],
	multiValued: true,
	paramName: function() {
		suffix = this.get('multiValued') ? '_list' : ''
		return this.get('linkTagKind') + suffix
	}.property(),
	href: function() {
		return '#?' + this.get('paramName') + '=' + this.get('linkTagValue')
	}.property()
})

App.QueryParamDisplayComponent = Ember.Component.extend({
	tagName: 'button',
	toTranslate: false,
	classNames: ['tag', 'active'],
	classNameBindings: ['cssTag'],
	cssTag: function() {
		return "tag-" + this.get('linkTagKind')
	}.property(),
	actions: {
		remove: function() {
			this.set('paramValue', null)
		}			
	}
})