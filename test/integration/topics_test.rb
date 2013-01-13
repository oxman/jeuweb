# encoding: utf-8
require 'integration_test_helper'

class TopicsTest < ActionDispatch::IntegrationTest
  def test_guest_user_cant_create_topic
    visit('/')
    assert has_no_selector?('.create_topic'), 'Guest user should not see any link to create a topic'
    assert_raise(CanCan::AccessDenied) { visit('/topics/new') }
  end


  def test_signed_in_user_can_create_topic
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    assert has_selector?('.create_topic'), 'Signed in user should see a link to create a topic'
    find('.create_topic').click
    fill_in 'topic[title]', with: 'Some title'
    fill_in 'topic[content]', with: 'Some content'
    find('[type=submit]').click
    assert has_content?('Some title')
    assert has_content?('Some content')
  end


  def test_guest_user_cant_reply_to_topic
    topic = FactoryGirl.create(:topic, author: FactoryGirl.create(:user))
    visit topic_path(topic)
    assert has_no_selector?('.create_reply'), 'Guest user should not see any link to reply to the topic'
    assert_raise(CanCan::AccessDenied) { visit(new_topic_reply_path(topic)) }
  end


  def test_signed_in_user_can_reply_to_topic
    user = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic, author: user)
    sign_in_as(user)
    visit topic_path(topic)
    assert has_selector?('.create_reply'), 'Signed in user should see a link to reply to the topic'
    find('.create_reply').click
    fill_in 'reply[content]', with: 'Some content for reply'
    find('[type=submit]').click
    assert has_content?('Some content for reply')
    assert has_content?('1 réponse')
  end


  def test_user_cant_edit_other_users_replies
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic, author: user)
    FactoryGirl.create(:reply, author: FactoryGirl.create(:user), topic: topic)
    sign_in_as(user)
    visit topic_path(topic)
    assert has_no_selector?('.edit_reply'), "User should not see the edit link of another user's reply"
  end


  def test_user_can_edit_its_own_replies
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic, author: user)
    FactoryGirl.create(:reply, author: user, topic: topic)
    sign_in_as(user)
    visit topic_path(topic)
    assert has_selector?('.edit_reply'), 'User should see the edit link of his replies'
  end
end
