desc "Find accepted hackers"
task :findAccepted => :environment do
  a = Status.where("name != 'Accepted' AND name != 'Rejected'").map {|s| s.id}
  Hacker.all.where("status_id IN (#{a.join(',')})").each do |hacker|
    puts hacker.fname + "\t" + hacker.email
  end
end
