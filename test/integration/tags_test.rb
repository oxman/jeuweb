require 'integration_test_helper'

class TagsTest < ActionDispatch::IntegrationTest
  def test_topics_tag_are_visible
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)
    topic.tag_with(%w( foo bar ))
    sign_in_as(user)
    assert find('.tags').has_content?('foo')
    assert find('.tags').has_content?('bar')
  end
end
