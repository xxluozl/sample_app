module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id #rails自带的session方法，与Sessions控制器没有关系，作用是在浏览器中创建一个临时的自动加密的cookie并把user.id存入，可以通过session[:user_id]取回，还有一个cookies方法创建的是持久的cookie
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    reset_session  # 也可以使用 session.delete(:user_id)
    @current_user = nil
  end
end
