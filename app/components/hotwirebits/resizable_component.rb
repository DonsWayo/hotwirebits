# frozen_string_literal: true

module HotwireBits
  class ResizableComponent < Base
    renders_one :left
    renders_one :right
    renders_one :top
    renders_one :bottom

    def initialize(direction: :horizontal, **attrs)
      @direction = direction
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        "flex",
        (@direction == :horizontal) ? "flex-row h-full" : "flex-col w-full",
        @extra_attrs.delete(:class)
      )
    end

    def handle_classes
      if @direction == :horizontal
        "w-[3px] cursor-col-resize bg-hw-border hover:bg-hw-primary transition-colors"
      else
        "h-[3px] cursor-row-resize bg-hw-border hover:bg-hw-primary transition-colors"
      end
    end

    def panel_classes
      "overflow-hidden flex-1"
    end
  end
end
