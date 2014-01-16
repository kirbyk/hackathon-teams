desc "Get output of all hacker status"
task :out => :environment do
  Hacker.all.each do |hacker|
    puts email + "\t" + hacker.fname + "\t" + hacker.status.name
  end
end
