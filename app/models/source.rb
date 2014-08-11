class Source < ActiveRecord::Base
  belongs_to :parent, class_name: "Source"
  has_many   :children, class_name: "Source", foreign_key: :parent_id
  has_many   :citation_parts

  before_save :process_parent_attrs

  attr_writer :parent_attrs

  private

  def process_parent_attrs
    attrs, @parent_attrs = @parent_attrs, nil
    if attrs
      if attrs[:id]
        self.parent = Source.find(attrs[:id])
      else
        self.parent = Source.create(attrs)
      end
    end
  end
end
