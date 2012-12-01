here = File.expand_path File.dirname(__FILE__)
require "#{here}/spec_helper"

require "#{here}/../app"
require "rack/test"

# todo: use a dummy set of sites instead of the real "installfest" and "curriculum"

describe InstallFest do
  include Rack::Test::Methods

  def app
    @app ||= InstallFest.new
  end

  # find the actual InstallFest app, discarding Rack middleware
  def true_app
    true_app = app.is_a?(Struct) ? app.app : app
    until true_app.is_a? InstallFest
      next_app = true_app.instance_variable_get(:@app)
      break if next_app.nil?
      true_app = next_app
    end
    true_app
  end

  def get! *args
    get *args
    assert { last_response.status == 200 }
  end

  it "is a sinatra app" do
    assert { true_app.is_a? InstallFest }
    assert { true_app.class.ancestors.include? Sinatra::Application }
  end

  it "redirects / to the default site" do
    get "/"
    assert { last_response.redirect? }
    follow_redirect! while last_response.redirect?
    assert { last_request.path == "/installfest/" }
  end

  it "redirects /site to /site/" do
    get "/installfest"
    follow_redirect! while last_response.redirect?
    assert { last_request.path == "/installfest/" }
  end

  it "redirects /site/page/ to /site/page" do
    get "/installfest/foo/"
    follow_redirect! while last_response.redirect?
    assert { last_request.path == "/installfest/foo" }
  end

  it "has a default site" do
    assert { true_app.default_site == "installfest" }
  end

  describe "settings" do
    # note: I'd rather pass settings into the constructor, but Sinatra uses that interface (for a downstream app)

    it "accepts default_site via setter" do
      true_app.default_site = "curriculum"
      assert { true_app.default_site == "curriculum" }
    end

    it "accepts default_site via Sinatra set" do
      pending "figure out Sinatra set"
      InstallFest.set :default_site, "curriculum"
      @app = InstallFest.new
      assert { true_app.default_site == "curriculum" }
    end

    it "can configure the sites_dir" do
      foo_dir = dir "foo"
      true_app.sites_dir = foo_dir
      assert { true_app.sites_dir == foo_dir }
    end
  end

  it "looks for a site named the same as the host" do
    get "/", {}, {"HTTP_HOST" => "curriculum.example.com"}
    assert { last_response.redirect? }
    follow_redirect! while last_response.redirect?
    assert { last_request.path == "/curriculum/" }
  end

  describe "page headers" do
    before :all do
      get "/"
      follow_redirect! while last_response.redirect?
      @body = last_response.body
    end

    it "should contain the html5 doctype" do
      @body.should match(/<!doctype html>/i)
    end

    it "should render style tags without any attributes" do
      @body.should match(/<style>/i)
    end

    it "should render meta tags in the terse html5 style" do
      pending <<GRIPE
For whatever reason, erector (or something else?!) always makes a meta tag with 'http-equiv...' etc.
Adding `meta :charset => 'UTF-8'` in head_content should fix this, but it just adds an extra meta tag instead.
GRIPE
      @body.should match(/<meta charset=['"]UTF-8['"]>/i)
    end
  end

  describe "an app with slides" do
    require "deck"
    before do
      breakfast = <<-MARKDOWN
# Eggs

* scrambled
* fried

# Cereal

* Frosted Mini-Wheats
* Corn Flakes
* Raisin Bran
      MARKDOWN

      true_app.sites_dir = dir "sites"  do
        dir "meals" do
          f = file "breakfast.deck.md", breakfast
        end
      end
      @breakfast = breakfast
    end

    it "renders a deck" do
      get! "/meals/breakfast"
      rendered_breakfast = Deck::SlideDeck.new(:slides => Deck::Slide.split(@breakfast)).to_pretty
      assert { last_response.body.include?(rendered_breakfast) }
    end

    # todo: include deck.js source right inside the HTML
    it "serves up deck.js and other public assets" do
      get! "/deck.js/core/deck.core.js"
      assert { last_response.body.include?("Deck JS - deck.core")}

      get! "/deck.js/jquery-1.7.2.min.js"
      assert { last_response.body.include?("jQuery")}
    end
  end
end
