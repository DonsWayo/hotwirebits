# frozen_string_literal: true

module RailsBits
  class MenubarComponent < Base
    def initialize(items: [], **attrs)
      @items = items
      @extra_attrs = attrs
    end
  end
end
