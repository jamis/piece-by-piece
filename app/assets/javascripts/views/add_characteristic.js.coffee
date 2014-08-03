class App.Views.AddCharacteristic extends App.Views.Dialog
  template: "add_characteristic"

  events:
    'click .back a'    : 'cancel'
    'click .next a'    : 'next'
    'click .part'      : 'showPartMenu'
    'menu:click'       : 'menuCommand'
    'click .trust'     : 'changeTrust'
    'change input.name': 'parseName'
    'change select'    : 'onChangeCharacteristicType'
    'keypress'         : 'onKeyPress'

  initialize: (options) ->
    super(options)

    @persona = options.persona
    @characteristic = options.characteristic
    @initialType = @characteristic?.get?('type')
    @initialValue = @characteristic?.compositeValue?() ? ""
    @initialDate = @characteristic?.get?('date') ? options.date
    @initialPlace = @characteristic?.get?('place') ? options.place
    @initialTrust = @characteristic?.get?('trust')
    @initialParts = @characteristic?.get?('parts')

  render: ->
    super
    $(@el).addClass "add-characteristic data-entry"
    @$('input.place').val @initialPlace
    @$('input.date').val @initialDate
    @$('input.value').val @initialValue
    @setTrust @initialTrust
    @changeCharacteristicType @initialType if @initialType?
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

    place = @$('input.place').val()
    date  = @$('input.date').val()
    trust = @getTrust()
    parts = if @name? then @name.parts else [ content: @$('.value').val() ]

    if @persona?
      characteristic = new App.Models.Characteristic type: @type, place: place, date: date, trust: trust, parts: parts
      @persona.get('characteristics').add characteristic
    else if @characteristic?
      @characteristic.set type: @type, place: place, date: date, trust: trust, parts: parts

    @hide()

  onChangeCharacteristicType: (event) ->
    select = event.target
    selection = $(select).val()

    if selection is "-"
      select.selectedIndex = 0
    else if selection is "+"
      select.selectedIndex = 0
      alert "Someday you'll be able to add another characteristic type"
    else
      @changeCharacteristicType selection

  changeCharacteristicType: (type) ->
    @$('select').val type

    if type is "Name"
      @$('input.value').addClass "name"
      @parseName()

    else
      @$('input.value').removeClass "name"
      @$('.parts-row').removeClass "parsing parsed"
      @$('.parts-row').hide()
      @name = null

    @type = type
    @$('input.value').focus()

App.include App.Views.AddCharacteristic, App.Mixins.NameParsing
App.include App.Views.AddCharacteristic, App.Mixins.Trust
