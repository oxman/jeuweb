class Tag < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :taggings
  has_many :topics, through: :taggings


  def self.extract(string)
    string.split.join(' ').split(',').map(&:strip).reject(&:blank?).uniq
  end
end
