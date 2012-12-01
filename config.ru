# Fix Rack bug https://github.com/rack/rack/issues/301
require './lib/rack_static_patch'

use Rack::ShowExceptions
use Rack::ShowStatus
use Rack::Static, :urls => ["/css", "/img"], :root => "public"

require './app'
run InstallFest
