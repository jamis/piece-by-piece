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

  initialize: (options) ->
    @persona = options.persona

  render: ->
    super
    $(@el).addClass "l2 add-characteristic data-entry"
    $(@screen).addClass "l2"
    this

  next: (event) ->
    event.preventDefault()

    if not @type?
      alert "Please choose which kind of attribute you are recording."
      $('select').focus()
      return

    if /^\s*$/.test $('.value').val()
      alert "Please describe the attribute you are recording."
      $('.value').focus()
      return

    characteristic = new App.Models.Characteristic type: @type, place: $('input.place').val(), date: $('input.date').val(), trust: @trust
    characteristic.parts = if @name? then @name.parts else [ content: $('.value').val() ]
    @persona.addCharacteristic characteristic

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
        $('input.value').addClass "name"
      else
        $('input.value').removeClass "name"
        $('.parts-row').removeClass "parsing parsed"
        @name = null

      @type = selection
      $('input.value').focus()

App.include App.Views.AddCharacteristic, App.Mixins.NameParsing
App.include App.Views.AddCharacteristic, App.Mixins.Trust
