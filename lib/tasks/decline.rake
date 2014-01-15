desc "Change accepted hackers to declined"
task :decline => :environment do
  a = Status.where("name = 'Accepted'").map {|s| s.id}
  d = Status.where("name = 'Declined'").map {|s| s.id}
  Hacker.all.where("status_id = (#{a})").each do |hacker|
    puts hacker.email
    hacker.status_id = d
    hacker.save
  end
end
