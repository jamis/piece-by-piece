App.Mixins.Trust =
  changeTrust: (event) ->
    root = $(event.target).closest('.trust')
    $(root).children('span').removeClass 'selected'
    trust = $(event.target).attr 'class'
    @setTrust trust, root

  setTrust: (trust, root) ->
    $root = $(root ? @el)
    $root = $root.find ".trust" unless $root.is ".trust"
    trust ?= "undecided"
    $root.children('span').removeClass 'selected'
    $root.find('input').val trust
    $root.find(".#{trust}").addClass 'selected'

  getTrust: (root) ->
    root = $(root ? @el)
    root.find('.trust input').val()
