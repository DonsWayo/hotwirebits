# frozen_string_literal: true

module HotwireBits
  class TableOfContentsComponent < Base
    def initialize(headings: [], active_id: nil, **attrs)
      @headings = headings
      @active_id = active_id
      @extra_attrs = attrs
    end

    private

    def indent_class(level)
      case level.to_i
      when 2 then "pl-0"
      when 3 then "pl-3"
      when 4 then "pl-6"
      when 5 then "pl-9"
      else "pl-0"
      end
    end
  end
end
