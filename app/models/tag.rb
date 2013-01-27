class Tag < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :taggings
  has_many :topics, through: :taggings


  def self.extract(string)
    string.split(/\s|,/).map { |name| name.strip.humanize }.reject(&:blank?).uniq
  end
end
