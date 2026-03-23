# frozen_string_literal: true

module HotwireBits
  class DockMenuComponent < Base
    def initialize(items: [], **attrs)
      @items = items
      @extra_attrs = attrs
    end
  end
end
