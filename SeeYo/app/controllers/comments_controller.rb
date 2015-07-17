class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user_yochat

  def create
    @comment = @yochat.comments.build(comment_params)
    @comment.like = 0
    @comment.user = @user
    respond_to do |format|
      if @comment.save
        if @comment.ater_id
          @ater_user = User.find(@comment.ater_id)
          if @ater_user != @user
            Message.create(:user_id => @comment.ater_id, :classes => 'comment', :msg_id => @yochat.id, :sender_id => @user.id)
            @ater_user.increment!(:messages_unread)
          end
        end
        if @yochat.user != @user
          Message.create(:user => @yochat.user, :classes => "yochat", :msg_id => @yochat.id, :sender_id => @user.id)
          @yochat.user.increment!(:messages_unread)
        end
        #Message.create(:user => @yochat.user, :classes => "yochat", :msg_id => @comment.id, :sender_id => @user.id)
        @float_message = "Successfully commented";
        format.js
        format.html { redirect_to root_path, notice: 'Comment was successfully created!' }
      else
        @float_message = "Faild to comment";
        format.html { render "create", alert: 'Comment created faild!' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment_id = @comment.id
    @yochat = @comment.yochat
    @comment.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to root_path, notice: 'Comment was successfully deleted!' }
    end
  end

  def edit
    @comment = @yochat.comments.build(:user => @user, :ater_id => params[:id], :content => 'reply @' + User.find(params[:id]).information.username + ': ')
    respond_to do |format|
      format.js
    end
  end

  private
  def set_user_yochat
    @user = current_user
    @yochat = Yochat.find(params[:yochat_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :ater_id)
  end
end
