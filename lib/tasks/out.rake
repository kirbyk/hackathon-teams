desc "Get output of all hacker status"
task :out => :environment do
  Hacker.all.each do |hacker|
    puts hacker.email + "\t" + hacker.fname + hacker.lname + "\t" + hacker.status.name + "\t" + hacker.school.name
  end
end
