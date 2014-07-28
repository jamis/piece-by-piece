class App.Models.Persona extends Backbone.Model
  getCharacteristics: ->
    @get("characteristics") ? []

  addCharacteristic: (characteristic) ->
    list = @getCharacteristics()
    list.push characteristic
    @unset "characteristics", silent: true
    @set characteristics: list
    this

  deleteCharacteristic: (cid) ->
    list = @getCharacteristics()
    characteristic = _.find list, (c) -> c.cid == cid
    list = _.without(list, characteristic)
    @unset "characteristics", silent: true
    @set characteristics: list
