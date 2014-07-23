class App.Collections.Repositories extends Backbone.Collection
  model: App.Models.Repository
  comparator: (item) -> item.get 'name'

  allMatching: (patterns) ->
    @select (item) ->
      _.all(patterns, (p) -> p.test(item.get('name')))
