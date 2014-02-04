desc "Waitlisters to rejected list"
task :pwtor => :environment do
  s = Status.where('name = ?', 'Waitlisted').first.id
  u = School.where('name = ?', 'Purdue University').first.id
  a = Status.where('name = ?', 'Accepted').first.id
  Hacker.where('status_id = ? and school_id = ?', s, u).order('rating DESC').limit(50).each do |hacker|
    hacker.status_id = a
    hacker.save
  end
end
