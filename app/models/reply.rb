class Reply < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :author, class_name: 'User'
  belongs_to :topic

  has_many :scores, as: :scorable

  paginates_per 50


  def score
    scores.sum(:value)
  end
end
