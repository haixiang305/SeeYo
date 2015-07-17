class StaticpagesController < ApplicationController

  before_filter :authenticate_user!, :except => [:welcome]

  def welcome
    if current_user
      if !current_user.information
        info = current_user.create_information
        info.username = "id" + Time.now.strftime("%Y%m%d%H%M%S")
        info.gender = " "
        info.location = " "
        info.about = " "
        info.birthday = "1990-1-1"
        info.blog = " "
        info.save!
      end
      redirect_to users_path
    end
    @page_title = "Welcome to SeeYo"
  end

  def plaza
    @page_title = "Plaza - where you can make friends with others"
    current_user.yochat_unread = 0
    if params[:operation] == "0"
      @yochats = Yochat.all.reverse
      @active_li = "all_li"
      respond_to do |format|
        format.js
        format.html
      end
    elsif params[:operation] == "1"
      @yochats = Array.new
      focus = Friend.where(:userf_id => current_user.id).pluck(:usert_id)
      zone_yochat = Yochat.where(:share_with => 'zone')
      zone_yochat.each do |zy|
        if focus.include?(zy.user_id)
          @yochats.push(zy)
        end
      end
      @yochats.reverse!
      puts @yochats
      @active_li = "zone_li"
      respond_to do |format|
        format.js
        format.html
      end
    elsif params[:operation] == "2"
      @yochats = Array.new
      friends = Array.new
      focus = Friend.where(:userf_id => current_user).pluck(:usert_id)
      focus.each do |fid|
        if Friend.exists?(:userf_id => fid, :usert_id => current_user.id)
          friends.push(fid)
        end
      end
      circle_yochat = Yochat.where(:share_with => 'circle')
      circle_yochat.each do |cy|
        if friends.include?(cy.user_id)
          @yochats.push(cy)
        end
      end
      @yochats.reverse!
      @active_li = "circle_li"
      respond_to do |format|
        format.js
      end
    elsif params[:operation] == "3"
      @yochats = current_user.yochats.order('created_at DESC')
      @active_li = "private_li"
      respond_to do |format|
        format.js
      end
    else
      @yochats = Yochat.all.reverse
    end
  end
end
