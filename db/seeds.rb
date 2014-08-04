require 'active_record/fixtures'

ActiveRecord::Fixtures.create_fixtures "#{Rails.root}/test/fixtures", %w(repositories sources citation_part_types)
