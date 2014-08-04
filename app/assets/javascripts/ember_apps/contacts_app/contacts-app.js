//= require_self
//= require_tree ./templates
//= require_tree ./components



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

App.ApplicationAdapter = DS.FixtureAdapter.extend();

App.ApplicationController = Ember.Controller.extend({
	appName: 'Mon appli'
})


App.IndexRoute = Ember.Route.extend({
	model: function(){
		return this.store.find('contact')
	}
})

App.IndexController = Ember.ArrayController.extend({
	queryParams: ['style', 'network', 'capacity', 'venue_kind', 'custom', 'contract'],
})

App.Contact = DS.Model.extend({
	type: DS.attr(),
	name: DS.attr(),
	avatar: DS.attr(),
	people_structures: DS.hasMany('people_structures'),
	address: DS.attr(),
	email: DS.attr(),
	phone: DS.attr(),
	capacity_list: DS.attr(),
	network_list: DS.attr(),
	custom_list: DS.attr(),
	style_list: DS.attr(),
	venue_kind: DS.attr(),
	contract_list: DS.attr(),
	show_link: DS.attr(),
	edit_link: DS.attr()
})

App.PeopleStructure = DS.Model.extend({
	
})
App.Contact.FIXTURES = [
	{
		id:1,
		type: 'Venue',
		name: 'Le Clan Destin',
		avatar: '/assets/fallback/venue_default.png',
		address: 'Saint-Arnoult-en-Yvelines',
		email: 'info@lafabriqueacocktail.com',
		phone: '+33 6 61 74 69 69',
		capacity_list: ['100-400'],
		network_list: ['Cocktails Events'],
		custom_list: ['Girlfriend'],
		style_list: ['Reggae', 'Country', 'Musette'],
		venue_kind: 'Bar',
		contract_list: ['Location'],
		show_link: 'http://www.lafabriqueacocktail.com',
		edit_link: 'http://www.google.fr'
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
	href: function() {
		return '#?' + this.get('linkTagKind') + '=' + this.get('linkTagValue')
	}.property()
})