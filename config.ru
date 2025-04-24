require 'jekyll'
require 'rack/rewrite'
require_relative '_plugins/login_endpoint'

# Configuración básica
use Rack::Static, urls: ['/assets'], root: '_site'

run Rack::URLMap.new(
  '/api' => LoginApp,
  '/' => Jekyll::Site.new
)
