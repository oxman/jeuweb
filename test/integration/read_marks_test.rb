require 'integration_test_helper'

class ReadMarksTest < ActionDispatch::IntegrationTest
  def test_topics_are_emphasised_until_the_user_read_it
    Reply.paginates_per(50)
    user         = FactoryGirl.create(:user)
    topic        = FactoryGirl.create(:topic)
    first_reply  = FactoryGirl.create(:reply, topic: topic)
    second_reply = FactoryGirl.create(:reply, topic: topic)
    last_reply   = FactoryGirl.create(:reply, topic: topic)
    ReadMark.create(user: user, topic: topic, reply: first_reply)
    topic.update_attributes(last_reply: last_reply)
    sign_in_as(user)
    assert has_selector?('.unread'), 'Topic should be emphasised for user'
    visit(topic_path(topic))
    visit(root_path)
    assert has_no_selector?('.unread'), 'Topic should not be emphasised anymore'
  end


  def test_topics_are_emphasised_until_the_user_read_the_last_reply
    Reply.paginates_per(1)
    user         = FactoryGirl.create(:user)
    topic        = FactoryGirl.create(:topic)
    first_reply  = FactoryGirl.create(:reply, topic: topic)
    second_reply = FactoryGirl.create(:reply, topic: topic)
    last_reply   = FactoryGirl.create(:reply, topic: topic)
    topic.update_attributes(last_reply: last_reply)
    sign_in_as(user)
    visit(topic_path(topic))
    find('.next a').click
    visit(root_path)
    assert has_selector?('.unread'), 'Topic should still be emphasised for user'
    visit(topic_path(topic))
    find('.last a').click
    visit(root_path)
    assert has_no_selector?('.unread'), 'Topic should not be emphasised anymore'
  end
end
