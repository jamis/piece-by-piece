class App.Views.AddPerson extends App.Views.Dialog
  template: "add_person"

  events:
    'click .back a'    : 'cancel'
    'click .tabs li'   : 'changeTab'
    'click .next a'    : 'next'
    'click .part'      : 'showPartMenu'
    'menu:click'       : 'menuCommand'
    'click .trust'     : 'changeTrust'
    'change input.name': 'parseName'

  render: ->
    super
    $(@el).addClass "l2 add-person data-entry"
    $(@screen).addClass "l2"
    @currentTab = "name"
    this

  next: (event) ->
    event.preventDefault()

    switch @currentTab
      when "name" then @addPersonWithName()
      when "label" then @addPersonWithLabel()
      else alert "invalid tab `#{@currentTab}'"

  addPersonWithName: ->
    characteristic = new App.Models.Characteristic type: "Name", place: $('input.place').val(), date: $('input.date').val(), trust: @trust
    characteristic.parts = @name.parts

    persona = new App.Models.Persona label: @name.original
    persona.addCharacteristic characteristic
    @collection.add persona
    @hide()

  addPersonWithLabel: ->
    persona = new App.Models.Persona label: $('input.label').val()
    @collection.add persona
    @hide()

App.include App.Views.AddPerson, App.Mixins.NameParsing
App.include App.Views.AddPerson, App.Mixins.Trust
