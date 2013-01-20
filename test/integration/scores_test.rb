require 'integration_test_helper'

class TagsTest < ActionDispatch::IntegrationTest
  def test_trusted_users_can_score_topics
    user  = FactoryGirl.create(:user, trusted: true)
    topic = FactoryGirl.create(:topic)
    sign_in_as(user)
    visit(topic_path(topic))
    assert find('.score .count').has_content?(0), 'Should have no vote yet'
    find('.score .score_positive').click
    assert find('.score .count').has_content?(1), 'Should report the vote'
    find('.score .score_negative').click
    assert find('.score .count').has_content?(-1), 'Should reverse the existing vote'
  end


  def test_trusted_users_can_score_replies
    user  = FactoryGirl.create(:user, trusted: true)
    topic = FactoryGirl.create(:topic)
    FactoryGirl.create(:reply, topic: topic)
    sign_in_as(user)
    visit(topic_path(topic))
    assert find('.replies .score .count').has_content?(0), 'Should have no vote yet'
    find('.replies .score .score_positive').click
    assert find('.replies .score .count').has_content?(1), 'Should report the vote'
    find('.replies .score .score_negative').click
    assert find('.replies .score .count').has_content?(-1), 'Should reverse the existing vote'
  end
end
