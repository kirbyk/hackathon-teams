desc "Change accepted hackers to declined"
task :decline => :environment do
  a = Status.where("name = 'Accepted'").first.id
  d = Status.where("name = 'Declined'").first.id
  Hacker.all.where("status_id = (#{a})").each do |hacker|
    puts hacker.email
    hacker.status_id = d
    hacker.save
  end
end
