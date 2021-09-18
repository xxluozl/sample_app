require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Sample App"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "帮助 | Sample App"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "关于 | Sample App"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "取得联系 | Sample App"
  end
end
