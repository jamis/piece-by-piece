class App.Views.HelpDialog extends Backbone.View
  events:
    "click a.ok": "ok"

  initialize: (options) ->
    options ?= {}
    super(options)

    @at = options.at
    @event = options.event
    @template = options.template

  render: ->
    $(@el).html JST[@template](this)
    $(@el).removeClass "closed"

    if @at?
      x = @at.x
      y = @at.y

    else if @event?
      relativeTo = $(@event.target).offsetParent().offset()
      x = @event.pageX - relativeTo.left
      y = @event.pageY - relativeTo.top

    if x?
      $(@el).css left: "#{x}px", top: "#{y}.py"

    this

  ok: (event) ->
    event.preventDefault()
    @delegateEvents {}
    $(@el).addClass "closed"
