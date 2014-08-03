class App.Views.AddEvent extends App.Views.Dialog
  template: "add_event"

  events:
    'click .back a'      : 'cancel'
    'click .next a'      : 'next'
    'click .trust'       : 'changeTrust'
    'change select.type' : 'chooseType'
    'keypress'           : 'onKeyPress'

  initialize: (options) ->
    super(options)

    @event = options.event
    @initialDate  = @event?.get?('date') ? options.date
    @initialPlace = @event?.get?('place') ? options.place
    @initialType  = @event?.get?('type')
    @initialName  = @event?.get?('name')
    @initialTrust = @event?.get?('trust') ? "undecided"

  render: ->
    super
    $(@el).addClass "add-event data-entry"

    @$('select.type').val @initialType
    @$('input.name').val @initialName
    @$('input.place').val @initialPlace
    @$('input.date').val @initialDate
    @setTrust @initialTrust
    this

  chooseType: (event) ->
    select = event.target
    selection = $(select).val()

    if selection is "-"
      select.selectedIndex = 0
    else if selection is "+"
      select.selectedIndex = 0
      alert "Someday you'll be able to add different event types!"
    else
      if /^\s*$/.test @$('input.name').val()
        @$('input.name')[0].value = "#{selection}: "
      @$('input.name').focus()

  onEnterPressed: (event) -> @next(event)

  next: (event) ->
    event.preventDefault()

    type = @$('select.type').val()

    if type is "-" or type is "+"
      alert "Please choose the type of this event."
      @$('select.type').focus()
      return

    name = @$('input.name').val()
    if /^\s*$/.test name
      alert "Please enter a name for this event."
      @$('input.name').focus()
      return

    date = @$('input.date').val()
    place = @$('input.place').val()

    if @event
      @event.set type: type, name: name, date: date, place: place, trust: @getTrust()
    else
      event = new App.Models.Event type: type, name: name, date: date, place: place, trust: @getTrust()
      @collection.add event

    @hide()

App.include App.Views.AddEvent, App.Mixins.Trust
