class Score < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  POSITIVE = 1
  NEGATIVE = -1

  belongs_to :scorable, polymorphic: true
  belongs_to :user
end
