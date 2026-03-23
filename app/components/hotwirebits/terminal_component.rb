# frozen_string_literal: true

module HotwireBits
  class TerminalComponent < Base
    def initialize(lines: [], title: 'Terminal', **attrs)
      @lines = lines
      @title = title
      @extra_attrs = attrs
    end
  end
end
