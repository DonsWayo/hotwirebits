# frozen_string_literal: true

module HotwireBits
  class TypingIndicatorComponent < Base
    SIZES = {
      sm: "h-1.5 w-1.5",
      md: "h-2 w-2",
      lg: "h-2.5 w-2.5"
    }.freeze

    def initialize(size: :md, color: nil, **attrs)
      @size = size
      @color = color
      @extra_attrs = attrs
    end

    def dot_size
      SIZES[@size] || SIZES[:md]
    end

    def dot_color
      @color || "bg-hw-muted-foreground"
    end

    def gap_class
      case @size
      when :sm then "gap-1"
      when :lg then "gap-1.5"
      else "gap-1"
      end
    end
  end
end
