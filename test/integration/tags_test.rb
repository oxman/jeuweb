require 'integration_test_helper'

class TagsTest < ActionDispatch::IntegrationTest
  def test_topics_tag_are_visible
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)
    topic.tag_with(%w( Foo Bar ))
    sign_in_as(user)
    assert find('.tags').has_content?('Foo')
    assert find('.tags').has_content?('Bar')
  end


  def test_trusted_user_can_alter_tag_topic
    user  = FactoryGirl.create(:user, trusted: true)
    topic = FactoryGirl.create(:topic)
    topic.tag_with(%w( Foo ))
    sign_in_as(user)
    visit(topic_path(topic))
    assert find('.tags').has_content?('Foo'), 'Foo tag should be visible'
    fill_in 'tag_names', with: 'Bar'
    find('.change_tags input[type=submit]').click
    assert find('.tags').has_content?('Bar'), 'Bar tag should be visible'
    assert find('.tags').has_no_content?('Foo'), 'Foo tag should not be visible'
  end
end
