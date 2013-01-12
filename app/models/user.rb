class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  has_secure_password
  has_many :topics, foreign_key: 'author_id'
end
