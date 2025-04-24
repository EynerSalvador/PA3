require 'sinatra/base'
require 'json'
require 'jwt'
require_relative '../../lib/auth/auth_service'

class AuthApp < Sinatra::Base
  configure do
    set :auth_service, AuthService.new(File.expand_path('../../_data/users.json', __dir__))
    set :jwt_secret, ENV['JWT_SECRET'] || 'your-secret-key'
  end

  post '/api/login' do
    content_type :json
    
    begin
      data = JSON.parse(request.body.read)
      user = settings.auth_service.authenticate(data['username'], data['password'])

      if user
        { success: true, token: generate_token(user) }.to_json
      else
        status 401
        { success: false, error: 'Invalid credentials' }.to_json
      end
    rescue JSON::ParserError
      status 400
      { error: 'Invalid JSON' }.to_json
    end
  end

  private

  def generate_token(user)
    payload = { user_id: user.username, exp: Time.now.to_i + 3600 }
    JWT.encode(payload, settings.jwt_secret, 'HS256')
  end
end
