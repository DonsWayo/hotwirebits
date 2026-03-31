# frozen_string_literal: true

module HotwireBits
  class BottomNavigationComponent < Base
    def initialize(items: [], active: nil, **attrs)
      @items = items
      @active = active
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        "fixed inset-x-0 bottom-0 z-40 border-t border-hw-border bg-white/95 backdrop-blur",
        @extra_attrs.delete(:class)
      )
    end

    def item_active?(item)
      @active == item[:href] || @active == item[:label]
    end
  end
end
