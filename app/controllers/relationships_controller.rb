class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:id])
    current_user.follow(@user)
    respond_to do |format|
      #这里定义响应的形式，rails自动根据请求头的Accept值确定响应返回的是html、js或者其他的形式，相当于if..else语句
      #Accept可以在表单中设置remote或local选项设置返回js或html
      format.html { redirect_to user_path(@user) }
      format.js
    end
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to user_path(@user) }
      format.js
    end
  end
end
