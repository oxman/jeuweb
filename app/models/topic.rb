class Topic < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :author, class_name: 'User'
  belongs_to :last_reply, class_name: 'Reply'
  belongs_to :last_reply_author, class_name: 'User'

  has_many :taggings
  has_many :tags, through: :taggings

  has_many :replies, extend: Reply::TopicRepliesExtension

  has_many :scores, as: :scorable

  has_many :participations
  has_many :participants, through: :participations, source: :user

  paginates_per 50

  validates_presence_of :title, :content


  def self.public
    where(private: false)
  end


  def self.allowed_for(user)
    allowed_topic_ids = user.participations.select(:topic_id)
    where(private: true, id: allowed_topic_ids)
  end


  def self.with_tags(tags)
    relation = scoped
    tags.each_with_index do |tag, index|
      relation = relation.joins('JOIN taggings AS taggings_%d ON taggings_%d.topic_id = topics.id AND taggings_%d.tag_id = %d' % [ index, index, index, tag.id ])
    end
    relation
  end


  def self.with_read_marks_for(user)
    return scoped unless user
    select('topics.*, CASE WHEN read_marks.id IS NULL THEN 0 WHEN read_marks.reply_id < topics.last_reply_id THEN 0 ELSE 1 END AS read')
    .joins('LEFT JOIN read_marks ON read_marks.topic_id = topics.id AND read_marks.user_id = %d' % [ user.id ])
  end


  def self.with_score_values_for(user)
    return scoped unless user
    select('topics.*, scores.value AS score_value')
    .joins("LEFT JOIN scores ON scores.scorable_type = 'Topic' AND scores.scorable_id = topics.id AND scores.user_id = %d" % [ user.id ])
  end


  def allow(user, from_reply = nil)
    participation = user.participations.where(topic_id: id).first_or_initialize
    participation.update_attributes!(from_reply_id: from_reply && from_reply.id)
  end


  def allowed_replies_for(user)
    if from_reply_id = user.participations.where(topic_id: id).pluck(:from_reply_id)[0]
      replies.where('? <= id', from_reply_id)
    else
      replies.scoped
    end
  end


  def participant_names
    participants.pluck(:name)
  end


  def participant_names=(participant_names)
    self.participants = User.where(name: participant_names)
  end


  def read?
    read_attribute(:read) != 0
  end


  def unread?
    !read?
  end


  def first_unread_reply(user)
    last_read_reply_id = user.read_marks.where(topic_id: id).select(:reply_id).first.try(:reply_id)
    last_read_reply_id && replies.where('id > ?', last_read_reply_id).first
  end


  def tag_with(names)
    taggings.destroy_all
    names.uniq.each do |name|
      tag = Tag.where(name: name).first_or_create!
      taggings.where(tag_id: tag.id).first_or_create!
    end
  end


  def tag_names
    tags.pluck(:name)
  end


  def computed_score
    scores.sum(:value)
  end


  def score_value
    read_attribute(:score_value)
  end


  def to_param
    [ id, title.parameterize ].join('-')
  end
end
