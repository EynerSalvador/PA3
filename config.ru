require 'jekyll'
require 'rack/rewrite'
require_relative '_plugins/login_endpoint'

Jekyll::Site.new.process

use Rack::Rewrite do
  rewrite %r{^/api/login}, '/api/login.json'
end

run Jekyll::StaticSite
