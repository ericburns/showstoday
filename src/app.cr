require "kemal"
require "crest"
require "./parser"
require "./venue"

get "/" do
  today = Time.local

  response = Crest.get("https://www.beatkitchen.com/calendar/")
  beat_kitchen = Venue.new("Beat Kitchen", Parser.parse_beat_kitchen(response.body))

  response = Crest.get("https://cobralounge.com/events/")
  cobra_lounge = Venue.new("Cobra Lounge", Parser.parse_cobra_lounge(response.body))

  response = Crest.get("https://constellation-chicago.com/")
  constellation = Venue.new("Constellation", Parser.parse_constellation(response.body))

  venues = [beat_kitchen, cobra_lounge, constellation]
  render("src/views/index.ecr")
end

error 404 do
  "ey lmao"
end

Kemal.run
