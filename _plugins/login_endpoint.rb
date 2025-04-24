require 'sinatra/base'
require 'json'
require 'jwt'
require_relative '../../lib/auth/auth_service'

class LoginApp < Sinatra::Base
  configure do
    set :auth_service, AuthService.new(File.join(Dir.pwd, '_data', 'users.json'))
    enable :sessions
    set :show_exceptions, false
    set :jwt_secret, ENV['JWT_SECRET'] || 'your_default_secret_here'
  end

  before do
    content_type :json
  end

  error 400..500 do
    { error: env['sinatra.error'].message }.to_json
  end

  post '/api/login' do
    data = JSON.parse(request.body.read)
    username = data['username']
    password = data['password']

    user = settings.auth_service.authenticate(username, password)

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
      { success: false, error: 'Credenciales inválidas' }.to_json
    end
  rescue JSON::ParserError
    status 400
    { error: 'Formato JSON inválido' }.to_json
  end

  get '/api/current_user' do
    if request.env['HTTP_AUTHORIZATION']
      token = request.env['HTTP_AUTHORIZATION'].split(' ').last
      decoded = decode_jwt(token)
      { logged_in: true, user: decoded }.to_json
    else
      { logged_in: false }.to_json
    end
  rescue JWT::DecodeError
    status 401
    { error: 'Token inválido' }.to_json
  end

  post '/api/logout' do
    { success: true, message: 'Sesión cerrada' }.to_json
  end

  private

  def generate_jwt(user)
    payload = {
      user_id: user.username,
      role: user.role,
      exp: Time.now.to_i + 3600 # 1 hora de expiración
    }
    JWT.encode(payload, settings.jwt_secret, 'HS256')
  end

  def decode_jwt(token)
    decoded = JWT.decode(token, settings.jwt_secret, true, { algorithm: 'HS256' })
    decoded.first
  end
end
