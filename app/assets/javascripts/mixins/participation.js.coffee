App.Mixins.Participation =
  willExtend: (klass) ->
    klass._initialize_without_participation = klass.initialize

  initialize: ->
    @_initialize_without_participation?()

    participants = new App.Collections.Participants

    participants.on "add", => @trigger "change"
    participants.on "remove", => @trigger "change"

    @set 'participants', participants
