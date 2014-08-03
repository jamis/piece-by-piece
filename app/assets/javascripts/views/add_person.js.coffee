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
    'keypress'         : 'onKeyPress'

  initialize: (options) ->
    super(options)

    @date = options.date
    @place = options.place

  render: ->
    super
    $(@el).addClass "add-person data-entry"
    @currentTab = "name"

    @$('input.place').val @place
    @$('input.date').val @date
    this

  onEnterPressed: (event) -> @next(event)

  next: (event) ->
    event.preventDefault()

    switch @currentTab
      when "name" then @addPersonWithName()
      when "label" then @addPersonWithLabel()
      else alert "invalid tab `#{@currentTab}'"

  addPersonWithName: ->
    characteristic = new App.Models.Characteristic type: "Name", place: $('input.place').val(), date: $('input.date').val(), trust: @getTrust()
    characteristic.parts = @name.parts

    persona = new App.Models.Persona label: @name.original
    persona.get('characteristics').add characteristic
    @collection.add persona
    @hide()

  addPersonWithLabel: ->
    persona = new App.Models.Persona label: $('input.label').val()
    @collection.add persona
    @hide()

App.include App.Views.AddPerson, App.Mixins.NameParsing
App.include App.Views.AddPerson, App.Mixins.Trust
