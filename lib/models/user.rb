class User
  attr_reader :id, :username, :email, :role

  def initialize(attributes = {})
    @id = attributes[:id] || SecureRandom.uuid
    @username = attributes[:username]
    @email = attributes[:email]
    @password_hash = attributes[:password_hash]
    @role = attributes[:role] || 'member'
  end

  def authenticate(password)
    Password.valid?(@password_hash, password)
  end

  def to_json(*args)
    {
      id: @id,
      username: @username,
      email: @email,
      password_hash: @password_hash,
      role: @role
    }.to_json(*args)
  end
end
