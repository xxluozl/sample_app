require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: "test name",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ''
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = 'name' * 50
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = 'email' * 100 + '@example.com'
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    dup_user = @user.dup
    @user.save
    assert_not dup_user.valid?
  end

  test "email should be saved as lowercase " do
    email_address = "TeStemaIL@qQ.coM"
    @user.email = email_address
    @user.save
    assert_equal @user.reload.email, email_address.downcase
  end

  test "password should be at least 6 chars and not over 72 chars and not blank" do
    @user.password = @user.password_confirmation = 'a' * 73
    assert_not @user.valid?

    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?

    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
    # p @user.errors.full_messages
  end
end
