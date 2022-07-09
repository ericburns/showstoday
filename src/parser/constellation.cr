require "./event"

module Parser
  class ConstellationEvent < Event
    parse_string name, "h1.event-name a"
    parse_url url, "h1.event-name a"
    parse_date date, "div.detail_event_date div.name", "%a %b %d"
    parse_string time, "div.detail_event_time div.name"
    parse_string price, "div.detail_price_range div.name"
  end

  def self.parse_constellation(html : String)
    self.parse(html, "section.list-view-details", ConstellationEvent)
  end
end
