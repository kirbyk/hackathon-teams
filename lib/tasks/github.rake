desc "Fix githubs"
task :fix_githubs => :environment do
  Hacker.all.each do |hacker|
    if hacker.github.include? ".com"
      hacker.github = hacker.github.split('/').last
    end
  end
end
