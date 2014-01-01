require 'rubygems'
require 'spreadsheet'

namespace :import do
  def get_spreadsheet
    path = File.join(Rails.root,"lib", "tasks","hackers.xls")
    book = Spreadsheet.open(path)
    book.worksheet(0)
  end
  
  def sanatize_github str
    if str
      return str.split("/").last
    else
      return ''
    end
  end

  desc "Import the schools"
  task :schools => :environment do
    sheet = get_spreadsheet

    sheet.each 1 do |row|
      School.create(name: row[2])
      puts row[2]
    end

  end

  desc "Import the hackers"
  task :hackers => :environment do
    sheet = get_spreadsheet

    sheet.each 1 do |row|
      next if row[0].nil?
      puts row[1]

      name = row[1].split(' ')
      school_id = School.find_by_name(row[2]).id
      github = sanatize_github row[4]

      Hacker.create(fname: name[0], lname: name[1], school_id: school_id, email: row[3], github: github, tshirt_size: row[7], why: row[8])
    end
  end

  desc "Import the teams"
  task :teams => :environment do
    sheet = get_spreadsheet

    sheet.each 1 do |row|
      next if row[9].nil?

      leader = row[3]
      teammates = row[9].split(", ")

      team = Team.create
      
      teammates << leader
      
      teammates.each do |mate|
        hacker = Hacker.find_by_email(mate)
        next unless hacker
        
        hacker.team_id = team.id
        hacker.save
        puts mate
      end

      Team.all.each {|team| team.destroy if team.hackers.empty?}
    end

  end

end
