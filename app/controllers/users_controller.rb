class UsersController < ApplicationController
  def index
  end

  def show
    if logged_in?
      @user = User.find(params[:id])
    else
      redirect_to login_path, alert: '请先登录！'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in(@user)
      redirect_to user_path(@user), notice: '注册成功！'
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
