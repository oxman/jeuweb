require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_user_can_create_topic
    ability = Ability.new(FactoryGirl.create(:user))
    assert ability.can?(:create, Topic), 'User should be able to create topic'
  end


  def test_nil_user_cant_create_topic
    ability = Ability.new(nil)
    assert !ability.can?(:create, Topic), 'Guest user should not be able to create topics'
  end


  def test_user_can_edit_his_topics
    topic   = FactoryGirl.create(:topic)
    ability = Ability.new(topic.author)
    assert ability.can?(:update, topic), 'User should be able to edit his topic'
  end


  def test_user_cant_edit_other_users_topics
    topic   = FactoryGirl.create(:topic)
    ability = Ability.new(FactoryGirl.create(:user))
    assert !ability.can?(:update, topic), "User should not be able to edit other user's topic"
  end


  def test_user_can_edit_his_replies
    reply   = FactoryGirl.create(:reply)
    ability = Ability.new(reply.author)
    assert ability.can?(:update, reply), 'User should be able to edit his reply'
  end


  def test_user_cant_edit_other_users_replies
    reply   = FactoryGirl.create(:reply)
    ability = Ability.new(FactoryGirl.create(:user))
    assert !ability.can?(:update, reply), "User should not be able to edit other user's reply"
  end


  def test_nil_user_cant_edit_other_users_replies
    reply   = FactoryGirl.create(:reply)
    ability = Ability.new(nil)
    assert !ability.can?(:update, reply), "Guest user should not be able to edit any reply"
  end


  def test_user_can_reply_to_public_topic
    topic   = FactoryGirl.create(:topic)
    ability = Ability.new(FactoryGirl.create(:user))
    assert ability.can?(:reply, topic), "User should be able to reply to a public topic"
  end


  def test_user_participating_to_a_private_topic_can_reply
    user    = FactoryGirl.create(:user)
    topic   = FactoryGirl.create(:private_topic)
    ability = Ability.new(user)
    topic.allow(user)
    assert ability.can?(:reply, topic), "User participating to a private topic can reply"
  end


  def test_user_not_participating_to_a_private_topic_cant_reply
    user    = FactoryGirl.create(:user)
    topic   = FactoryGirl.create(:private_topic)
    ability = Ability.new(user)
    assert !ability.can?(:reply, topic), "User not participating to a private topic can't reply"
  end


  def test_trusted_user_can_tag_other_users_topics
    topic   = FactoryGirl.create(:topic)
    ability = Ability.new(FactoryGirl.create(:user, trusted: true))
    assert ability.can?(:tag, topic), "Trusted user should be able to edit other user's topic"
  end


  def test_untrusted_user_cant_tag_other_users_topics
    topic   = FactoryGirl.create(:topic)
    ability = Ability.new(FactoryGirl.create(:user))
    assert !ability.can?(:tag, topic), "Untrusted user should not be able to edit other user's topic"
  end


  def test_nil_user_cant_tag_other_users_topics
    topic   = FactoryGirl.create(:topic)
    ability = Ability.new(nil)
    assert !ability.can?(:tag, topic), "Guest user should not be able to edit other user's topic"
  end


  def test_trusted_user_can_score_topics
    topic   = FactoryGirl.create(:topic)
    ability = Ability.new(FactoryGirl.create(:user, trusted: true))
    assert ability.can?(:score, topic), 'Trusted user should be able to score topics'
  end


  def test_untrusted_user_cant_score_topics
    topic   = FactoryGirl.create(:topic)
    ability = Ability.new(FactoryGirl.create(:user))
    assert !ability.can?(:score, topic), 'Untrusted user should not be able to score topics'
  end


  def test_nil_user_cant_score_topics
    topic   = FactoryGirl.create(:topic)
    ability = Ability.new(nil)
    assert !ability.can?(:score, topic), 'Guest user should not be able to edit topics'
  end
end
