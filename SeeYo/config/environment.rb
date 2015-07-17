# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/mini_magick'

IMG_SIZE_LARGE = 192
IMG_SIZE_NORMAL = 64
IMG_SIZE_SMALL = 32

