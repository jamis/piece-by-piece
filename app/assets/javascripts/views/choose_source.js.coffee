class App.Views.ChooseSource extends App.Views.Dialog
  template: "choose_source"

  events:
    'click .back a': 'cancel'
    "click a.help" : 'showHelp'
    "click .new a" : 'newSource'
    "click .match" : 'useSource'

  initialize: (options) ->
    super(options)

    @controller = options.controller

  prepareCollection: ->
    @collection = new App.Collections.Sources
    @collection.url = $('meta[name=sources_path]', document)[0].content

  showHelp: (event) ->
    event.preventDefault()
    new App.Views.HelpDialog(el: @$('.dialog.help'), event: event, template: "templates/help/source").render()

  renderMatches: (text, matches) ->
    list = @$('.matches')
    list.empty()

    if matches.length is 0
      list.append "<li class=\"new\">No matches for \"#{text}\". Would you like to <a href=\"#\">add a new source</a>?</li>"
    else
      list.append "<li class=\"new\">Choose one of the matches below, or <a href=\"#\">add a new source</a>.</li>"
      _.each matches, (source) ->
        li = $(document.createElement 'li')
        li.addClass "match"
        li.html source.get 'name'
        li.data 'source', source
        list.append li

  newSource: ->
    @controller.newSource @text

  useSource: (event) ->
    @controller.useSource $(event.target).data 'source'

App.include App.Views.ChooseSource, App.Mixins.Searching
