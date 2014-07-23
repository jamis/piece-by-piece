class App.Collections.Personas extends Backbone.Collection
  model: App.Models.Persona
  comparator: (persona) -> persona.get 'label'
