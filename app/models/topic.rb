class Topic < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :author, class_name: 'User'
  belongs_to :last_reply, class_name: 'Reply'
  belongs_to :last_reply_author, class_name: 'User'

  has_many :replies

  paginates_per(50)
end
