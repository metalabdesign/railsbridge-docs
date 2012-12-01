require 'rubygems'
require 'bundler'
Bundler.require

# Fix Rack bug https://github.com/rack/rack/issues/301
# require './lib/rack_static_patch'
require './app'

use Rack::ShowExceptions
use Rack::ShowStatus

map InstallFest.assets_prefix do
  run InstallFest.sprockets
end

map '/' do
  run InstallFest
end
