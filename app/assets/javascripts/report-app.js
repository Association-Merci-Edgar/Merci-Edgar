//= require_tree ./templates

ReportApp = Ember.Application.create({
	rootElement: '#ember-activity'
})

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
			console.log("deleting note ...");
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
		console.log('selectedProject:' + this.get('project').get('id'))
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




