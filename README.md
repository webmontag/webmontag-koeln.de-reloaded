# Webmontag-Koeln.de

## Dependencies

  Ruby 2.2
  Middleman 3.4

## Webmontag events-scraper

  Events scraper brings Webmontag events that are existed in: http://webmontag.de/location/koeln/index to /source/events/ as html.erb files and extract the details to webmondays.yml file.

  To run events-scraper, `ruby lib/events-scraper.rb` should be called.

## Development

- clone the repository
- run `$ bundle install`
- run `$ bower install ` (you may need to upgrade bower to latest)

## Deployment

After pushing changes to master, it will automatically deploy if test passes.
