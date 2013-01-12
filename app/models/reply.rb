class Reply < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :author
  belongs_to :topic
end
