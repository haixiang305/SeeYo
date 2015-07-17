class Admin::YochatsController < ApplicationController
  before_action :set_yochat, :except => [:index]
  before_action :authenticate
  
  def index
    @page_title = 'Yochats List'
    @yochats = Yochat.order('created_at DESC').page(params[:page]).per(10)
  end

  def show
    @comments = Comment.where(:yochat => @yochat).order('created_at DESC').page(params[:page]).per(10)
  end

  def edit
    @page_title = 'Edit Yochat Alarm'
    @message = Message.new
  end

  def update
    @message = Message.new(message_params)
    @message.user = @yochat.user
    @message.sender_id = current_user.id
    @message.classes = 'system'
    @message.msg_id = @yochat.id
    if @message.save
      @yochat.update(:content => @message.content)
      redirect_to admin_yochats_url
      flash[:notice] = 'Message was successful sent!'
    else
      render :edit
      flash[:alert] = 'Message sent failed!'
    end
  end

  private
  def set_yochat
    @yochat = Yochat.find(params[:id])
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
