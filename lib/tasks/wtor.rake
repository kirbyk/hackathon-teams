desc "Waitlisters to rejected list"
task :wtor => :environment do
  s = Status.where('name = ?', 'Accepted').first.id
  p = School.where('name = ?', 'Purdue University').first.id
  r = Status.where('name = ?', 'Waitlisted').first.id
  Hacker.where('status_id = ? and school_id = ?', s, p).each do |hacker|
    hacker.status_id = r
    hacker.save
  end
end
