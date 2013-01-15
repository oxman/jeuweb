require 'test_helper'

class ReadMarkTest < ActiveSupport::TestCase
  def test_topic_with_one_unread_reply_is_unread
    user         = FactoryGirl.create(:user)
    topic        = FactoryGirl.create(:topic)
    first_reply  = FactoryGirl.create(:reply, topic: topic)
    second_reply = FactoryGirl.create(:reply, topic: topic)
    last_reply   = FactoryGirl.create(:reply, topic: topic)
    ReadMark.create(user: user, topic: topic, reply: first_reply)
    topic.update_attributes(last_reply: last_reply)

    assert_equal [ topic ], user.unread_topics
    assert_equal false, Topic.with_read_marks_for(user).first.read?
    assert_equal second_reply, topic.first_unread_reply(user)
  end


  def test_topic_with_no_unread_reply_is_read
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)
    reply = FactoryGirl.create(:reply, topic: topic)
    ReadMark.create(user: user, topic: topic, reply: reply)
    topic.update_attributes(last_reply: reply)

    assert_equal [], user.unread_topics
    assert_equal true, Topic.with_read_marks_for(user).first.read?
    assert_equal nil, topic.first_unread_reply(user)
  end


  def test_read_topic_with_no_reply_is_read
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)
    ReadMark.create(user: user, topic: topic)

    assert_equal [], user.unread_topics
    assert_equal true, Topic.with_read_marks_for(user).first.read?
    assert_equal nil, topic.first_unread_reply(user)
  end


  def test_unread_topic_with_no_reply_is_unread
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)

    assert_equal [ topic ], user.unread_topics
    assert_equal false, Topic.with_read_marks_for(user).first.read?
    assert_equal nil, topic.first_unread_reply(user)
  end


  def test_create_read_mark_for_user_and_topic
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)
    user.read_topic(topic)

    assert_equal [], user.unread_topics
  end


  def test_update_read_mark_for_user_and_topic_with_reply
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)
    reply = FactoryGirl.create(:reply, topic: topic)
    user.read_topic(topic, reply)

    assert_equal [], user.unread_topics
    assert_equal 1, ReadMark.count, 'No additional mark should be created'
  end
end
