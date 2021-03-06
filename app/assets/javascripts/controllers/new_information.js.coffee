class App.Controllers.NewInformation
  currentView: null
  screen: null

  chooseRepository: ->
    @updateView App.Views.ChooseRepository

  newRepository: (initialText) ->
    @updateView App.Views.NewRepository, name: initialText

  chooseSource: ->
    @updateView App.Views.ChooseSource

  newSource: (initialText) ->
    @updateView App.Views.NewSource, name: initialText

  newSourceUnderCurrent: ->
    @updateView App.Views.NewSource, under: @source

  useSource: (source) ->
    @source = source
    @updateView App.Views.UseSource

  recordFacts: ->
    @updateView App.Views.RecordFacts

  saveFacts: (personas, events, groups) ->
    @personas = personas
    @events   = events
    @groups   = groups

    payload =
      repository: @repository
      source:     @source
      personas:   @personas
      events:     @events
      groups:     @groups

    json = JSON.stringify(payload)
    console.log json

  updateView: (nextView, options={}) ->
    options = _.extend(options, controller: this)

    view = new nextView(options).render()
    @currentView?.hide()
    view.show()
    @currentView = view
