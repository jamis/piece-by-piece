window.App =
  Data:        {}
  Mixins:      {}
  Models:      {}
  Collections: {}
  Controllers: {}
  Views:       {}
  Routers:     {}

  extend: (obj, mixin) ->
    mixin.willExtend obj if mixin.willExtend?
    for name, method of mixin
      if name != "willExtend"
        obj[name] = method

  include: (klass, mixin) ->
    App.extend klass.prototype, mixin

$(document).ready ->
  Backbone.history.start()

  $(document).on "click", "a[data-behavior~=start-analysis]", (evt) ->
    evt.preventDefault()
    dlg = new App.Views.RecordFacts().render()
    dlg.show()
