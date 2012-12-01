require 'doc_page'
require 'erector'
require 'markdown_renderer'
require 'redcarpet'

class MarkdownPage < DocPage
  def doc_content
    rawtext markdown.render(src)
  end

  protected

  def markdown
    @@markdown ||= Redcarpet::Markdown.new(
      MarkdownRenderer,
      :autolink           => true,
      :fenced_code_blocks => true,
      :lax_spacing        => true,
      :no_intra_emphasis  => true,
      :strikethrough      => true,
      :superscript        => true,
      :tables             => true
    )
  end
end
