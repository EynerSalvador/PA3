class User
  attr_reader :id, :username, :email, :member_id

  def initialize(attributes = {})
    @id = attributes['id']
    @username = attributes['username']
    @email = attributes['email']
    @member_id = attributes['member_id']
    @password_hash = attributes['password_hash']
  end

  def authenticate(password)
    Password.valid?(@password_hash, password)
  end

  def to_h
    {
      id: @id,
      username: @username,
      email: @email,
      member_id: @member_id
    }
  end
end
