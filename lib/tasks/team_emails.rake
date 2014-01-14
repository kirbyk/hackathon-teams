desc "Find team emails"
task :team_emails => :environment do
  teams = [1075,1080,1081,1148,1180,1285,1326,1327,1418,1430,1432,1456,1523,1534,1535,1545,1578,1819,1822,1825,1826,1827]
  teams.each do |team|
    puts "==================="
    puts Team.find(team).hackers.map{|t| t.email}.join(',')
    puts Team.find(team).hackers.map{|t| t.fname}.join(',')
  end
end
