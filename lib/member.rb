# lib/models/member.rb
class Member
  attr_reader :id, :name, :email, :bio, :avatar_url

  def initialize(attributes = {})
    # Handle both symbol and string keys
    attrs = attributes.transform_keys(&:to_s)
    @id = attrs['id']
    @name = attrs['name']
    @email = attrs['email']
    @bio = attrs['bio']
    @avatar_url = attrs['avatar_url']
  end

  def self.create(db, member_data)
    new_member = new(member_data)
    # Access with string key
    db.data['members'] ||= []
    db.data['members'] << new_member.to_h
    new_member
  end

  def to_h
    {
      'id' => id,
      'name' => name,
      'email' => email,
      'bio' => bio,
      'avatar_url' => avatar_url
    }.compact
  end
end
