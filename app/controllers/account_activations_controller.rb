class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticate?(:activation, params[:id])
      user.activate_account
      reset_session
      log_in(user)
      redirect_to user_path(user), notice: '邮箱验证成功！'
    else
      redirect_to root_path, alert: '邮箱已验证或链接已失效！'
    end
  end
end
