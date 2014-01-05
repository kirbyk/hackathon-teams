desc "Add Statuses"
task :addStatuses => :environment do
  Status.create(name: 'Accepted')
  Status.create(name: 'Waitlisted')
  Status.create(name: 'Rejected')
  Status.create(name: 'Commited')
  Status.create(name: 'Declined')
  Status.create(name: 'TAccepted')
end
