class Admin::MessagesController < ApplicationController
  before_action :authenticate

  def index
    @page_title = 'Messages List'
    @messages = Message.order('created_at DESC').page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @messages = @user.messages.order('created_at DESC').page(params[:page]).per(10)
    @page_title = @user.information.username + '\'s Messages'
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to admin_messages_url
    flash[:notice] = 'Message was successful deleted!'
  end

  private
  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      if current_user.is_admin
        user_name == "admin" && password == "yourgod"
      end
    end 
  end

end
