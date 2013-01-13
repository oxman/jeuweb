require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_user_can_create_topic
    ability = Ability.new(FactoryGirl.build(:user))
    assert ability.can?(:create, Topic)
  end


  def test_nil_user_cant_create_topic
    ability = Ability.new(nil)
    assert !ability.can?(:create, Topic)
  end
end
