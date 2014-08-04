class Source < ActiveRecord::Base
  belongs_to :parent, class_name: "Source"
  has_many   :children, class_name: "Source", foreign_key: :parent_id
  has_many   :citation_parts
end
