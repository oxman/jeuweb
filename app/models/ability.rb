class Ability
  include CanCan::Ability


  def initialize(user)
    if user
      can :create, Topic
      can :create, Reply
    end
  end
end
