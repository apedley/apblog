require 'net/http'
require 'uri'

class SyntaxHighlighter
  PYGMENTS_URI = 'http://pygments.appspot.com/'
  attr_accessor :doc

  def initialize(html)
    self.doc = Nokogiri::HTML(html)
    doc.search("pre > code[class]").each do |code|
      request = Net::HTTP.post_form(URI.parse(PYGMENTS_URI), 
                  { 'lang' => code[:class],
                    'code' => code.text.rstrip })
      code.parent.replace request.body
    end
  end

  def to_s
    doc.search("//body").children.to_s
  end
end
