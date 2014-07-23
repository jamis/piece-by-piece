class App.Collections.Sources extends Backbone.Collection
  model: App.Models.Source
  comparator: (item) -> item.get 'name'

  allMatching: (patterns) ->
    @select (item) ->
      _.all(patterns, (p) -> p.test(item.get('name')))
