module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id #rails自带的session方法，与Sessions控制器没有关系，作用是在浏览器中创建一个临时的自动加密的cookie并把user.id存入，可以通过session[:user_id]取回，还有一个cookies方法创建的是持久的cookie
    # 防范会话重放攻击
    # 详见 https://bit.ly/33UvK0w
    session[:session_token] = user.session_token
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id # permanent方法存储20年的cookies
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      if user && session[:session_token] == user.session_token
        @current_user = user
      end
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticate?(:remember, cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user && user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    reset_session # 也可以使用 session.delete(:user_id)
    @current_user = nil
  end

  # 存储后面需要使用的地址
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
