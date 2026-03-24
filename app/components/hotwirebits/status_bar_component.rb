# frozen_string_literal: true

module HotwireBits
  class StatusBarComponent < Base
    POSITIONS = %i[top bottom].freeze

    def initialize(items: [], position: :bottom, **attrs)
      @items = items
      @position = POSITIONS.include?(position) ? position : :bottom
      @extra_attrs = attrs
    end

    def position_classes
      case @position
      when :top then 'top-0 border-b'
      else 'bottom-0 border-t'
      end
    end
  end
end
