# frozen_string_literal: true

module HotwireBits
  class MenuComponent < Base
    def initialize(items: [], orientation: :vertical, **attrs)
      @items = items
      @orientation = orientation
      @extra_attrs = attrs
    end

    private

    def menu_classes
      merge_classes(
        'flex',
        @orientation == :horizontal ? 'flex-row gap-1' : 'flex-col gap-0.5'
      )
    end
  end
end
