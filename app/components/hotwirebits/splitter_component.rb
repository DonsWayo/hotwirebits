# frozen_string_literal: true

module HotwireBits
  class SplitterComponent < Base
    renders_one :slot_1
    renders_one :slot_2

    def initialize(direction: :horizontal, default_sizes: [50, 50], **attrs)
      @direction = direction
      @default_sizes = default_sizes
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
        "w-[3px] cursor-col-resize bg-hw-border hover:bg-hw-primary active:bg-hw-primary shrink-0 transition-colors"
      else
        "h-[3px] cursor-row-resize bg-hw-border hover:bg-hw-primary active:bg-hw-primary shrink-0 transition-colors"
      end
    end

    def panel_1_style
      "flex-basis: #{@default_sizes[0]}%;"
    end

    def panel_2_style
      "flex-basis: #{@default_sizes[1]}%;"
    end
  end
end
