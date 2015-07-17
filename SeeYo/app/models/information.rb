class Information < ActiveRecord::Base
  has_many :info_interests, :dependent => :destroy
  has_many :interests, :through => :info_interests
  belongs_to :user

  mount_uploader :avatar, AvatarUploader
end
