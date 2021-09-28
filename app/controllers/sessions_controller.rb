class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password]) # user&.method <=> user && user.method
      forwarding_url = session[:forwarding_url]
      reset_session #重设会话，用于防止“会话固定”攻击，会话固定指攻击者诱导用户使用攻击者掌握的会话 ID，达到共用会话的目的
      remember(user) if params[:session][:remember_me] == '1'
      log_in(user)
      redirect_to forwarding_url || user_path(user), notice: '登录成功！'
    else
      flash.now[:alert] = '邮件或密码错误！'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
