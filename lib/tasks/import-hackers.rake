require 'rubygems'
require 'spreadsheet'

task :import => :environment do
  Hacker.create(fname: 'Sean', lname: 'Obrecht', email: 'sobrecht@purdue.edu', github: 'https://github.com/SeanObrecht/', tshirt_size: 'Large', why: 'I should be accepted to BoilerMake because I want to get my foot in the door in hackathon culture and meet people from a bunch of different schools with similar interests to mine and who are incredibly talented at what they do, I feel like I can bring a well balanced set of skills and creativity to the table, and I want to learn.')

  path = File.join(Rails.root,"lib", "tasks","hackers.xls")
  book = Spreadsheet.open(path)
  sheet = book.worksheet(0)

  sheet.each do |row|
    name = row[0].split(' ')
    Hacker.create(fname: name[0], lname: name[1], email: row[1], github: row[2], tshirt_size: row[3], why: row[4])
  end
end
