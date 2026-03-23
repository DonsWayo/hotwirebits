# frozen_string_literal: true

module RailsBits
  class NavbarComponent < Base
    renders_one :actions

    def initialize(brand: nil, items: [], sticky: false, transparent: false, **attrs)
      @brand = brand
      @items = items
      @sticky = sticky
      @transparent = transparent
      @extra_attrs = attrs
    end

    private

    def nav_classes
      merge_classes(
        'w-full border-b border-rb-border',
        'bg-rb-background/95 backdrop-blur supports-[backdrop-filter]:bg-rb-background/60',
        @sticky ? 'sticky top-0 z-50' : nil,
        @transparent ? 'bg-transparent border-transparent' : nil
      )
    end
  end
end
