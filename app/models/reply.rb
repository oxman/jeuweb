class Reply < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :author, class_name: 'User'
  belongs_to :topic

  has_many :scores, as: :scorable

  paginates_per 50


  def self.with_score_values_for(user)
    return scoped unless user
    select('replies.*, scores.value AS score_value')
    .joins("LEFT JOIN scores ON scores.scorable_type = 'Reply' AND scores.scorable_id = replies.id AND scores.user_id = %d" % [ user.id ])
  end


  def computed_score
    scores.sum(:value)
  end


  def score_value
    read_attribute(:score_value)
  end
end
