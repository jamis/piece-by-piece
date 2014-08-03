class App.Models.Characteristic extends Backbone.Model
  compositeValue: ->
    (_.map @get('parts'), (part) -> part.content).join("")
