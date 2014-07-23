class App.Models.Characteristic extends Backbone.Model
  compositeValue: ->
    (_.map @parts, (part) -> part.content).join("")
