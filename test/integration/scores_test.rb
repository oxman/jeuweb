require 'integration_test_helper'

class TagsTest < ActionDispatch::IntegrationTest
  def test_trusted_users_can_score_topics
    user  = FactoryGirl.create(:user, trusted: true)
    topic = FactoryGirl.create(:topic)
    sign_in_as(user)
    visit(topic_path(topic))
    assert find('.score').has_content?(0)
    find('.score .score_positive').click
    assert find('.score').has_content?(1)
  end
end
