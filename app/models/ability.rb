class Ability
  include CanCan::Ability


  def initialize(user)
    if user
      can :create, Topic
      can :update, Topic, author_id: user.id
      can :create, Reply
      can :update, Reply, author_id: user.id
      can :tag, Topic if user.trusted?
    end
  end
end
