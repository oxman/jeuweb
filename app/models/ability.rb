class Ability
  include CanCan::Ability


  def initialize(user)
    if user
      can :create, Topic
      can :update, Topic, author_id: user.id
      can :reply, Topic do |topic| topic.private? ? topic.participants.include?(user) : true end
      can :update, Reply, author_id: user.id
      can :tag, Topic if user.trusted?
      can :score, Topic if user.trusted?
      can :score, Reply if user.trusted?
    end
  end
end
