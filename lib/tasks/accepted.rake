desc "Find accepted hackers"
task :findAccepted => :environment do
  a = Status.where("name = 'Accepted'").first.id
  Hacker.all.where("status_id = #{a}").each do |hacker|
    puts hacker.fname + "\t" + hacker.email
  end
end
