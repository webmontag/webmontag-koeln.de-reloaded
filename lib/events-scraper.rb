require_relative 'events-scraper/utils'
require_relative 'events-scraper/event'
require 'byebug'

print_divider

puts "\n\n"
puts "Requesting Koeln wiki from http://webmontag.de/location/koeln".green
wiki_url = 'http://webmontag.de/location/koeln/index?do=export_xhtmlbody'
webmontag_wiki_site = Nokogiri::HTML(open(wiki_url)).css('.archive li div a')

puts "\n\t #{webmontag_wiki_site.length} records found".green

# This array contains each event from wiki website {name, href}.
events = Array.new
# extracting {name, href} with index
webmontag_wiki_site.map.with_index { |a, index|
  event = Event.new(
  # passing name, href and index
    a.children.to_s,
    a.attributes["href"].to_s,
    index
  )
  # Save files locally by name in data/events/
  event.store_file
  # Create Yaml event-blocks, each block is a hash.
  events.push(event.to_hash)
}

print "\n\n"

puts "Creating Yaml file /data/webmondays.yml ".green
output = YAML.dump(events.reverse)
# it is called from lib/event-tracker.rb
File.write("#{ROOT_DIR}/data/webmondays.yml", output)

print_divider

puts "Done.\n"
