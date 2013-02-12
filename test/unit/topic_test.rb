require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def test_topics_have_score_for_user
    user        = FactoryGirl.create(:user)
    first_topic = FactoryGirl.create(:topic)
    last_topic  = FactoryGirl.create(:topic)
    user.score(first_topic, Score::POSITIVE)

    topics = Topic.with_score_values_for(user).order(:id)
    assert_equal 1,   topics[0].score_value
    assert_equal nil, topics[1].score_value
  end


  def test_topics_have_no_score_for_nil_user
    topic = FactoryGirl.create(:topic)
    FactoryGirl.create(:reply, topic: topic)

    topics = Topic.with_score_values_for(nil)
    assert_equal nil, topics[0].score_value
  end


  def test_filter_private_messages
    public_topic  = FactoryGirl.create(:topic)
    private_topic = FactoryGirl.create(:private_topic)

    assert_equal [ public_topic ], Topic.public
    assert_equal [ private_topic ], Topic.private
  end


  def test_add_reply_to_topic
    Timecop.freeze
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)
    reply = topic.replies.add(author: user, content: "Foo")

    assert_equal Time.current, topic.last_activity_at
    assert_equal 1, topic.replies_count
    assert_equal 1, topic.replies.count
    assert_equal reply, topic.last_reply
    assert_equal user, topic.last_reply_author
    assert_equal user, reply.author
  end


  def test_add_reply_validation_fail_doesnt_change_anything
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)
    reply = topic.replies.add(author: user)

    assert_equal false, reply.valid?
    assert_equal nil, topic.last_activity_at
    assert_equal 0, topic.replies_count
    assert_equal 0, topic.replies.count
    assert_equal nil, topic.last_reply
    assert_equal nil, topic.last_reply_author
    assert_equal user, reply.author
  end
end
