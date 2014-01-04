class StatsController < ApplicationController
  def index
    
    @applied = Hash.new
    School.all.each { |s| @applied[s.name.to_sym] = s.hackers.count }

    @accepted = Hash.new;
    School.all.each { |s| @accepted[s.name.to_sym] = s.hackers.where("status = 'Accepted'").count }
    
    @waitlisted = Hash.new;
    School.all.each { |s| @waitlisted[s.name.to_sym] = s.hackers.where("status = 'Waitlisted'").count }
    
    @rejected = Hash.new;
    School.all.each { |s| @rejected[s.name.to_sym] = s.hackers.where("status = 'Rejected'").count }
    
  end
end
