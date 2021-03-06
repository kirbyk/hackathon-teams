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
      can [:index, :show], :schools, :name => ['Allegheny College',
      'Carnegie Mellon University','DePauw university','Northwestern University',
      'Ohio State University','Ohio University','Penn State University',
      'Purdue University','Rose-Hulman Institute of Technology','Rutgers University',
      'UIUC','University at Buffalo','University of Cincinnati','University of Iowa',
      'University of Maryland','University of Michigan','University of Pittsburgh',
      'University of Waterloo','University of Wisconsin - Madison']
      cannot [:index, :show], :hackers, [:status, :rating, :contact_date,
                                         :team, :rating_avg, :cell,
                                         :tshirt_size, :why]
    elsif user.role? :representative
      cannot :access, [:teams, :stats, :schools]
      can [:index, :show], :hackers,
                           :status_id => Status.where("name = 'Committed'
                                                      OR name = 'Accepted'
                                                      OR name = 'Waitlisted'").map {|s| s.id},
                           :school => School.find(user.school_id)
      cannot [:index, :show], :hackers, [:rating, :github, :contact_date,
                                         :team, :rating_avg, :tshirt_size,
                                         :why, :resume]
    end
  end
end
