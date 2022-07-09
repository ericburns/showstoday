require "lexbor"
require "./parser/event"
require "./parser/beat_kitchen"
require "./parser/cobra_lounge"
require "./parser/constellation"

module Parser
  def self.parse(html : String, event_css : String, event : Event.class)
    lexbor = Lexbor::Parser.new(html)
    lexbor.css(event_css).map do |section|
      event.new(section)
    end
  end
end
