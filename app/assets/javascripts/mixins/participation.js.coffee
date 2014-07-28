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

  deleteParticipant: (cid) ->
    list = @getParticipants()
    participant = _.find list, (p) -> p.cid == cid
    list = _.without(list, participant)
    @unset "participants", silent: true
    @set participants: list

  removePersonaAsParticipant: (persona, options) ->
    options ?= {}
    list = @getParticipants()
    list = _.reject list, (p) -> p.get("persona").cid == persona.cid
    @unset "participants", options
    @set { participants: list }, options
