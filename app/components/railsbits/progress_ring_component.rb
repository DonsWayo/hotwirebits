# frozen_string_literal: true

module RailsBits
  class ProgressRingComponent < Base
    COLORS = {
      default: 'stroke-rb-primary',
      success: 'stroke-rb-success',
      warning: 'stroke-rb-warning',
      destructive: 'stroke-rb-destructive'
    }.freeze

    def initialize(value:, max: 100, size: 64, show_label: false, color: :default, **attrs)
      @value = value
      @max = max
      @size = size
      @show_label = show_label
      @color = color
      @extra_attrs = attrs
    end

    def percentage
      return 0 if @max.zero?

      [(@value.to_f / @max * 100).round, 100].min
    end

    def radius
      (@size - 8) / 2
    end

    def circumference
      2 * Math::PI * radius
    end

    def stroke_dashoffset
      circumference - (percentage / 100.0) * circumference
    end

    def color_class
      COLORS[@color] || COLORS[:default]
    end

    def center
      @size / 2
    end
  end
end
