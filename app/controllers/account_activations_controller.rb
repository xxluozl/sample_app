class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticate?(:activation, params[:id])
      user.activate_account
      reset_session
      log_in(user)
      redirect_to user_path(user), notice: '账户已激活！'
    else
      redirect_to root_path, alert: '账户已激活或无效！'
    end
  end
end
