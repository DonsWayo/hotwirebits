# frozen_string_literal: true

module HotwireBits
  class ColorSwatchComponent < Base
    SIZES = {
      sm: "h-5 w-5",
      md: "h-7 w-7",
      lg: "h-9 w-9"
    }.freeze

    def initialize(color:, size: :md, with_tooltip: true, **attrs)
      @color = color
      @size = size
      @with_tooltip = with_tooltip
      @extra_attrs = attrs
    end
  end
end
