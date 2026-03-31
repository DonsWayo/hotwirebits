# frozen_string_literal: true

module HotwireBits
  class IndicatorComponent < Base
    POSITIONS = {
      top_left: "-top-1 -left-1",
      top_right: "-top-1 -right-1",
      bottom_left: "-bottom-1 -left-1",
      bottom_right: "-bottom-1 -right-1"
    }.freeze

    def initialize(position: :top_right, color: nil, label: nil, **attrs)
      @position = position
      @color = color
      @label = label
      @extra_attrs = attrs
    end

    private

    def indicator_classes
      color_class = @color || "bg-hw-primary"
      merge_classes(
        "absolute flex items-center justify-center",
        POSITIONS[@position] || POSITIONS[:top_right],
        color_class
      )
    end
  end
end
