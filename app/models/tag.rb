class Tag < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :taggings
  has_many :topics, through: :taggings
end
