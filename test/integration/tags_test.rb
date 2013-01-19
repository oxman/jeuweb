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


  def test_trusted_user_can_alter_tag_topic
    user  = FactoryGirl.create(:user, trusted: true)
    topic = FactoryGirl.create(:topic)
    topic.tag_with(%w( foo ))
    sign_in_as(user)
    visit(topic_path(topic))
    assert find('.tags').has_content?('foo')
    fill_in 'tag_names', with: 'bar'
    find('[type=submit]').click
    assert find('.tags').has_content?('bar')
    assert find('.tags').has_no_content?('foo')
  end
end
