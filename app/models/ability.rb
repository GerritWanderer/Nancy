class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == "admin"
      can :manage, :all
    elsif user.role == "editor"
      can :manage, [Work, Customer, Location, Contact, Project]
    else user.role == "trainee"
      can :manage, [Work], :user_id => user.id
      can :read, [Customer, Location, Contact, Project]
    end
  end
end
