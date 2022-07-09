module Parser
  class Event
    property name : String?
    property url : String?
    property date : Time?
    property time : String?
    property price : String?

    def initialize(section : Lexbor::Node)
      @section = section
    end

    def parse_node(search_string)
      begin
        @section.css(search_string).try(&.first)
      rescue Enumerable::EmptyError
        nil
      end
    end

    def parse_string(search_string)
      parse_node(search_string)
        .try(&.inner_text)
        .try(&.strip) || ""
    end

    def parse_url(search_string)
      node = parse_node(search_string)
      node ? node["href"] : nil
    end

    macro parse_string(name, search_string)
      def {{name}}
        return @{{name}} unless @{{name}}.nil?
        @{{name}} = parse_string({{search_string}})
      end
    end

    macro parse_url(name, search_string)
      def {{name}}
        return @{{name}} unless @{{name}}.nil?
        @{{name}} = parse_url({{search_string}})
      end
    end

    macro parse_date(name, search_string, format)
      def {{name}}
        return @{{name}} unless @{{name}}.nil?

        # Some are missing the year
        current_year = Time.local.year

        date_string = parse_string({{search_string}})

        # Figure out better timezone stuff later, but for now it's just all Chicago
        parsed_date = Time.parse(date_string, {{format}}, Time::Location.load("America/Chicago"))
        Time.local(current_year, parsed_date.month, parsed_date.day)
      end
    end
  end
end
