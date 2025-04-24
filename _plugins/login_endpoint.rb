require 'sinatra/base'
require 'json'
require 'jwt'
require_relative '../../lib/auth/auth_service'

class LoginApp < Sinatra::Base
  configure do
    # Configura la ruta correcta para users.json
    users_file = File.join(__dir__, '../../_data/users.json')
    set :auth_service, AuthService.new(users_file)
    set :jwt_secret, ENV['JWT_SECRET'] || 'secret_placeholder'
  end

  post '/api/login' do
    content_type :json

    begin
      data = JSON.parse(request.body.read)
      user = settings.auth_service.authenticate(data['username'], data['password'])

      if user
        token = generate_jwt(user)
        { 
          success: true, 
          token: token,
          user: {
            username: user.username,
            email: user.email,
            role: user.role
          }
        }.to_json
      else
        status 401
        { success: false, error: 'Invalid credentials' }.to_json
      end
    rescue JSON::ParserError
      status 400
      { error: 'Invalid JSON format' }.to_json
    end
  end

  private

  def generate_jwt(user)
    payload = {
      user_id: user.username,
      exp: Time.now.to_i + 3600 # 1 hour expiration
    }
    JWT.encode(payload, settings.jwt_secret, 'HS256')
  end
end
