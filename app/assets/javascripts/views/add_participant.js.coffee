class App.Views.AddParticipant extends App.Views.Dialog
  template: "add_participant"
  trustClass: "brief"

  events:
    'click .back a'    : 'cancel'
    'click .next a'    : 'next'
    'click .trust'     : 'changeTrust'
    'change select'    : 'addMoreParticipants'

  initialize: (options) ->
    super(options)
    @klass = options.klass
    @personas = options.personas

  render: ->
    super
    $(@el).addClass "add-participant data-entry"
    this

  next: (event) ->
    event.preventDefault()

    participants = []
    @$('table tr.participant').each (index, tr) =>
      persona_cid = $(tr).find('select.persona').val()
      role        = $(tr).find('select.role').val()

      if persona_cid != "-" and role != "-"
        trust       = @getTrust tr
        persona     = @personas.get persona_cid

        participant = new App.Models.Participant
          persona: persona
          role:    role
          trust:   trust
        participants.push participant

    @klass.get('participants').add participants
    @hide()

  addMoreParticipants: (event) ->
    if @$('select option:selected[value="-"]').length is 0
      @$('table').append JST["templates/select_participant"](this)
      @$('table tr').last().find('.autofocus').focus()

App.include App.Views.AddParticipant, App.Mixins.Trust
