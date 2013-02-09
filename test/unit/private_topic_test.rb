require 'test_helper'

class PrivateTopicTest < ActiveSupport::TestCase
  def test_allow_user
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:topic)
    topic.allow(user)

    assert Participation.find_by_user_id_and_topic_id(user.id, topic.id)
  end


  def test_no_topic_is_found_for_not_allowed_user
    user  = FactoryGirl.create(:user)
    FactoryGirl.create(:private_topic)

    assert_equal [], Topic.allowed_for(user)
  end


  def test_public_topics_are_ignored
    user  = FactoryGirl.create(:user)
    FactoryGirl.create(:topic)

    assert_equal [], Topic.allowed_for(user)
  end


  def test_topic_is_found_for_allowed_user
    user  = FactoryGirl.create(:user)
    topic = FactoryGirl.create(:private_topic)
    FactoryGirl.create(:private_topic)
    topic.allow(user)

    assert_equal [ topic ], Topic.allowed_for(user)
  end
end
