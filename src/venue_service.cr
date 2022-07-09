# require "crest"
# require "redis"
# require "./parser"

# class VenueService
#   VENUES = {
#     beat_kitchen: {
#       name: "Beat Kitchen",
#       url: "https://www.beatkitchen.com/calendar/",
#       event_css: "div.tw-section",
#       parser: Parser::BeatKitchenEvent
#     },
#     cobra_lounge: {
#       name: "Cobra Lounge",
#       url: "https://cobralounge.com/events/",
#       event_css: "div.eventWrapper",
#       parser: Parser::CobraLoungeEvent
#     },
#     constellation: {
#       name: "Constellation",
#       url: "https://constellation-chicago.com/",
#       event_css: "section.list-view-details",
#       parser: Parser::ConstellationEvent,
#     },
#   }

#   def load(venue_name : Symbol)
#     return nil unless VENUES.include?(venue_name)

#     cache_key = get_cache_key(venue_name)
#   end

#   # Private

#   private def today
#     @today ||= Time.local
#   end

#   private def retrieve(venue_name : Symbol)
#     venue_data = VENUES[venue_name]

#     response = Crest.get(venue_data[:url])
#     events = Parser.parse(response.body, venue_data[:event_css], venue_data[:event_class])
#     venue = Venue.new(venue_data[:name], events)

#     store(venue_name, venue)

#     venue
#   end

#   private def store(venue_name : Symbol, venue : Venue)
#     redis.set(get_cache_key(venue_name, today), venue.to_json)
#   end

#   private def get_cache_key(venue_name : Symbol, date : Time)
#     "venue:#{venue_name.to_s}:#{date.to_s("%m%d%Y")}"
#   end

#   private def parse(html : String)
#     Parser.parse(html, @event_css, @event_class)
#   end

#   # Dependencies

#   private def redis
#     @redis ||= Redis.new
#   end
# end
