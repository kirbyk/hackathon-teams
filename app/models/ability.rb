class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new # guest user

    can [:commit, :committed, :update_commit], :hackers

    if user.role? :super_admin
      can :access, :all
    elsif user.role? :admin
      can [:index, :show], :all
    elsif user.role? :sponsor
      can [:index, :show], :hackers, :status => Status.where("name = 'Committed'").first
      can [:index, :show], :schools
    elsif user.role? :representative
      cannot :access, [:teams, :stats, :schools]
      can [:index, :show], :hackers,
                           :status_id => Status.where("name = 'Committed'
                                                      OR name = 'Accepted'
                                                      OR name = 'Waitlisted'").map {|s| s.id},
                           :school => School.find(user.school_id)
      cannot [:index, :show], :hackers, [:rating, :github, :contact_date,
                                         :team, :rating_avg, :github,
                                         :tshirt_size, :why, :resume]
    end
  end
end
