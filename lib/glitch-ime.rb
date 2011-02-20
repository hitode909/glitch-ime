require 'rubygems'
require 'json'
require 'cgi'
require 'open-uri'

class GlitchIME
  def initialize(text)
    @text = text
  end

  def generate
    result = ''
    patterns.each{|pair|
      key, values = *pair
      result += choice(values)
    }
    result
  end

  private
  def patterns
    @json ||= begin
      url = "http://www.google.com/transliterate?langpair=ja-Hira%7Cja&text=" + CGI.escape(@text)
      src =  open(url).read.gsub(/\n/, '').gsub(/,\]/, ']')
      JSON.parse(src)
    end
  end

  def choice(array)
    if array.respond_to? :choice
      array.choice
    elsif array.respond_to? :sample
      array.sample
    else
      array[(rand * array.length).to_i ]
    end
  end
end
