class Recording
  def self.create(attributes)
    repo_attrs = attributes[:repository]
    raise ArgumentError, "no :repository" unless repo_attrs

    source_attrs = attributes[:source]
    raise ArgumentError, "no :source" unless source_attrs

    repo_attrs = repo_attrs.slice :id, :name, :address, :website, :email, :phone, :comments
    source_attrs = source_attrs.slice :id, :name, :subject_place, :subject_date, :parent

    ActiveRecord::Base.transaction do
      repository = if repo_attrs.key? :id
          Repository.find(repo_attrs[:id])
        else
          Repository.create!(repo_attrs)
        end

      source = if source_attrs.key? :id
          Source.find(source_attrs[:id])
        else
          Source.create!(source_attrs)
        end
    end
  end
end
