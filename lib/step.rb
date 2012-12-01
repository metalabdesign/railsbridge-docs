require 'erector'
require 'big_checkbox'
require 'redcarpet'
require 'markdown_renderer'

class Step < Erector::Widget

  needs :src
  needs :doc_path

  def initialize options
    super
    @step_stack = []
  end

  def next_step_number
    @step_stack << 0 if @step_stack.empty?
    @step_stack[-1] = @step_stack.last + 1
  end

  def as_title name
    name.to_s.split('_').map{|s| s.capitalize}.join(' ')
  end

  def prefix s
    span s, :class => "prefix"
  end

  def current_anchor_num
    nested_steps = @step_stack.dup
    nested_steps.pop if nested_steps.last == 0
    nested_steps.join("-")
  end

  # todo: move into proper Doc class
  def page_name
    @doc_path.split('/').last.split('.').first
  end

  ## steps

  @@header_sections = {
    steps:"Steps",
    explanation:"Explanation",
    discussion:"Discussion Items",
    hints:"Hints",
    tools_and_references:"Tools and References",
    requirements:"Requirements to advance",
  }

  @@header_sections.each do |type, header|
    define_method type do |&block|
      div :class => type do
        h1 header
        blockquote do
          block.call if block
        end
      end
    end
  end

  def consider_deploying
    div :class => "deploying" do
      h1 "Deploying"
      blockquote do
        message "Before the next step, you could try deploying your app to Heroku!"
        link 'deploying_to_heroku'
      end
    end
  end

  def step name = nil, options = {}
    num = next_step_number
    a(:name => "step#{current_anchor_num}")
    a(:name => options[:anchor_name]) if options[:anchor_name]
    div :class => "step", :title => name do
      h1 do
        widget BigCheckbox
        prefix "Step #{num}: "
        text name
      end
      _render_inner_content &Proc.new if block_given?
    end
  end

  def link name
    p :class => "link" do
      text "Go on to "
      # todo: extract StepFile with unified name/title/path routines
      require 'uri'
      hash = URI.escape '#'
      href = name + "?back=#{page_name}#{hash}step#{current_anchor_num}"
      a as_title(name), :href => href, :class => 'link'
    end
  end

  def next_step name
    div :class => "step next_step" do
      h1 do
        prefix "Next Step:"
      end
      link name
    end
  end

  def situation name
    h1 name
    _render_inner_content &Proc.new if block_given?
  end

  def choice name = "between..."
    step "Choose #{name}" do
      _render_inner_content &Proc.new if block_given?
    end
  end

  def option name
    num = next_step_number
    a(:name => "step#{current_anchor_num}")  # todo: test
    h1 do
      span "Option #{num}: "
      text name
    end
    _render_inner_content &Proc.new if block_given?
  end

  def section text
    div do
      h1 text
      blockquote do
        yield
      end
    end
  end

  def verify text = nil
    div :class=> "verify" do
      h1 "Verify #{text}"
      blockquote do
        yield
      end
    end
  end

  def goals
    div :class => "goals" do
      h1 "Goals"
      ul do
        yield
      end
    end
  end

  alias_method :goal, :li

  ## message

  def message text = nil, options = {}
    classes = (["message"] + [options[:class]]).compact
    div :class => classes do
      img.icon src: "/img/#{options[:icon]}.png" if options[:icon]
      rawtext(markdown.render text) unless text.nil?
      yield if block_given?
    end
  end

  def important text = nil, &block
    message text, class: "important", icon: "warning", &block
  end

  def tip text = nil, &block
    message text, class: "tip", icon: "info", &block
  end

  def todo todo_text
    message nil, class: "todo" do
      span do
        text "[TODO: "
        text todo_text
        text "]"
      end
    end
  end

  ## special

  TERMINAL_CAPTION = "Type this in the terminal:"
  RESULT_CAPTION = "Expected result:"

  def source code, lang = nil
    if lang
      div raw Pygments.highlight(code, lexer: lang.to_s)
    else
      pre code
    end
  end

  def console msg
    div :class => "console" do
      span TERMINAL_CAPTION
      source msg, :bash
    end
  end

  def result text
    div :class => "result" do
      span RESULT_CAPTION
      pre text
    end
  end

  def content
    eval @src, binding, @doc_path, 1
  end

  private

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

  def _render_inner_content
    blockquote do
      @step_stack.push 0
      yield
      @step_stack.pop
    end
  end
end
