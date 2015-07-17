class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, :except => [:index]
  before_action :authenticate

  def index
    @page_title = 'Yokers List'
    @users = User.order('created_at DESC').page(params[:page]).per(10)
  end

  def show
    @page_title = @user.information.username + '\'s Profile'
    @info = @user.information
  end

  def edit
    @page_title = 'Send Message'
    @message = Message.new
  end

  def update
    @message = Message.new(message_params)
    @message.user = @user;
    @message.sender_id = current_user.id
    @message.classes = 'system'
    if @message.save
      redirect_to admin_users_url
      flash[:notice] = 'Message was successful sent!'
    else
      render :edit
      flash[:alert] = 'Message sent failed!'
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url
    flash[:notice] = 'User was successful deleted!'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      if current_user.is_admin
        user_name == "admin" && password == "yourgod"
      end
    end 
  end

end
