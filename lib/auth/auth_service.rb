require 'json'
require_relative '../models/user'
require_relative 'password'

class AuthService
  def initialize(users_file)
    @users_file = users_file
    @users = load_users
  end

  def authenticate(username, password)
    user = @users.find { |u| u.username == username }
    user && user.authenticate(password) ? user : nil
  end

  private

  def load_users
    return [] unless File.exist?(@users_file)
    
    JSON.parse(File.read(@users_file)).map do |user_data|
      User.new(
        user_data['username'],
        user_data['password_hash'],
        user_data['email'],
        user_data['role'] || 'member'
      )
    end
  end
end
