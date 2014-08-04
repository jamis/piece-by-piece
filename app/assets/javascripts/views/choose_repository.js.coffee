class App.Views.ChooseRepository extends App.Views.Dialog
  template: "choose_repository"

  events:
    "click .back a" : "cancel"
    "click .next a" : "newRepository"
    "click a.help"  : "showHelp"
    "click .new a"  : "newRepository"
    "click .match"  : "useRepository"

  initialize: (options) ->
    super(options)
    @controller = (options ? {}).controller

  prepareCollection: ->
    @collection = new App.Collections.Repositories
    @collection.url = $('meta[name=repositories_path]', document)[0].content

  showHelp: (evt) ->
    evt.preventDefault()
    new App.Views.HelpDialog(el: @$('.dialog.help'), event: event, template: "templates/help/repository").render()

  newRepository: (evt) ->
    evt.preventDefault()
    @controller.newRepository @text

  useRepository: (evt) ->
    evt.preventDefault()
    @controller.repository = $(event.target).data 'repository'
    @controller.chooseSource()

  renderMatches: (text, matches) ->
    list = @$('.matches')
    list.empty()

    if matches.length is 0
      list.append "<li class=\"new\">No matches for \"#{text}\". Would you like to <a href=\"#\">add a new repository</a>?</li>"
    else
      list.append "<li class=\"new\">Choose one of the matches below, or <a href=\"#\">add a new repository</a>.</li>"
      _.each matches, (repo) ->
        li = $(document.createElement 'li')
        li.addClass "match"
        li.html repo.get 'name'
        li.data 'repository', repo
        list.append li

App.include App.Views.ChooseRepository, App.Mixins.Searching
