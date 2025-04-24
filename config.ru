require 'jekyll'
require 'rack/rewrite'
require_relative '_plugins/custom_auth'

Jekyll::Hooks.register :site, :after_init do |site|
  # Configuraciones adicionales si son necesarias
end

map '/api' do
  run AuthApp
end

map '/' do
  run Jekyll::Site.new
end
