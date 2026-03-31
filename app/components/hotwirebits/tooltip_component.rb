# frozen_string_literal: true

module HotwireBits
  class TooltipComponent < Base
    def initialize(tip: nil, side: :top, delay: 200, **attrs)
      @tip = tip
      @side = side
      @delay = delay
      @extra_attrs = attrs
    end

    private

    def tooltip_classes
      merge_classes(
        "absolute z-50 overflow-hidden rounded-md border border-hw-border bg-hw-popover px-3 py-1.5 text-sm text-hw-popover-foreground shadow-md",
        "animate-in fade-in-0 zoom-in-95",
        side_classes,
        @extra_attrs.delete(:class)
      )
    end

    def side_classes
      case @side
      when :top then "bottom-full left-1/2 -translate-x-1/2 mb-2"
      when :bottom then "top-full left-1/2 -translate-x-1/2 mt-2"
      when :left then "right-full top-1/2 -translate-y-1/2 mr-2"
      when :right then "left-full top-1/2 -translate-y-1/2 ml-2"
      end
    end
  end
end
