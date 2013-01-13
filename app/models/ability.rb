class Ability
  include CanCan::Ability


  def initialize(user)
    if user
      can :create, Topic
      can :create, Reply
      can :update, Reply, author_id: user.id
    end
  end
end
