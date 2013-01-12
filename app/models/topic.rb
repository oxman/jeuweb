class Topic < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :author, class_name: 'User'
  belongs_to :last_reply
  belongs_to :last_reply_author, class_name: 'User'
end
