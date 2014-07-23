class App.Models.Persona extends Backbone.Model
  addCharacteristic: (characteristic) ->
    list = @get("characteristics") ? []
    list.push characteristic
    @unset "characteristics", silent: true
    @set characteristics: list
    this
