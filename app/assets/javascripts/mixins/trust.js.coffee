App.Mixins.Trust =
  willExtend: (klass) ->
    klass._initialize_without_trust = klass.initialize

  initialize: (args...) ->
    @trust = "undecided"
    @_initialize_without_trust?(args...)

  changeTrust: (event) ->
    $('.trust *').removeClass 'selected'
    @trust = $(event.target).attr 'class'
    $(event.target).addClass 'selected'
