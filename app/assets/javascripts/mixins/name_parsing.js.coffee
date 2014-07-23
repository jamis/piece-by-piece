App.Mixins.NameParsing =
  parseName: ->
    $('.parts-row').removeClass "parsed"

    text = $('input.name').val()
    return unless /\S/.test(text)
    return if text is @name?.original_text

    $('.parts').empty()
    $('.parts-row').addClass "parsing"

    App.Models.Name.parse text, (success, name) =>
      if success
        @parsedName name
      else
        @failedName name

  parsedName: (name) ->
    @name = name
    $('.parts-row').removeClass("parsing").addClass "parsed"
    $('input.name')[0].value = @name.original
    @renderName()

  renderName: ->
    $('.parts').parents('tr').show()
    $('.parts').empty()

    _.each @name.parts, (part, index) ->
      element = $(document.createElement "div")
      element.html part.content

      if part.type?
        element.addClass "part #{part.type}"
        # setting a numeric 0 results in a value that can't be retrieved, so we
        # convert it to a string, first
        element.data "data-name-part", index+""

      $('.parts').append element

  failedName: (name) ->
    $('.parts-row').removeClass "parsing"
    @name = null
    alert "The name couldn't be parsed (server said \"#{name.error}\").\nPlease wait a minute and try again."

  showPartMenu: (event) ->
    event.stopPropagation()

    index = $(event.target).data "data-name-part"
    part  = @name.parts[index]

    menuItems = []
    menuItems.push { label: "Given name", code: "given", selected: (part.type is "given") }
    menuItems.push { label: "Nickname", code: "nickname", selected: (part.type is "nickname") }
    menuItems.push { label: "Surname", code: "surname", selected: (part.type is "surname") }
    menuItems.push { label: "Title", code: "title", selected: (part.type is "title") }
    menuItems.push { label: "Unknown", code: "unknown", selected: (part.type is "unknown") }
    menuItems.push { separator: true }

    if index > 0
      menuItems.push { label: "Merge with previous", code: "merge-prev" }

    if index < @name.parts.length-1
      menuItems.push { label: "Merge with next", code: "merge-next" }

    if /[- ."',]/.test part.content
      menuItems.push { label: "Split", code: "split" }

    menu = new App.Views.Menu(host: this, index: index, items: menuItems)
    menu.show @el, { x: event.pageX, y: event.pageY }

  menuCommand: (event, menu, item) ->
    menu.hide()

    index = menu.index
    if item.code is "merge-prev"
      @name.mergeBackwardFrom index
    else if item.code is "merge-next"
      @name.mergeForwardFrom index
    else if item.code is "split"
      @name.splitPartAt index
    else
      @name.recastPartAt index, item.code

    @renderName()
