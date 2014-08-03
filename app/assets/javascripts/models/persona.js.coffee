class App.Models.Persona extends Backbone.Model
  initialize: ->
    characteristics = new App.Collections.Characteristics

    characteristics.on "add", => @trigger("change")
    characteristics.on "remove", => @trigger("change")

    @set 'characteristics', characteristics
