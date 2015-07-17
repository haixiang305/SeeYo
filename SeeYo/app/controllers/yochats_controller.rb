class YochatsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user
  before_action :set_yochat, :only => [:show, :edit, :update, :destroy]

  def create
    @yochat = @user.yochats.build(yochat_params)
    respond_to do |format|
      if @yochat.save
        @float_message = 'Successfully published!'
        format.js
        format.html { redirect_to root_path, notice: 'Yochat was successfully created!' }
      else
        @float_message = 'Failed to publish!'
        format.html { render "create", alert: 'Yochat created faild!' }
      end
    end
  end

  def show
    @comments = @yochat.comments.reverse
    @comment = @yochat.comments.build

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @yochat_id = @yochat.id
    @yochat.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to root_path, notice: 'Yochat was successfully deleted!' }
    end
  end

  private
  def set_user
    @user = current_user
  end

  def set_yochat
    @yochat = Yochat.find(params[:id])
  end

  def yochat_params
    params.require(:yochat).permit(:content, :share_with)
  end

  def yochat_modify
    params.require(:yochat).permit(:share_with)
  end

end
