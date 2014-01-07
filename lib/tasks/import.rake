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

  def get_name str
    arr = Array.new
    if (/^[\w'-]+ Van [\w'-]+$/ =~ str) == 0
      arr[0] = str.split(' ')[0]
      arr[1] = str.split(' ')[1] + ' ' + str.split[2]
    elsif (/^[\w'-]+ [\w'-]+$/ =~ str) == 0
      arr[0] = str.split(' ')[0]
      arr[1] = str.split(' ')[1]
    elsif (/^[\w'-]+ [\w'-.]+ [\w'-]+$/ =~ str) == 0
      arr[0] = str.split(' ')[0]
      arr[1] = str.split(' ')[2]
    elsif (/^[\w'-]+$/ =~ str) == 0
      arr[0] = str.split(' ')[0]
      arr[1] = ''
    elsif (/^[\w'-]+ \([\w'-]+\) [\w'-]+$/ =~ str) == 0
      arr[0] = str.split(' ')[0]
      arr[1] = str.split(' ')[2]
    elsif (/^[\w'-]+ [\w'-]+ \([\w'-]+\)$/ =~ str) == 0
      arr[0] = str.split(' ')[0]
      arr[1] = str.split(' ')[1]
    elsif (/^[\w]+ [\w'-]+ [\w'-]+$/ =~ str) == 0
      arr[0] = str.split(' ')[0] + ' ' + str.split(' ')[1]
      arr[1] = str.split(' ')[2]
    elsif (/^[\w]+ [\w'-]+ [\w'-]+ [\w'-]+$/ =~ str) == 0
      arr[0] = str.split(' ')[0]
      arr[1] = str.split(' ')[1] + ' ' + str.split(' ')[2] + ' ' + str.split(' ')[3]
    else
      arr[0] = str.split(' ')[0]
      arr[1] = str.split(' ')[1]
    end
    arr
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
    puts "Importing Schools..."
    sheet = get_spreadsheet

    sheet.each 1 do |row|
      School.create(name: row[2])
    end
    puts "Schools Complete"
  end

  desc "Import the hackers"
  task :hackers => :environment do
    puts "Importing Hackers..."
    sheet = get_spreadsheet

    sheet.each 1 do |row|
      next if row[0].nil?

      name = get_name(row[1])
      school_id = School.find_by_name(row[2]).id
      github = sanatize_github row[4]

      Hacker.create(fname: name[0], lname: name[1], school_id: school_id, email: row[3], github: github, tshirt_size: row[7], why: row[8])
      puts name[0]
    end
    puts "Hackers Complete"
  end

  desc "Import the teams"
  task :teams => :environment do
    puts "Importing Teams..."
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
      end
    end

    Team.all.each {|team| team.destroy if team.hackers.empty?}
    puts "Teams Complete"
  end

  desc "Scrape github data"
  task :github => :environment do
    puts "Importing Github Data... (this might take up to 5 minutes)"
    sheet = get_spreadsheet

    sheet.each 1 do |row|
      next if row[4].nil?

      github = sanatize_github row[4]

      user_page = Nokogiri::HTML(open("https://github.com/#{github}"))

      contributions = user_page.xpath('//*[@id="contributions-calendar"]/div[3]/div[1]/span[1]').text.to_i
      followers = user_page.xpath('//*[@id="site-container"]/div/div/div[1]/div/a[1]/strong').text.to_i
      stars = user_page.xpath('//*[@id="site-container"]/div/div/div[1]/div/a[2]/strong').text.to_i

      hacker = Hacker.find_by_github(github)
      
      hacker.g_contributions = contributions
      hacker.g_followers = followers
      hacker.g_stars = stars
      hacker.save

    end
    puts "Github Complete"
  end
  
  desc "Import Hacker Ratings"
  task :ratings => :environment do
    puts "Importing ratings..."
    sheet = get_spreadsheet

    sheet.each 1 do |row|
      next if row[0].nil?

      hacker = Hacker.find_by_email(row[3])

      next if hacker.nil?
      hacker.rating = row[0].to_f
      hacker.save
    end
    puts "Ratings complete"
  end

  desc "Import Team Ratings"
  task :team_ratings => :environment do
    puts "Importing team ratings..."
    Team.all.each do |team|
      arr = []
      team.hackers.each do |hacker|
        arr << hacker.rating
      end
      
      team.rating_avg = arr.inject{ |sum, el| sum + el }.to_f / arr.size
      team.save
    end
    puts "Team Ratings Complete"
  end

  desc "Import Hacker Statuses"
  task :statuses => :environment do
    puts "Importing Statuses..."
    sheet = get_spreadsheet

    sheet.each 1 do |row|
      next if row[0].nil?

      hacker = Hacker.find_by_email(row[3])
      
      hacker.status_id = Status.find_by_name(row[5]).id
      hacker.save
    end
    puts "Statuses Complete"
  end

  desc "Import Everything"
  task :all => [:schools, :hackers, :teams, :ratings, :team_ratings, :statuses]

end
