class Interest < ActiveRecord::Base
  has_many :info_interests, :dependent => :destroy
  has_many :information, :through => :info_interests
end
