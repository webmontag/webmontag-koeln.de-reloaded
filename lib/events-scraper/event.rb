require_relative 'utils.rb'
EVENTS_DIR = "#{ROOT_DIR}/source/events/"

class Event

=begin
-------------- The structured Hash -----------
# This is how the returned hash should be
"name"
"facebook_url"
"wiki_url"
"date"
----------
=end

  def initialize (date_string, link, index)

    @date_string = date_string
    @link = link
    @index = index
  end

  def to_hash
    {
      name: name,
      facebook_url: facebook_url,
      wiki_url: wiki_url,
      date: @date_string,
    }
  end

  def name
    "#{@index+1}. Webmontag"
  end


  def facebook_url
    facebook_event = remote_document.xpath("//a[contains(@href,'facebook.com/events')]")
    unless facebook_event.empty?
      print " +Facebook event".green
      facebook_event.attribute("href").to_s
    else
      FACEBOOK_URL
    end
  end

  def wiki_url
    "#{WEBSITE}#{@link}"
  end

  def store_file
    # check if the events directory is exists.
    Dir.mkdir(EVENTS_DIR) unless File.exists?(EVENTS_DIR)
    # store the events files.
    File.open("#{EVENTS_DIR}#{@date_string}.html.erb", "w:UTF-8") do |f|
      f.write(remote_document)
      f.flush
    end
  end

  private

  def remote_document
    @doc ||= begin
      uri = "#{WEBSITE}#{@link}?do=export_xhtmlbody"
      print "\n #{@index+1} ".yellow
      print "#{WEBSITE}#{@link}.html ".blue
      Nokogiri::HTML(open(uri), nil,"UTF-8")
    end
  end
end
