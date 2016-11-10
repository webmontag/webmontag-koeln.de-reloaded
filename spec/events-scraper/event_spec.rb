require 'spec_helper'
require_relative '../../lib/events-scraper/event.rb'


describe Event do
   it "Retruns hash and creates file when set: name, link and index" do
    event = Event.new("_temp_2007-01-22", "/location/koeln/2007-01-22", 9)
    expect(event.to_hash.size).to eq(4)
    expect(event.to_hash).to match a_hash_including(
     {
       name: "10. Webmontag",
       wiki_url: "http://webmontag.de/location/koeln/2007-01-22",
       date: "_temp_2007-01-22",
       facebook_url: nil}
    )
    file = "#{ROOT_DIR}/source/events/_temp_2007-01-22.html.erb"
    event.store_file
    # check if the file is exists
    expect(File).to exist(file)
    # check if the file is stored with correct UTF-8 character encoding.
    file_as_string = File.open(file, "rb:UTF-8").read
    expect(file_as_string).to include("Kölner Webmontag")
    #delete the file
    File.delete(file) if File.exist?(file)
   end
end
