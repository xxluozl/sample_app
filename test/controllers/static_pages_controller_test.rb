require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "A Sample App"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | A Sample App"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | A Sample App"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | A Sample App"
  end
end
