# Rakefile
require 'rake'
require File.expand_path('../lib/models/database', __dir__)
require File.expand_path('../lib/models/member', __dir__)

task :default => :test

task :test do
  db = Database.new('_data/members.json')
  
  member_data = {
    'id' => 1,
    'name' => "Test Member",
    'email' => "test@example.com",
    'bio' => "This is a test member",
    'avatar_url' => "/images/avatar.jpg"
  }
  
  Member.create(db, member_data)
  db.save
  
  puts "Miembro creado exitosamente!"
end
