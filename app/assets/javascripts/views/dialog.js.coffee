class App.Views.Dialog extends Backbone.View
  tagName: "section"
  className: "dialog"

  initialize: (options) ->
    options ?= {}
    super(options)
    @parent = options.parent

  depth: ->
    node = this
    depth = 1

    while node.parent?
      depth += 1
      node = node.parent

    depth

  render: ->
    depth = @depth()

    $(@el).html JST["templates/#{@template}"](this)
    $(@el).addClass "closed l#{depth}"
    @screen = $(document.createElement "div")
    @screen.addClass "dialog-screen closed l#{depth}"
    this

  onKeyPress: (event) ->
    if (event.which == 13)
      @onEnterPressed(event)

  onEnterPressed: (event) ->
    # nothing

  cancel: (event) ->
    event.preventDefault()
    @hide()

  show: ->
    $('body').append @screen
    $('body').append @el
    setTimeout (=> @_show2()), 0
    this

  _show2: ->
    $(@el).removeClass "closed"
    @screen.removeClass "closed"
    $('.autofocus').focus()

  isShown: ->
    !$(@el).hasClass "closed"

  hide: ->
    $(@el).addClass "closed"
    @screen.remove()
    setTimeout (=> @remove()), 500
    this

  selectTab: (which) ->
    unless @currentTab is which
      $(".tabs .#{@currentTab}").removeClass "selected"
      $(".panel.#{@currentTab}").removeClass "selected"

      @currentTab = which
      $(".tabs .#{which}").addClass "selected"
      $(".panel.#{which}").addClass "selected"

      $(".panel.#{which} .autofocus").focus()

  changeTab: (event) ->
    which = $(event.currentTarget).attr "data-panel"
    @selectTab which
