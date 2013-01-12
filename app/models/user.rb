class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  has_secure_password
end
