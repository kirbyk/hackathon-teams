desc "Fix githubs"
task :fix_githubs => :environment do
  Hacker.all.each do |hacker|
    next unless hacker.github
    if hacker.github.include? ".com"
      hacker.github = hacker.github.split('/').last
      hacker.save
    end
  end
end
