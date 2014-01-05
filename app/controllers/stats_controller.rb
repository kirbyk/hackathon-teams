class StatsController < ApplicationController
  def index
    
    @schools = [:'Purdue University',:'UIUC',:'University of Wisconsin - Madison',
                :'Rutgers University',:'Carnegie Mellon University',
                :'Ohio State University',:'University of Maryland',
                :'University of Waterloo',:'University of Michigan',
                :'Rose-Hulman Institute of Technology',:'Northwestern University',
                :'University of Iowa']    

    @applied = Hash.new
    School.all.each { |s| @applied[s.name.to_sym] = s.hackers.count }

    @accepted = Hash.new;
    accepted_id = Status.find_by_name('Accepted').id
    School.all.each { |s| @accepted[s.name.to_sym] = s.hackers.where("status_id = #{accepted_id}").count }
    
    @waitlisted = Hash.new;
    waitlisted_id = Status.find_by_name('Waitlisted').id
    School.all.each { |s| @waitlisted[s.name.to_sym] = s.hackers.where("status_id = #{waitlisted_id}").count }
    
    @rejected = Hash.new;
    rejected_id = Status.find_by_name('Rejected').id
    School.all.each { |s| @rejected[s.name.to_sym] = s.hackers.where("status_id = #{rejected_id}").count }
    
    @commited = Hash.new;
    commited_id = Status.find_by_name('Commited').id
    School.all.each { |s| @commited[s.name.to_sym] = s.hackers.where("status_id = #{commited_id}").count }
    
    @declined = Hash.new;
    declined_id = Status.find_by_name('Declined').id
    School.all.each { |s| @declined[s.name.to_sym] = s.hackers.where("status_id = #{declined_id}").count }
    
    @total = Hash.new
    @total[:applied] = Hacker.all.count
    @total[:accepted] = Hacker.where("status_id = #{accepted_id}").count
    @total[:waitlisted] = Hacker.where("status_id = #{waitlisted_id}").count
    @total[:rejected] = Hacker.where("status_id = #{rejected_id}").count
    @total[:commited] = Hacker.where("status_id = #{commited_id}").count
    @total[:declined] = Hacker.where("status_id = #{declined_id}").count

    @other = Hash.new
    @other[:applied] = @applied.each_value.inject(:+)

  end
end
