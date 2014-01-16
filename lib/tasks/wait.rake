desc "Move hackers to accepted from the waitlist"
task :wait => :environment do
  emails = ['agahimer@purdue.edu','applet@purdue.edu','burck1@illinois.edu','ccreight@purdue.edu','dzielin@purdue.edu','ewynne@purdue.edu','gbernich@purdue.edu','gupta.522@osu.edu','gupta96@purdue.edu','hsingh23@illinois.edu','jbuschjr@purdue.edu','jhabibi@purdue.edu','johnstal.2@osu.edu','jskubic@purdue.edu','jtmilla2@illinois.edu','kim1035@purdue.edu','kribord@purdue.edu','kwoodwor@purdue.edu','malewadkar.1@osu.edu','marchese.29@buckeyemail.osu.edu','mill1134@purdue.edu','mparat2@illinois.edu','mprovenz@purdue.edu','mpundman@purdue.edu','mquann@purdue.edu','mtmarsh2@illinois.edu','nbalacha@purdue.edu','npabrai@purdue.edu','parikhr@purdue.edu','phadke.18@osu.edu','powerst@purdue.edu','scarmich@purdue.edu','schultz.455@osu.edu','sdkell2@illinois.edu','shah.893@osu.edu','ttrippel@purdue.edu','zpahuja2@illinois.edu']
  
  accepted = Status.find_by_name('Accepted').id
  emails.each do |email|
    hacker = Hacker.find_by_email(email)
    hacker.status_id = accepted
    hacker.contact_date = "01/15/2014"
    puts email
  end
end
