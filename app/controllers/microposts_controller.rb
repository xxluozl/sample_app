class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      redirect_to root_path
    else
      @pagy, @feed_items = pagy(current_user.feed)
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    if @micropost.nil?
      redirect_to root_path
    else
      @micropost.destroy
      redirect_back(fallback_location: root_path) #redirect_back 方法重定向到请求之前的页面，源码也是通过referrer实现的
      # redirect_to request.referrer.nil? ? root_path : request.referrer #request.referrer 获取发送该请求的页面链接
    end
  end
end

private

def micropost_params
  params.require(:micropost).permit(
    :content,
    :image
  )
end
