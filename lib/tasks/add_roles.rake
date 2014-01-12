desc "Add roles to the db."
task :add_roles => :environment do
  Role.create(name: 'super_admin')
  Role.create(name: 'admin')
  Role.create(name: 'sponsor')
  Role.create(name: 'representative')
end
