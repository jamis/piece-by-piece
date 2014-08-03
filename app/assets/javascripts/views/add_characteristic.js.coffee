class App.Views.AddCharacteristic extends App.Views.Dialog
  template: "add_characteristic"

  events:
    'click .back a'    : 'cancel'
    'click .next a'    : 'next'
    'click .part'      : 'showPartMenu'
    'menu:click'       : 'menuCommand'
    'click .trust'     : 'changeTrust'
    'change input.name': 'parseName'
    'change select'    : 'changeCharacteristicType'
    'keypress'         : 'onKeyPress'

  initialize: (options) ->
    super(options)

    @persona = options.persona
    @date = options.date
    @place = options.place

  render: ->
    super
    $(@el).addClass "add-characteristic data-entry"
    @$('input.place').val @place
    @$('input.date').val @date
    this

  onEnterPressed: (event) -> @next(event)

  next: (event) ->
    event.preventDefault()

    if not @type?
      alert "Please choose which kind of attribute you are recording."
      @$('select').focus()
      return

    if /^\s*$/.test @$('.value').val()
      alert "Please describe the attribute you are recording."
      @$('.value').focus()
      return

    characteristic = new App.Models.Characteristic type: @type, place: @$('input.place').val(), date: @$('input.date').val(), trust: @getTrust()
    characteristic.parts = if @name? then @name.parts else [ content: @$('.value').val() ]
    @persona.get('characteristics').add characteristic

    @hide()

  changeCharacteristicType: (event) ->
    select = event.target
    selection = $(select).val()

    if selection is "-"
      select.selectedIndex = 0
    else if selection is "+"
      select.selectedIndex = 0
      alert "Someday you'll be able to add another characteristic type"
    else
      if selection is "Name"
        @$('input.value').addClass "name"
      else
        @$('input.value').removeClass "name"
        @$('.parts-row').removeClass "parsing parsed"
        @name = null

      @type = selection
      @$('input.value').focus()

App.include App.Views.AddCharacteristic, App.Mixins.NameParsing
App.include App.Views.AddCharacteristic, App.Mixins.Trust
