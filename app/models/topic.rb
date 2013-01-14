class Topic < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :author, class_name: 'User'
  belongs_to :last_reply, class_name: 'Reply'
  belongs_to :last_reply_author, class_name: 'User'

  has_many :replies

  paginates_per(50)


  def self.with_read_marks_for(user)
    Topic
      .select('topics.*, CASE WHEN read_marks.id IS NULL THEN 0 WHEN read_marks.reply_id < topics.last_reply_id THEN 0 ELSE 1 END AS read')
      .joins('LEFT JOIN read_marks ON read_marks.topic_id = topics.id AND read_marks.user_id = %d' % [ user.id ])
  end


  def read?
    read_attribute(:read) == 1
  end
end
