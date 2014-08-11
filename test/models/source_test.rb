require 'test_helper'

class SourceTest < ActiveSupport::TestCase
  test "should link to parent if parent is given" do
    source = Source.create! name: "hello",
      parent_attrs: { id: sources(:us_census_1880).id }
    assert_equal sources(:us_census_1880), source.parent
  end

  test "should link up multiple levels of parents" do
    source = Source.create! name: "hello",
      parent_attrs: {
        name: "goodbye",
        parent_attrs: {
          name: "other",
          parent_attrs: { id: sources(:us_census_1880).id } } }

    assert_equal "goodbye", source.parent.name
    assert_equal "other", source.parent.parent.name
    assert_equal sources(:us_census_1880), source.parent.parent.parent
  end
end
