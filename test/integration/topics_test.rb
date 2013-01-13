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
    user  = FactoryGirl.create(:user)
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
    find('.edit_reply').click
    fill_in 'reply[content]', with: 'New reply content'
    find('[type=submit]').click
    assert has_content?('New reply content')
  end


  def test_user_can_edit_his_topics
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic, author: user)
    sign_in_as(user)
    visit topic_path(topic)
    assert has_selector?('.edit_topic'), 'User should see the edit link of his topic'
    find('.edit_topic').click
    fill_in 'topic[title]', with: 'New topic title'
    fill_in 'topic[content]', with: 'New topic content'
    find('[type=submit]').click
    assert has_content?('New topic title')
    assert has_content?('New topic content')
  end


  def test_user_cant_edit_other_users_topics
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic, author: FactoryGirl.create(:user))
    sign_in_as(user)
    visit topic_path(topic)
    assert has_no_selector?('.edit_topic'), "User should not see the edit link of other user's topic"
  end
end
