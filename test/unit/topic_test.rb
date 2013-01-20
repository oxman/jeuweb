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
end
