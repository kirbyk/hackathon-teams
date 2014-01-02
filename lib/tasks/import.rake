require 'rubygems'
require 'spreadsheet'
require 'open-uri'
require 'json'
require 'net/http'
require 'nokogiri'

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
      # next if row[9].nil?

      leader = row[3]
      
      teammates = []

      teammates = row[9].split(", ") if row[9]

      team = Team.create
      
      teammates << leader
      
      teammates.each do |mate|
        hacker = Hacker.find_by_email(mate)
        next unless hacker
        
        hacker.team_id = team.id
        hacker.save
        puts mate
      end

    end

    Team.all.each {|team| team.destroy if team.hackers.empty?}
  end

  desc "Scrape github data"
  task :github => :environment do
    sheet = get_spreadsheet

    sheet.each 847 do |row|
      next if row[4].nil?

      github = sanatize_github row[4]
      puts github

      user_page = Nokogiri::HTML(open("https://github.com/#{github}"))

      contributions = user_page.xpath('//*[@id="contributions-calendar"]/div[3]/div[1]/span[1]').text.to_i
      followers = user_page.xpath('//*[@id="site-container"]/div/div/div[1]/div/a[1]/strong').text.to_i
      stars = user_page.xpath('//*[@id="site-container"]/div/div/div[1]/div/a[2]/strong').text.to_i

      hacker = Hacker.find_by_github(github)
      
      hacker.g_contributions = contributions
      hacker.g_followers = followers
      hacker.g_stars = stars
      hacker.save

      puts "#{github} Contributions #{contributions}, Followers #{followers}, Stars #{stars}"

    end

  end
  
  desc "Import Hacker Rankings"
  task :ratings => :environment do
    sheet = get_spreadsheet

    sheet.each 1 do |row|
      next if row[0].nil?

      hacker = Hacker.find_by_email(row[3])

      hacker.rating = row[21].to_f
      hacker.save
      puts row[1]
    end
  end

  desc "Import Team Rankings"
  task :team_ratings => :environment do
    Team.all.each do |team|
      arr = []
      team.hackers.each do |hacker|
        arr << hacker.rating
      end
      
      team.rating_avg = arr.inject{ |sum, el| sum + el }.to_f / arr.size
      team.save
    
    end
  end

end
