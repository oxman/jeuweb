class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_secure_password

  has_many :topics, foreign_key: 'author_id'
  has_many :read_marks


  def unread_topics
    Topic
      .joins('LEFT JOIN read_marks ON read_marks.topic_id = topics.id AND read_marks.user_id = %d' % [ id ])
      .where('read_marks.id IS NULL OR read_marks.reply_id < topics.last_reply_id')
  end


  def read_topic(topic, reply = nil)
    mark = read_marks.where(topic_id: topic.id).first_or_initialize
    mark.update_attributes!(reply_id: reply && reply.id)
  end
end
