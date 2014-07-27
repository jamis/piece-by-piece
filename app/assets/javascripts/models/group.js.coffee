class App.Models.Group extends Backbone.Model
  type: "group"

App.include App.Models.Group, App.Mixins.Participation
