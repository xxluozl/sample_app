class PasswordResetsController < ApplicationController
  before_action :set_and_validate_user, only: [:edit, :update]
  before_action :check_reset_expiration, only: [:edit, :update]

  def new
  end

  def edit
  end

  def create
    user = User.find_by(email: params[:password_reset][:email])
    if user
      user.create_reset_digest
      user.send_password_reset_email
      redirect_to new_password_reset_path, notice: '重置密码邮件已发送'
    else
      flash.now[:alert] = '邮件地址不存在！'
      render :new
    end
  end

  def update
    if params[:user][:password].blank?
      @user.errors.add(:password, t("errors.messages.blank"))
      render :edit
    elsif @user.update(user_params)
      reset_session
      @user.update_attribute(:reset_digest, nil)
      redirect_to login_path, notice: '密码重置成功，请重新登录！'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_and_validate_user
    @user = User.find_by(email: params[:email])
    unless @user && @user.activated? && @user.authenticate?(:reset, params[:id])
      redirect_to root_path, alert: '验证失败！'
    end
  end

  def check_reset_expiration
    if @user.reset_token_expired?
      redirect_to new_password_reset_path, alert: '密码重置链接已过期！'
    end
  end
end
