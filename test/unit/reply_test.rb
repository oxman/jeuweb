require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  def test_replies_have_score_for_user
    user        = FactoryGirl.create(:user)
    topic       = FactoryGirl.create(:topic)
    first_reply = FactoryGirl.create(:reply, topic: topic)
    last_reply  = FactoryGirl.create(:reply, topic: topic)
    user.score(first_reply, Score::POSITIVE)

    replies = topic.replies.with_score_values_for(user).order(:id)
    assert_equal 1,   replies[0].score_value
    assert_equal nil, replies[1].score_value
  end


  def test_replies_have_no_score_for_nil_user
    topic = FactoryGirl.create(:topic)
    FactoryGirl.create(:reply, topic: topic)

    replies = topic.replies.with_score_values_for(nil)
    assert_equal nil, replies[0].score_value
  end
end
