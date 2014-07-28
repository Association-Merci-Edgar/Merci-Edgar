//= require_tree ./templates

ReportApp = Ember.Application.create({
	rootElement: '#ember-activity'
})

ReportApp.IndexRoute = Ember.Route.extend({
	contactId: $('#contactable').data('contact-id'),
	assetId: $('#contactable').data('asset-id'),
	assetType: $('#contactable').data('asset-type'),
	model: function() {
		// assetId = $('#contact_id').data('asset-id');
		return this.store.find('reporting', { contact_id: this.get('contactId') });
	},
	setupController: function(controller, model) {
		controller.set('model', model);
		controller.set('assetId', this.get('assetId'));
		controller.set('assetType', this.get('assetType'))
	}
})

ReportApp.IndexController = Ember.ArrayController.extend({
	itemController: 'report',	
	needs: ['projects'],
	note_report_content: null,
	actions: {
		createNote: function(){
			selectedProject = this.get('controllers.projects.selectedProject');
			if (selectedProject) {
				project_id = selectedProject.get('id')
			}
			else {
				project_id = null;
			}
			
			reporting = this.store.createRecord('reporting', {
				asset_id: this.get('assetId'),
				asset_type: this.get('assetType'),
				note_report_content: this.get('note_report_content'),
				project_id: project_id
			})
			reporting.save();
			return false;
		}
	}

	// assetId: $('#contact_id').data('asset-id')
})

ReportApp.ReportController = Ember.ObjectController.extend({
	
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
	reportings: DS.hasMany('reportings')
})

ReportApp.Reporting = DS.Model.extend({
	project_id: DS.attr('number'),
	note_report_content: DS.attr(),
	asset_id: DS.attr('number'),
	asset_type: DS.attr('string')
})

