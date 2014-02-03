desc "Get all da resumes"
task :resume => :environment do
  c = Status.where('name = ?','Committed').first.id
  Hacker.where('status_id = ?', c).each do |hacker|
    puts hacker.resume.url
  end
end
