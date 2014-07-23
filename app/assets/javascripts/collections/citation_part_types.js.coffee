class App.Collections.CitationPartTypes extends Backbone.Collection
  model: App.Models.CitationPartType
 
  comparator: (part) -> part.get 'name'
