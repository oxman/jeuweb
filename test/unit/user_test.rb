require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_user_can_create_topic
    ability = Ability.new(FactoryGirl.create(:user))
    assert ability.can?(:create, Topic)
  end


  def test_nil_user_cant_create_topic
    ability = Ability.new(nil)
    assert !ability.can?(:create, Topic)
  end


  def test_user_can_edit_its_replies
    reply   = FactoryGirl.create(:reply, author: FactoryGirl.create(:user))
    ability = Ability.new(reply.author)
    assert ability.can?(:update, reply), 'User should be able to edit its reply'
  end


  def test_user_cant_edit_other_users_replies
    reply   = FactoryGirl.create(:reply, author: FactoryGirl.create(:user))
    ability = Ability.new(FactoryGirl.create(:user))
    assert !ability.can?(:update, reply), "User should not be able to edit other user's reply"
  end
end
