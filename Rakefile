# Rakefile
require 'rake'
require_relative 'lib/models/database'
require_relative 'lib/models/member'

task :default => :test

task :test do
  db = Database.new('_data/members.json')
  
  # Use string keys to be consistent
  member_data = {
    'id' => 1,
    'name' => "Test Member",
    'email' => "test@example.com",
    'bio' => "This is a test member",
    'avatar_url' => "/images/avatar.jpg"
  }
  
  Member.create(db, member_data)
  db.save
  
  puts "Test member created successfully in _data/members.json"
end
