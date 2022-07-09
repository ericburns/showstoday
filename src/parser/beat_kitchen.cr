require "./event"

module Parser
  class BeatKitchenEvent < Event
    parse_string name, "div.tw-name a"
    parse_url url, "div.tw-name a"
    parse_date date, "span.tw-event-date", "%B %-d, %Y"
    parse_string time, "span.tw-event-time"
    parse_string price, "span.tw-price"
  end

  def self.parse_beat_kitchen(html : String)
    self.parse(html, "div.tw-section", BeatKitchenEvent)
  end
end
