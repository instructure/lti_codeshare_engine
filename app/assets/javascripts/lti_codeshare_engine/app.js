App = Ember.Application.create();

App.Router.map(function() {
  this.route('index', { path: '/' });
  this.route('embed', { path: '/embed' });
});

App.IndexController = Ember.Controller.extend({
  needs: ['embed'],

  actions: {
    verify: function() {
      var _this = this;
      var postUrl = Ember.ENV['root_path'] + 'api/create_entry_from_url';
      this.set('error', null);
      this.set('entry', null);
      ic.ajax({
        type: "POST",
        url: postUrl,
        data: { url: this.get('url') }
      }).then(
        function(result) {
          _this.set('entry', Em.Object.create(result));
        },
        function(result) {
          var errorMessage = result.jqXHR.responseJSON.error;
          _this.set('error', errorMessage);
        }
      );
    },

    reset: function() {
      this.set('error', null);
      this.set('entry', null);
      this.set('url', null);
    },

    embed: function() {
      var _this = this;
      var embedUrl = Ember.ENV.root_path + 'embed';
      ic.ajax({
        type: "POST",
        url: embedUrl,
        data: { launch_params: Ember.ENV.launch_params, uuid: this.get('entry.uuid') }
      }).then(
        function(result) {
          window.location = result.redirect_url;
        },
        function(result) {
          var embedObject = Ember.Object.create(result.jqXHR.responseJSON);
          _this.get('controllers.embed').set('model', embedObject);
          _this.transitionToRoute('embed');
        }
      );
    }
  }
});

App.IndexRoute = Ember.Route.extend({});

App.EmbedController = Ember.ObjectController.extend({
  embedCode: function() {
    return '<iframe src="' + this.get('url') + '" frameborder="0" style="position: absolute; height: 100%; overflow: hidden; width:100%;" height="100%" width="100%" allowfullscreen></iframe>';
  }.property('model')
});

App.EmbedRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    if (Ember.isEmpty(controller.get('model'))) {
      this.transitionTo('index');
    }
  }
});
