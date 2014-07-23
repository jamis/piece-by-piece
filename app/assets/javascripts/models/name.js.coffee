class App.Models.Name
  constructor: (@original, @callback) ->

  parse: ->
    url = $('meta[name=parse_names_path]', document)[0].content

    $.ajax url,
      type   : "GET"
      data   : { name: @original }
      context: this
      error  : @_error
      success: @_success

  recastPartAt: (index, type) ->
    @parts[index].type = type
    this

  mergeBackwardFrom: (index) ->
    part = @parts[index]
    count = 1
    while index >= 0
      index -= 1
      count += 1
      part.content = @parts[index].content + part.content
      break if /\S/.test @parts[index].content
    @parts.splice index, count, part
    this

  mergeForwardFrom: (index) ->
    part = @parts[index]
    count = 1
    end = parseInt index
    while end < @parts.length
      end += 1
      count += 1
      part.content += @parts[end].content
      break if /\S/.test @parts[end].content
    @parts.splice index, count, part
    this

  splitPartAt: (index) ->
    part = @parts[index]
    pieces = part.content.match(/[- ."',]+|[^- ."',]+/g)
    newParts = _.map pieces, (piece) ->
      if /[- ."',]/.test(piece)
        { content: piece }
      else
        { content: piece, type: part.type }
    @parts.splice index, 1, newParts...
    this

  _success: (data, status, xhr) ->
    delete @error
    @original = data.original
    @parts    = data.parts
    @callback true, this

  _error: (xhr, status, error) ->
    @error = error ? status
    @callback false, this

App.Models.Name.parse = (original, callback) ->
  name = new App.Models.Name original, callback
  name.parse()
  name
