App.Mixins.Participation =
  getParticipants: ->
    @get("participants") ? []

  addParticipant: (participant) ->
    @addParticipants [participant]

  addParticipants: (participants) ->
    list = @getParticipants()
    list = list.concat(participants)
    @unset "participants", silent: true
    @set participants: list
    this
