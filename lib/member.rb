# lib/models/member.rb
class Member
  attr_reader :id, :name, :email, :bio, :avatar_url

  def initialize(attributes = {})
    @id = attributes[:id] || attributes['id']
    @name = attributes[:name] || attributes['name']
    @email = attributes[:email] || attributes['email']
    @bio = attributes[:bio] || attributes['bio']
    @avatar_url = attributes[:avatar_url] || attributes['avatar_url']
  end

  # Método de clase para crear miembros (requerido por Rakefile)
  def self.create(db, member_data)
    new_member = new(member_data)
    db[:members] ||= []
    db[:members] << new_member
    new_member
  end

  # Método para compatibilidad con JSON
  def to_h
    {
      id: id,
      name: name,
      email: email,
      bio: bio,
      avatar_url: avatar_url
    }
  end
end
