require_relative '../models/user'
require_relative 'password'

class AuthService
  def initialize(db)
    @db = db
  end

  def register(username, email, password)
    existing = @db.where('users', { username: username }).first
    return { success: false, error: 'Username already exists' } if existing

    user = User.new(
      username: username,
      email: email,
      password_hash: Password.create(password),
      role: 'member'
    )

    @db.create('users', user.to_json)
    { success: true, user: user }
  end

  def login(username, password)
    user_data = @db.where('users', { username: username }).first
    return { success: false, error: 'User not found' } unless user_data

    user = User.new(user_data)
    user.authenticate(password) ? 
      { success: true, user: user } : 
      { success: false, error: 'Invalid password' }
  end
end
