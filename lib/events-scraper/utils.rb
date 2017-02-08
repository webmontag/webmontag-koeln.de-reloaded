require 'nokogiri'
require 'open-uri'
require 'yaml'


WEBSITE = 'http://webmontag.de'
FACEBOOK_URL = ''
ROOT_DIR = File.expand_path("../../../", __FILE__)

def print_divider
  puts "-------------------------------------------".blue
end

class String

  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def red
    colorize(self, 31)
  end

  def green
    colorize(self, 32)
  end

  def yellow
    colorize(self, 33)
  end

  def blue
    colorize(self, 34)
  end
end
