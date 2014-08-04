class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string  :name
      t.integer :parent_id
      t.string  :subject_place
      t.string  :subject_date
      t.text    :comments

      t.timestamps
    end

    add_index :sources, :parent_id

    create_table :citation_part_types do |t|
      t.string :code, limit: 10
    end

    add_index :citation_part_types, :code, :unique => true

    create_table :citation_parts do |t|
      t.integer :source_id
      t.integer :citation_part_type_id
      t.string  :value
    end

    add_index :citation_parts, :source_id
  end
end
