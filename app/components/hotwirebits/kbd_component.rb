# frozen_string_literal: true

module HotwireBits
  class KbdComponent < Base
    SIZES = {
      sm: "px-1 py-0.5 text-[10px]",
      md: "px-1.5 py-0.5 text-xs",
      lg: "px-2 py-1 text-sm"
    }.freeze

    def initialize(label: nil, size: :md, **attrs)
      @label = label
      @size = size
      @extra_attrs = attrs
    end

    private

    def kbd_classes
      merge_classes(
        "pointer-events-none inline-flex h-5 items-center gap-1 rounded border border-hw-border bg-hw-muted",
        "font-mono font-medium text-hw-muted-foreground",
        SIZES[@size] || SIZES[:md]
      )
    end
  end
end
