class Admin::CommentsController < ApplicationController
  before_action :set_comment, :except => [:index]
  before_action :authenticate
  
  def index
    @page_title = 'Comments List'
    @comments = Comment.order('created_at DESC').page(params[:page]).per(10)
  end

  def edit
    @page_title = 'Edit Comment Alarm'
    @message = Message.new
  end

  def update
    @message = Message.new(message_params)
    @message.user = @comment.user
    @message.sender_id = current_user.id
    @message.classes = 'system'
    @message.msg_id = @comment.yochat.id
    if @message.save
      @comment.update(:content => @message.content)
      redirect_to admin_comments_url
      flash[:notice] = 'Message was successful sent!'
    else
      render :edit
      flash[:alert] = 'Message sent failed!'
    end
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
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
