require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  def test_topic_has_score_zero
    topic = FactoryGirl.create(:topic)
    assert_equal 0, topic.score
  end


  def test_topic_has_score_one
    topic = FactoryGirl.create(:topic)
    FactoryGirl.create(:positive_score, scorable: topic)
    FactoryGirl.create(:positive_score, scorable: topic)
    FactoryGirl.create(:negative_score, scorable: topic)
    assert_equal 1, topic.score
  end


  def test_user_can_score_topic_once
    topic = FactoryGirl.create(:topic)
    user = FactoryGirl.create(:user)
    user.score_topic(topic, Score::POSITIVE)
    user.score_topic(topic, Score::POSITIVE)
    assert_equal 1, topic.score
  end


  def test_score_should_be_reversed_when_user_change_vote
    topic = FactoryGirl.create(:topic)
    user = FactoryGirl.create(:user)
    user.score_topic(topic, Score::POSITIVE)
    user.score_topic(topic, Score::NEGATIVE)
    assert_equal -1, topic.score
  end


  def test_user_can_score_reply_once
    topic = FactoryGirl.create(:topic)
    user = FactoryGirl.create(:user)
    user.score(topic, Score::POSITIVE)
    user.score(topic, Score::POSITIVE)
    assert_equal 1, topic.score
  end
end
