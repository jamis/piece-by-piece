class CitationPart < ActiveRecord::Base
  belongs_to :source
  belongs_to :citation_part_type

  delegate :name, to: :citation_part_type
end
