class Ability
  include CanCan::Ability


  def initialize(user)
    if user
      can :create, Topic
    end
  end
end
