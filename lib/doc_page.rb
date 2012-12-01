require 'contents'
require 'erector'
require 'pygments'
require 'site_index'

class InstallfestExternalRenderer < ExternalRenderer

end

class DocPage < Erector::Widgets::Page
  include Sprockets::Helpers

  needs :site_name, :doc_title, :doc_path, :page_name
  needs :back => nil
  attr_reader :site_name, :doc_title, :page_name

  needs :src
  attr_reader :src

  # wire up the InstallfestExternalRenderer
  def included_head_content
    included_widgets = [self.class] + output.widgets.to_a + extra_widgets
    InstallfestExternalRenderer.new(:classes => included_widgets).to_html
  end

  def doctype
    '<!doctype html>'
  end

  def html_attributes
    {:lang => 'en'}
  end

  def head_content
    title page_title
    link :href => stylesheet_path("doc_page"), :rel => "stylesheet", :type => "text/css"
    link :href => stylesheet_path("steps"), :rel => "stylesheet", :type => "text/css"
    script :src => javascript_path("jquery-1.6.1.js")
  end

  def site_title
    "Railsbridge #{site_name.split(/[-_]/).map(&:capitalize).join(" ")}"
  end

  def page_title
    "#{doc_title} - #{site_title}"
  end

  external :style, Pygments.css(".highlight", style: "monokai")

  class TopLink < Erector::Widget
    needs :name, :href, :onclick => nil
    def content
      a "[#{@name}]", :class => "top_link", :href => @href, :onclick => @onclick
    end
  end

  # todo: test
  def file_name
    @doc_path.split('/').last
  end

  # todo: test
  def git_url
    "https://github.com/railsbridge/docs/blob/master/sites/#{@site_name}/#{file_name}"
  end

  def top_links
    [
      TopLink.new(:name => "sites", :href => "#", :onclick => "$('#site_index').toggle(); return false;"),
      TopLink.new(:name => "src", :href => "#{file_name.split('.').first}/src"),
      TopLink.new(:name => "toc", :href => "#", :onclick => "$('#table_of_contents').toggle(); return false;"),
      TopLink.new(:name => "git", :href => git_url),
    ]
  end

  def body_content
    div.top {
      div.top_links {
        top_links.each do |top_link|
          widget top_link
        end
      }
      h1 { a site_title, :href => "/#{site_name}" }
    }

    widget Contents, site_name: site_name, page_name: page_name
    widget SiteIndex, site_name: site_name

    div(:class=>:main) {
      h1 doc_title, :class=>"doc_title"
      div(:class=>:doc) {
        doc_content
      }
      if @back
        div.back {
          text "Back to "
          a(:class => "back", :href => @back) do
            text @back.split('#').first #todo: titleize etc, use real doc object
          end
        }
      end
    }

    div(:class=>:bottom) {
      p "Railsbridge Docs"
      p do
        text "Source: "
        url "https://github.com/railsbridge/docs"
      end
    }
  end

end
