class App.Views.NewRepository extends App.Views.Dialog
  template: "new_repository"

  events:
    "click .back a" : "cancel"
    "click button"  : "useRepository"

  initialize: (options) ->
    super(options)
    @controller = options.controller
    @initialName = options.name

  useRepository: ->
    @controller.repository = new App.Models.Repository
      name    : @$('#repository_name').val()
      address : @$('#repository_address').val()
      website : @$('#repository_website').val()
      email   : @$('#repository_email').val()
      phone   : @$('#repository_phone').val()
      comments: @$('#repository_comments').val()

    @controller.chooseSource()
