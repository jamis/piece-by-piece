class App.Views.NewSource extends App.Views.Dialog
  template: "new_source"

  events:
    "click .back a" : "cancel"
    "click button"  : "useSource"

  initialize: (options) ->
    super(options)

    @controller = options.controller
    @under = options.under
    @name = options.name

  useSource: ->
    source = new App.Models.Source
      name    : $('#source_name').val()
      place   : $('#source_subject_place').val()
      date    : $('#source_subject_date').val()
      comments: $('#source_comments').val()
      parent  : @under

    @controller.useSource source
