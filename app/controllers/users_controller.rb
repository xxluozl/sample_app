class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update]

  def index
    @pagy, @users = pagy(User.where(activated: true))
  end

  def show
    redirect_to root_path, alert: '账户未激活！' unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      redirect_to root_path, notice: '注册成功，请前往注册邮箱确认账户！'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '修改成功！'
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user.admin?
      user.destroy
      redirect_to users_path, notice: '注销成功！'
    else
      redirect_to users_path, alert: '无权限！'
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

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path, alert: '无权限！' unless current_user?(@user)
  end

  def logged_in_user
    store_location
    redirect_to login_path, alert: '请先登录！' unless logged_in?
  end
end
