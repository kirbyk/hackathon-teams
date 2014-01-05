class StatsController < ApplicationController
  def index
    
    @schools = ['Purdue University','UIUC','University of Wisconsin - Madison',
                'Rutgers University','Carnegie Mellon University',
                'Ohio State University','University of Maryland',
                'University of Waterloo','University of Michigan',
                'Rose-Hulman Institute of Technology','Northwestern University',
                'University of Iowa']    
    
    @applied = Hash.new
    @accepted = Hash.new;
    @waitlisted = Hash.new;
    @rejected = Hash.new;
    @commited = Hash.new;
    @declined = Hash.new;

    accepted_id = Status.find_by_name('Accepted').id
    waitlisted_id = Status.find_by_name('Waitlisted').id
    rejected_id = Status.find_by_name('Rejected').id
    commited_id = Status.find_by_name('Commited').id
    declined_id = Status.find_by_name('Declined').id

    @schools.each do |school|
      s = School.find_by_name(school)
      @applied[school] = s.hackers.count
      @accepted[school] = s.hackers.where("status_id = #{accepted_id}").count
      @waitlisted[school] = s.hackers.where("status_id = #{waitlisted_id}").count
      @rejected[school] = s.hackers.where("status_id = #{rejected_id}").count
      @commited[school] = s.hackers.where("status_id = #{commited_id}").count
      @declined[school] = s.hackers.where("status_id = #{declined_id}").count
    end

    @total = Hash.new
    @total[:applied] = Hacker.all.count
    @total[:accepted] = Hacker.where("status_id = #{accepted_id}").count
    @total[:waitlisted] = Hacker.where("status_id = #{waitlisted_id}").count
    @total[:rejected] = Hacker.where("status_id = #{rejected_id}").count
    @total[:commited] = Hacker.where("status_id = #{commited_id}").count
    @total[:declined] = Hacker.where("status_id = #{declined_id}").count

    @other = Hash.new
    @other[:applied] = @total[:applied] - @applied.each_value.inject(:+)
    @other[:accepted] = @total[:accepted] - @accepted.each_value.inject(:+)
    @other[:waitlisted] = @total[:waitlisted] - @waitlisted.each_value.inject(:+)
    @other[:rejected] = @total[:rejected] - @rejected.each_value.inject(:+)
    @other[:commited] = @total[:commited] - @commited.each_value.inject(:+)
    @other[:declined] = @total[:declined] - @declined.each_value.inject(:+)

  end
end
