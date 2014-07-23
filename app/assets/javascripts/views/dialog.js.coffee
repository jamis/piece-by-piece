class App.Views.Dialog extends Backbone.View
  tagName: "section"
  className: "dialog"

  render: ->
    $(@el).html JST["templates/#{@template}"](this)
    $(@el).addClass "closed"
    @screen = $(document.createElement "div")
    @screen.addClass "dialog-screen closed"
    this

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
