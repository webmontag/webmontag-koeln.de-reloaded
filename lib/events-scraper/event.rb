require_relative 'utils.rb'
EVENTS_DIR = "#{ROOT_DIR}/source/events/"
EVENTS_URL = "http://webmontag-koeln.de/events/"
EVENTS_IMAGE = "http://webmontag-koeln.de/assets/images/logo.png"

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
    @facebook_event_url = facebook_url
  end

  def to_hash
    {
      name: name,
      facebook_url: @facebook_url,
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
    # files should be stored as .erb so it gets rendered as template.
    File.open("#{EVENTS_DIR}#{@date_string}.html.erb", "w:UTF-8") do |f|
      f.write(structured_document)
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

  def front_matter
    # event
    #   name
    #   url
    #   image
    #   description
    #   startDate
    #   endDate
    #   performer
    #   	name
    #   location
    #   	name
    #   	address
    #   		streetAddress
    #   		postalCode
    #   		addressLocality
    #   		addressCountry
    #   			name
    #   offers
    #   	url
    #

    hash = Hash.new

    hash = {
      name: "Webmontag",
      title: name,
      url: "#{EVENTS_URL}#{@date_string}",
      image: EVENTS_IMAGE, # it have to be set as a permanent link.
      description:  "Web Monday is an informal, non-commercial, and completely community-driven event that aims to connect the people who are shaping the future of the internet. Inspired by the culture of Silicon Valley, it started out in Cologne, Germany in late 2005 in an effort to help spread those sunny California vibes.",
      startDate: "#{@date_string}T19:00",
      endDate: "#{@date_string}T21:00",
      performer: { name: " " },
      location: {
        name: "Die Wohngemeinschaft - Theater",
        address: {
          streetAddress: "Richard-Wagner-Straße 39", postalCode: "50674", addressLocality: "Cologne", addressCountry: { name: "Germany"  }}},
      offers: { url: "#{EVENTS_URL}#{@date_string}" },
    }

    "#{YAML.dump(hash)}---\n"
  end

  def structured_document
    "#{front_matter}#{remote_document.css("body").inner_html}"
  end
end
