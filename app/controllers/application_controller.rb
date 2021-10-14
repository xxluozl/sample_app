class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_path, alert: '请先登录！'
    end
  end
end
