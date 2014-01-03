class Team < ActiveRecord::Base
  has_many :hackers
  def members
    if self.hackers.present?
      return self.hackers.map{ |hacker| hacker.email }.join(', ')
    else
      return self.id.to_s
    end
  end
end
