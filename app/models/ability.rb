class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new # guest user

    if user.role? :super_admin
      can :manage, :all
    elsif user.role? :admin
      can :read, :all
    elsif user.role? :sponsor
      can :read, Hacker, :status => Status.where("name = 'Committed'").first
      can :read, School
    elsif user.role? :representative
      can :read, Hacker, :status => Status.where("name = 'Committed'").first,
                         :school => School.find(user.school_id)
    end
  end
end
