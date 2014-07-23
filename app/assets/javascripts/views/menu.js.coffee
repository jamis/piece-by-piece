class App.Views.Menu extends Backbone.View
  tagName: "ol"
  className: "menu"

  events:
    "click li.item" : 'chooseItem'

  initialize: (options) ->
    super
    @items = options.items
    @host  = options.host
    @index = options.index

  render: ->
    _.each @items, (item, index) =>
      li = $(document.createElement "li")

      if item.label?
        li.html item.label
        li.addClass "item"
        li.addClass "selected" if item.selected
        li.data "data-index", index+""

      else if item.separator
        li.addClass "separator"
        li.html ""

      $(@el).append li

    @screen = $(document.createElement "div")
    @screen.addClass "menu-screen"

    this

  chooseItem: (event) ->
    event.stopPropagation()
    li = $(event.currentTarget)
    item = @items[li.data "data-index"]
    $(@host.el).trigger "menu:click", [this, item]

  show: (host, at) ->
    @render()

    $('body').append @screen
    $('body').append @el

    $(@el).css('top', at.y).css('left', at.x)

    @screen.click => @hide()

    this

  hide: ->
    @screen.remove()
    @remove()
    this
