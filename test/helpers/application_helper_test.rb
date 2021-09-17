require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "should return right title" do
    assert_equal full_title(""), "A Sample App"
    assert_equal full_title("About"), "About | A Sample App"
  end
end
