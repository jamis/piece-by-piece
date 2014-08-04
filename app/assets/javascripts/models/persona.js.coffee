class App.Models.Persona extends Backbone.Model
  initialize: ->
    characteristics = new App.Collections.Characteristics

    characteristics.on "add", => @trigger("change")
    characteristics.on "change", => @trigger("change")
    characteristics.on "remove", => @trigger("change")

    @set 'characteristics', characteristics

  toJSON: (options) ->
    json = super(options)
    json.cid = @cid
    return json
