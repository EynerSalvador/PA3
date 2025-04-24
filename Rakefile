# Rakefile
require 'rake'

# Configura el load path para que encuentre tus archivos en lib/
$LOAD_PATH.unshift(File.expand_path('lib', __dir__))

# Ahora usa require normal (no require_relative)
require 'models/database'
require 'models/member'

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
  
  puts "Miembro creado exitosamente en _data/members.json"
end
