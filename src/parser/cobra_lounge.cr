require "./event"

module Parser
  class CobraLoungeEvent < Event
    parse_string name, "a#eventTitle h2"
    parse_url url, "a#eventTitle"
    parse_date date, "div#eventDate", "%a, %B %d"
    parse_string time, "div.eventDoorStartDate span"
    parse_string price, "div.eventCost span"
  end

  def self.parse_cobra_lounge(html : String)
    self.parse(html, "div.eventWrapper", CobraLoungeEvent)
  end
end
