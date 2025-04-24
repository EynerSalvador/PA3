require 'json'

class AuthService
  def initialize(users_file)
    @users_file = users_file
  end

  def authenticate(username, password)
    users = load_users
    users.find { |u| u['username'] == username && u['password'] == password }
  end

  private

  def load_users
    JSON.parse(File.read(@users_file))
  rescue
    []
  end
end
