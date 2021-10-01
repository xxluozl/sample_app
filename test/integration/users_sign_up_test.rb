require "test_helper"

class UsersSignUpTest < ActionDispatch::IntegrationTest
  def set_up
    ActionMailer::Base.deliveries.clear
  end

  test "invalid sign up information " do
    get sign_up_path
    assert_no_changes 'User.count' do
      post users_path, params: { user: {
        name: 'name',
        email: 'email',
        password: 'password',
        password_confirmation: 'password_confirmation'
      } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors', count: 2
  end

  test "valid sign up information " do
    get sign_up_path
    assert_changes 'User.count' do
      post users_path, params: { user: {
        name: 'name',
        email: 'email@qq.com',
        password: 'password',
        password_confirmation: 'password'
      } }
    end
    follow_redirect! #跟踪页面重定向
    assert_template '/'
    assert !is_logged_in?
  end
end
