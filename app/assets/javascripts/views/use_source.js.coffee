class App.Views.UseSource extends App.Views.Dialog
  template: "use_source"

  events:
    'click .back a'                       : 'cancel'
    'click .next a'                       : 'nextAction'
    'click a.option[data-behavior=upload]': 'uploadSomething'
    'click a.option[data-behavior=write]' : 'writeSomething'

  initialize: (options) ->
    super(options)
    @controller = options.controller

  render: ->
    super
    $(@el).addClass "use-source pending"
    this

  nextAction: (event) ->
    event.preventDefault()
    action = $(event.target).attr 'data-behavior'

    switch action
      when 'add-under' then @addUnder()
      when 'use-directly' then @useDirectly()
      when 'next' then @recordFacts()
      else alert "undefined action `#{action}'"

  addUnder: ->
    @controller.newSourceUnderCurrent()

  useDirectly: ->
    $(@el).removeClass("pending").addClass "decided"

  uploadSomething: (evt) ->
    evt.preventDefault()
    alert "fixme (uploadSomething)"

  writeSomething: (evt) ->
    evt.preventDefault()
    alert "fixme (writeSomething)"

  recordFacts: ->
    @controller.recordFacts()
