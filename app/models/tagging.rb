class Tagging < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :topic
  belongs_to :tag, counter_cache: 'topics_count'
end
