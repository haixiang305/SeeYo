class InfoInterest < ActiveRecord::Base
  belongs_to :information
  belongs_to :interest
end
