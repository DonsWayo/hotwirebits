# frozen_string_literal: true

module HotwireBits
  class FlyoutMenuComponent < Base
    POSITIONS = {
      bottom_start: "left-0 top-full mt-1",
      bottom_end: "right-0 top-full mt-1",
      top_start: "left-0 bottom-full mb-1",
      top_end: "right-0 bottom-full mb-1",
      right_start: "left-full top-0 ml-1",
      left_start: "right-full top-0 mr-1"
    }.freeze

    def initialize(trigger_label:, items: [], position: :bottom_start, **attrs)
      @trigger_label = trigger_label
      @items = items
      @position = position
      @extra_attrs = attrs
    end

    def menu_position
      POSITIONS[@position] || POSITIONS[:bottom_start]
    end
  end
end
