class App.Collections.Participants extends Backbone.Collection
  model: App.Models.Participant

  withPersona: (persona) ->
    @filter (participant) ->
      participant.get('persona').cid is persona.cid
