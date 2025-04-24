require 'json'
require_relative './lib/database'
require_relative './lib/member'

desc "Generar datos de prueba y ejecutar pruebas"
task :test do
  # 1. Generar datos de prueba
  db = JSONDatabase.new('_data/members.json')
  
  # Datos de ejemplo para TDD
  test_members = [
    {
      name: "Usuario Prueba",
      role: "Rol Test",
      skills: ["Skill1", "Skill2"],
      bio: "Biografía de prueba"
    }
  ]

  test_members.each do |member_data|
    Member.create(db, member_data)
  end

  # 2. Ejecutar pruebas
  system("ruby _spec/member_spec.rb") || raise("Pruebas fallidas")
end

task default: :test
