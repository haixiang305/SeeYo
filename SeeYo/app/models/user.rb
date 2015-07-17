class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_one :information, :dependent => :destroy
	has_many :yochats, :dependent => :destroy
	has_many :comments, :dependent => :destroy
	has_many :messages, :dependent => :destroy
	has_many :user_interests, :dependent => :destroy
	has_many :interests, :through => :user_interests
end
