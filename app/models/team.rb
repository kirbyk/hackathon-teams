class Team < ActiveRecord::Base
  has_many :hackers
  def members
    if self.hackers.present?
      return self.hackers.map{ |hacker| hacker.fname + ' ' + hacker.lname if hacker.lname }.join(', ')
    else
      return self.id.to_s
    end
  end
end
