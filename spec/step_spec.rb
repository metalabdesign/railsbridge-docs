here = File.expand_path File.dirname(__FILE__)
require "#{here}/spec_helper"

require "step_page"

describe Step do

  def to_html nokogiri_node
    nokogiri_node.serialize(:save_with => 0).chomp
  end

  def html_doc(src = "step 'hello'; step 'goodbye'")
    @html_doc ||= begin
      step = Step.new(src: src,
        doc_path: "/tmp/hello.step"
      )
      @html = step.to_html 
      Nokogiri.parse("<html>#{@html}</html>")
    end
  end

  it "renders a step file" do
    BigCheckbox.number = 1
    steps = html_doc.css(".step")
    html = to_html(steps.first)
    checkbox_html = %q{<input class="big_checkbox" id="big_checkbox_1" name="big_checkbox_1" type="checkbox" value="valuable"><label for="big_checkbox_1"></label>}
    expected = (<<-HTML).gsub("\n", '')
<div class="step" title="hello">
<h1>#{checkbox_html}<span class="prefix">Step 1: </span>hello</h1>
</div>
    HTML
    assert { html == expected }
  end

  it "puts titles in based on step names" do
    steps = html_doc.css(".step")
    assert { steps.first["title"] == "hello" }
    assert { steps[1]["title"] == "goodbye" }
  end

  it "puts anchors in based on step numbers" do
    steps = html_doc.css(".step")
    steps.each_with_index do |step, i|
      assert { step.previous }
      assert { to_html(step.previous) == "<a name=\"step#{i+1}\"></a>" }
    end
  end
  
  it "puts anchors in based on optional step name" do
    html_doc(<<-RUBY)
    step "Test", {:anchor_name => 'happy_step'}
    RUBY
    
    anchors = html_doc.css("a")
    names = anchors.map{|a| a["name"]}
    assert { names == ["step1", "happy_step"] }
  end

  it "nests anchor numbers" do
    html_doc(<<-RUBY)
    step "breakfast" do
      step "cereal"
      step "eggs"
    end
    step "lunch" do
      step "salad"
      step "sandwich"
    end
    RUBY

    titles = html_doc.css('.step').map{|div| div["title"]}
    assert { titles = ["breakfast", "cereal", "eggs", "lunch", "salad", "sandwich"] }

    anchors = html_doc.css("a")
    names = anchors.map{|a| a["name"]}
    assert { names == ["step1", "step1-1", "step1-2", "step2", "step2-1", "step2-2"] }
  end

  describe 'link' do
    it "passes in a back parameter, so the following page can come back here" do
      html_doc(<<-RUBY)
step "breakfast" do
  link "choose_breakfast"
end
step "lunch" do
  step "salad"
  step "sandwich"
end
RUBY
      a = html_doc.css(".step[title=breakfast] a.link").first
      hash = URI.escape '#'
      assert { a["href"] == "choose_breakfast?back=hello#{hash}step1" }
    end
  end

  describe 'source' do
    it "emits a block of code as a pre" do
      html_doc <<-RUBY
      source "x = 2"
      RUBY
      assert { @html == "<pre>x = 2</pre>" }
    end

    it "emits a block of code with a language directive" do
      html_doc( <<-RUBY)
      source "x = 2", :ruby
      RUBY
      assert { @html == "<div><div class=\"highlight\"><pre><span class=\"n\">x</span> <span class=\"o\">=</span> <span class=\"mi\">2</span>\n</pre></div></div>" }
    end
  end
  
  describe 'console' do
    it "emits a 'console' div with a 'pre' block" do
      html_doc(<<-RUBY)
      console "echo 'hi'"
      RUBY
      assert { @html == "<div class=\"console\"><span>#{Step::TERMINAL_CAPTION}</span><div><div class=\"highlight\"><pre><span class=\"nb\">echo</span> <span class=\"s1\">&#39;hi&#39;</span>\n</pre></div></div></div>" }
    end
  end

  describe 'result' do
    it "emits a 'result' div with a 'pre' block" do
      html_doc(<<-RUBY)
      result "hi"
      RUBY
      assert { @html == "<div class=\"result\"><span>#{Step::RESULT_CAPTION}</span><pre>hi</pre></div>" }
    end
  end
end

