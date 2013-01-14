require 'test_helper'

class ReadMarkTest < ActiveSupport::TestCase
  def test_topic_with_one_unread_reply_is_unread
    user        = FactoryGirl.create(:user)
    topic       = FactoryGirl.create(:topic)
    first_reply = FactoryGirl.create(:reply, topic: topic)
    last_reply  = FactoryGirl.create(:reply, topic: topic)
    ReadMark.create(user: user, topic: topic, reply: first_reply)
    topic.update_attributes(last_reply: last_reply)

    assert_equal [ topic ], user.unread_topics
  end


  def test_topic_with_no_unread_reply_is_read
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)
    reply = FactoryGirl.create(:reply, topic: topic)
    ReadMark.create(user: user, topic: topic, reply: reply)
    topic.update_attributes(last_reply: reply)

    assert_equal [], user.unread_topics
  end


  def test_read_topic_with_no_reply_is_read
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)
    ReadMark.create(user: user, topic: topic)

    assert_equal [], user.unread_topics
  end


  def test_unread_topic_with_no_reply_is_unread
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)

    assert_equal [ topic ], user.unread_topics
  end
end
