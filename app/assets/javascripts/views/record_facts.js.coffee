class App.Views.RecordFacts extends App.Views.Dialog
  template: "record_facts"
  className: "dialog large"

  events:
    'click .back a'                    : 'cancel'
    'click button.add'                 : 'addAssertion'
    'click [data-behavior~=add-fact]'  : 'addFact'

  initialize: (options) ->
    super(options)

    @_personas = new App.Collections.Personas
    @_personas.bind "add", (persona) => @addPersona persona
    @_personas.bind "change", (persona) => @changePersona persona

    @_events = new App.Collections.Events
    @_events.bind "add", (event) => @addEvent event
    @_events.bind "change", (event) => @changeEvent event

    @_groups = new App.Collections.Groups
    @_groups.bind "add", (group) => @addGroup group
    @_groups.bind "change", (group) => @changeGroup group

  render: ->
    super
    $(@el).addClass "assertions"
    this

  addAssertion: (event) ->
    event.preventDefault()
    how = $(event.currentTarget).attr "data-behavior"
    @openDialog how

  addFact: (event) ->
    event.preventDefault()
    source = $(event.target).attr "data-collection"
    collection = this["_#{source}"]
    cid = $(event.target).attr "data-cid"
    @addFactFor collection.get cid

  addFactFor: (persona) ->
    view = new App.Views.AddCharacteristic
      parent: this
      persona: persona
      date: @lastDate
      place: @lastPlace

    view.render().show()

  openDialog: (which) ->
    switch which
      when "add-person"
        klass = App.Views.AddPerson
        collection = @_personas
      when "add-event"
        klass = App.Views.AddEvent
        collection = @_events
      when "add-group"
        klass = App.Views.AddGroup
        collection = @_groups
      else
        console.log "don't know how to add assertion for `#{which}`"
        klass = null

    return unless klass?

    dialog = new klass
      collection: collection
      date: @lastDate
      place: @lastPlace

    dialog.render().show()

  hideBlankSlateOn: (panel) ->
    $(".content > .#{panel}").addClass "active"

  showBlankSlateOn: (panel) ->
    $(".content > .#{panel}").removeClass "active"

  addPersona: (persona) ->
    characteristics = persona.get('characteristics')
    characteristic = characteristics[characteristics.length-1]
    @lastDate = characteristic.get('date')
    @lastPlace = characteristic.get('place')
    @redrawPeople()

  changePersona: (persona) -> @redrawPeople()

  addEvent: (event) ->
    @lastDate = event.get('date')
    @lastPlace = event.get('place')
    @redrawEvents()

  changeEvent: (event) -> @redrawEvents()

  addGroup: (group) ->
    @lastDate = group.get('date')
    @lastPlace = group.get('place')
    @redrawGroups()

  changeGroup: (group) -> @redrawGroups()

  redrawPeople: -> @redrawCollection "persona", "personas"
  redrawEvents: -> @redrawCollection "event", "events"
  redrawGroups: -> @redrawCollection "group", "groups"

  redrawCollection: (single, plural) ->
    if this["_#{plural}"].length == 0
      @showBlankSlateOn plural
    else
      @hideBlankSlateOn plural

    data = $(".content > .#{plural} .data")
    data.empty()

    this["_#{plural}"].each (item) =>
      this[single] = item
      data.append JST["templates/#{single}"](this)

  # ---- template helper methods ----

  characteristicsByDate: (record) ->
    characteristics = record.get('characteristics') ? []
    _.groupBy characteristics, (c) -> c.get 'date'

  characteristicDate: (date) ->
    date

  characteristicLabel: (characteristic) ->
    type = characteristic.get 'type'
    switch type
      when "name" then "Name"
      else type
