App.Mixins.Trust =
  changeTrust: (event) ->
    root = $(event.target).closest('.trust')
    $(root).children('span').removeClass 'selected'
    trust = $(event.target).attr 'class'
    $(root).find('input').val trust
    $(event.target).addClass 'selected'

  getTrust: (root) ->
    root = $(root ? @el)
    root.find('.trust input').val()
