require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

#factories

  test "factory category must be valid" do
    category = build(:category)
    assert category.valid?
  end

end
