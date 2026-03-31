# frozen_string_literal: true

module HotwireBits
  class SemiCircleProgressComponent < Base
    COLORS = {
      default: "stroke-hw-primary",
      success: "stroke-hw-success",
      warning: "stroke-hw-warning",
      destructive: "stroke-hw-destructive",
      info: "stroke-hw-info"
    }.freeze

    def initialize(value:, max: 100, size: 160, color: :default, show_label: true, **attrs)
      @value = value
      @max = max
      @size = size
      @color = color
      @show_label = show_label
      @extra_attrs = attrs
    end

    def percentage
      return 0 if @max.zero?

      [(@value.to_f / @max * 100).round, 100].min
    end

    def radius
      (@size - 16) / 2
    end

    def circumference
      Math::PI * radius
    end

    def stroke_dashoffset
      circumference - (percentage / 100.0) * circumference
    end

    def color_class
      COLORS[@color] || COLORS[:default]
    end

    def center_x
      @size / 2
    end

    def center_y
      @size / 2
    end
  end
end
