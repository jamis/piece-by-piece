class App.Models.Event extends Backbone.Model
  type: "event"

App.include App.Models.Event, App.Mixins.Participation
App.include App.Models.Event, App.Mixins.UnknownValues
