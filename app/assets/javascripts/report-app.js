//= require_tree ./templates

ReportApp = Ember.Application.create({
	rootElement: '#ember-activity'
})

ReportApp.IndexRoute = Ember.Route.extend({
	model: function() {
		assetId = $('#contact_id').data('asset-id');
		return this.store.find('reporting', { contact_id: assetId });
	}
})
ReportApp.IndexController = Ember.ArrayController.extend({
	itemController: 'report',	
	assetId: $('#contact_id').data('asset-id'),		
	projects: ['Robi and co', 'Jungle Juice']	
})

ReportApp.ReportController = Ember.ObjectController.extend({
	
})

ReportApp.Reporting = DS.Model.extend({
	report_type: DS.attr(),
	content: DS.attr()	
})