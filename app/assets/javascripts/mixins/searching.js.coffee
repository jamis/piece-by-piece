App.Mixins.Searching =
  willExtend: (klass) ->
    klass._initialize_without_searching = klass.initialize
    klass._hide_without_searching = klass.hide

  initialize: (options) ->
    @text = ""
    @prepareCollection()
    @collection.fetch success: ((c, r) => @fetchSuccess(c, r)), error: ((c, r) => @fetchError(c, r))
    @_initialize_without_searching?(options)

  hide: ->
    clearTimeout @timer if @timer?
    @_hide_without_searching?()

  searchUpdate: ->
    currentText = $('.search_box input').val()
    if currentText isnt @text
      @text = currentText
      @updateResults()
    @timer = setTimeout((=> @searchUpdate()), 100)

  updateResults: ->
    words = @text.replace(/^\s+/, "").replace(/\s+$/, "").replace(/[\\[\](){}+*.?^$]/, "\\\&").split(/\s+/)
    reconstructed = words.join ""

    if reconstructed is ""
      $('.matches').removeClass "open"

    else
      $('.matches').addClass "open"

      patterns = _.map words, (word) -> new RegExp word, "i"

      matches = @collection.allMatching patterns
      @renderMatches words.join(" "), matches

  fetchSuccess: (collection, response) ->
    @searchUpdate()

  fetchError: (collection, response) ->
    alert "Could not load collection data"
