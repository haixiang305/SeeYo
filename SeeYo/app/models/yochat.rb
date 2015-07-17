class Yochat < ActiveRecord::Base
	validates_presence_of :content, :share_with, :user_id
	belongs_to :user
	has_many :comments, :dependent => :destroy
end
