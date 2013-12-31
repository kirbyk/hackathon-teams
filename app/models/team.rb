class Team < ActiveRecord::Base
  has_many :hackers

  def members
    hackers = self.hackers
    unless hackers.empty?
      arr = []
      self.hackers.each do |hacker|
        arr << hacker.email
      end
      arr.join(', ')
    else
      "#{self.id}"
    end
  end
end
