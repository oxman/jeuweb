require 'digest/md5'


class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_secure_password

  has_many :topics, foreign_key: 'author_id'
  has_many :read_marks
  has_many :participations

  attr_reader :age

  FORBIDDEN_NAMES = %w( new edit admin )
  validates :name, presence: true, uniqueness: true, exclusion: FORBIDDEN_NAMES
  validates :email, uniqueness: true


  def unread_topics
    Topic
      .joins('LEFT JOIN read_marks ON read_marks.topic_id = topics.id AND read_marks.user_id = %d' % [ id ])
      .where('read_marks.id IS NULL OR read_marks.reply_id < topics.last_reply_id')
  end


  def read_topic(topic, reply = nil)
    if reply # Replace the current last read reply only if the new one is more recent.
      mark = read_marks.where(topic_id: topic.id).first_or_initialize
      mark.reply = reply if mark.reply.nil? || mark.reply_id < reply.id
      mark.save!
    else
      read_marks.where(topic_id: topic.id, reply_id: 0).first_or_create!
    end
  end


  def score(scorable, value)
    Score.transaction do
      score = scorable.scores.where(user_id: id).first_or_initialize
      score.update_attributes!(value: value)
      scorable.update_attributes!(score: scorable.computed_score)
    end
  end


  def avatar_url
    if email
      hash = Digest::MD5.hexdigest(email.downcase)
      "http://www.gravatar.com/avatar/#{hash}?s=80"
    end
  end
end
