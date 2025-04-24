require_relative 'password'
require_relative '../models/user'
require_relative '../models/database'

class AuthService
  def initialize(db = JSONDatabase.new('_data/users.json'))
    @db = db
  end

  def register(username, email, password, member_id)
    existing = @db.find_user_by_username(username)
    return { error: "Usuario ya existe" } if existing

    user = {
      id: SecureRandom.uuid,
      username: username,
      email: email,
      password_hash: Password.hash(password),
      member_id: member_id,
      created_at: Time.now.iso8601
    }

    @db.create('users', user)
    { success: true, user: user }
  end

  def login(username, password)
    user = @db.find_user_by_username(username)
    return { error: "Usuario no encontrado" } unless user

    if Password.valid?(user['password_hash'], password)
      { success: true, user: user }
    else
      { error: "Contraseña incorrecta" }
    end
  end

  def find_by_member(member_id)
    @db.where('users', { member_id: member_id }).first
  end
end
