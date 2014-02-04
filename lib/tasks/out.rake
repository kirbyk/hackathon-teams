desc "Get output of all hacker status"
task :out => :environment do
  Hacker.all.each do |hacker|
    puts hacker.email + "\t" + hacker.fname + "\t" + hacker.lname + "\t" + hacker.status.name + "\t" + hacker.school.name + "\t" + hacker.cell
  end
end
