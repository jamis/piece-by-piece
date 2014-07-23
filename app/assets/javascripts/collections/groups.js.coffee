class App.Collections.Groups extends Backbone.Collection
  model: App.Models.Group
  comparator: (group) -> group.get 'name'
