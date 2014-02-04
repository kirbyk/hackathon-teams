desc "Waitlisters to rejected list"
task :wtor => :environment do
  s = Status.where('name = ?', 'Waitlisted').first.id
  u = School.where('name = ?', 'Purdue University').first.id
  r = Status.where('name = ?', 'Rejected').first.id
  Hacker.where('status_id = ? and school_id != ?', s, u).each do |hacker|
    hacker.status_id = r
    hacker.save
  end
end
