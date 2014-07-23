class App.Collections.Events extends Backbone.Collection
  model: App.Models.Event
  comparator: (event) -> event.get 'name'
