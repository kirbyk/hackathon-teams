desc "Get output of all hacker status"
task :committed => :environment do
  c = Status.where('name = ?','Committed').first.id
  Hacker.where('status_id = ?', c).each do |hacker|
    puts hacker.email + "\t" + hacker.fname + "\t" + hacker.status.name + "\t" + hacker.school.name
  end
end
