require 'test_helper'

class RecordingTest < ActiveSupport::TestCase
  test "create without repository should fail" do
    assert_raises ArgumentError do
      Recording.create source: { name: "Howdy!" }
    end
  end

  test "creates new repository if id is missing" do
    assert_difference "Repository.count" do
      Recording.create repository: { name: "Some Person" },
        source: { name: "Howdy!" }
    end
  end

  test "uses existing repository if id is present" do
    assert_no_difference "Repository.count" do
      Recording.create repository: repositories(:frederick_parkinson).attributes.symbolize_keys, source: { name: "Howdy!" }
    end
  end

  test "creates new source if id is missing" do
    assert_difference "Source.count" do
      Recording.create repository: { name: "Some Person" },
        source: { name: "Howdy!" }
    end
  end

  test "uses existing source if id is present" do
    assert_no_difference "Source.count" do
      Recording.create repository: { name: "Some Person" },
        source: sources(:us_census_1880).attributes.symbolize_keys
    end
  end

  test "failure to create source should fail to create repo, too" do
    assert_no_difference ["Source.count", "Repository.count"] do
      assert_raises ActiveRecord::StatementInvalid do
        Recording.create repository: { name: "Some Person" }, source: {}
      end
    end
  end
end
