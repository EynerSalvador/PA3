require 'jekyll'
require 'sinatra/base'
require 'rack/rewrite'
require_relative '_plugins/login_endpoint'

# Configuración para desarrollo
ENV['RACK_ENV'] ||= 'development'
ENV['JEKYLL_ENV'] ||= 'development'

# Procesar el sitio Jekyll primero
Jekyll::Hooks.register :site, :after_init do |site|
  site.config['url'] = "http://localhost:4000" if ENV['RACK_ENV'] == 'development'
end

# Configuración de redirecciones
use Rack::Rewrite do
  # Redirecciones para API
  rewrite %r{^/api/login$}, '/api/login'
  
  # Manejo de URLs amigables
  r301 %r{^/login$}, '/login.html' unless File.exist?(File.join(Dir.pwd, 'login.html'))
  
  # Forzar SSL en producción
  if ENV['RACK_ENV'] == 'production'
    r301 %r{.*}, 'https://$0', scheme: 'http'
  end
end

# Mapeo de aplicaciones
map '/api' do
  run LoginApp
end

map '/' do
  use Rack::Static, 
    urls: ['/assets'],
    root: '_site',
    index: 'index.html',
    header_rules: [
      [:all, {'Cache-Control' => 'public, max-age=3600'}]
  
  run lambda { |env|
    request_path = env['PATH_INFO']
    
    # Manejo de páginas estáticas
    if File.exist?(File.join('_site', "#{request_path}.html"))
      [200, {'Content-Type' => 'text/html'}, [File.read(File.join('_site', "#{request_path}.html"))]]
    elsif File.exist?(File.join('_site', request_path, 'index.html'))
      [200, {'Content-Type' => 'text/html'}, [File.read(File.join('_site', request_path, 'index.html'))]]
    else
      [404, {'Content-Type' => 'text/html'}, ['Página no encontrada']]
    end
  }
end
