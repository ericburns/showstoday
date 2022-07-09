require "json"
require "./parser"

class Venue(T)
  property name : String
  property events : Array(T)

  def initialize(@name, @events)
  end

  def events_on(event_date : Time)
    events.select { |e| e.date.try(&.date) == event_date.date }
  end

  # def to_json
  #   {
  #     name: name,
  #     events: events.map do |event|
  #       {
  #         name: event.name,
  #         url: event.url,
  #         date: event.date.to_s,
  #         time: event.time,
  #         price: event.price,
  #       }
  #     end
  #   }.to_json
  # end

  # def from_json(json_string)
  #   venue_data = JSON.parse(json_string)


  # end
end
