# frozen_string_literal: true

module HotwireBits
  class HeaderComponent < Base
    renders_one :actions

    def initialize(brand: nil, nav_items: [], sticky: false, **attrs)
      @brand = brand
      @nav_items = nav_items
      @sticky = sticky
      @extra_attrs = attrs
    end

    private

    def header_classes
      merge_classes(
        'w-full border-b border-hw-border bg-hw-background/95 backdrop-blur supports-[backdrop-filter]:bg-hw-background/60',
        @sticky ? 'sticky top-0 z-50' : nil
      )
    end
  end
end
