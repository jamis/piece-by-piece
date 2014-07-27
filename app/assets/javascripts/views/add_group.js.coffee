class App.Views.AddGroup extends App.Views.Dialog
  template: "add_group"

  events:
    'click .back a'      : 'cancel'
    'click .next a'      : 'next'
    'click .trust'       : 'changeTrust'
    'change select.type' : 'chooseType'
    'keypress'           : 'onKeyPress'

  initialize: (options) ->
    super(options)

    @date = options.date
    @place = options.place

  render: ->
    super
    $(@el).addClass "add-group data-entry"

    @$('input.place').val @place
    @$('input.date').val @date
    this

  chooseType: (event) ->
    select = event.target
    selection = $(select).val()

    if selection is "-"
      select.selectedIndex = 0
    else if selection is "+"
      select.selectedIndex = 0
      alert "Someday you'll be able to add different group types!"
    else
      if /^\s*$/.test @$('input.name').val()
        @$('input.name')[0].value = "#{selection}: "
      @$('input.name').focus()

  onEnterPressed: (event) -> @next(event)

  next: (event) ->
    event.preventDefault()

    type = @$('select.type').val()

    if type is "-" or type is "+"
      alert "Please choose the type of this group."
      @$('select.type').focus()
      return

    name = @$('input.name').val()
    if /^\s*$/.test name
      alert "Please enter a name for this group."
      @$('input.name').focus()
      return

    date = @$('input.date').val()
    place = @$('input.place').val()

    group = new App.Models.Group type: type, name: name, date: date, place: place, trust: @getTrust()
    @collection.add group

    @hide()

App.include App.Views.AddGroup, App.Mixins.Trust
