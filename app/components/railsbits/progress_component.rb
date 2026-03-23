# frozen_string_literal: true

module RailsBits
  class ProgressComponent < Base
    SIZES = {
      sm: 'h-1.5',
      md: 'h-2.5',
      lg: 'h-4'
    }.freeze

    COLORS = {
      default: 'bg-rb-primary',
      success: 'bg-rb-success',
      warning: 'bg-rb-warning',
      destructive: 'bg-rb-destructive'
    }.freeze

    def initialize(value:, max: 100, size: :md, color: :default, show_label: false, animated: false, **attrs)
      @value = value
      @max = max
      @size = size
      @color = color
      @show_label = show_label
      @animated = animated
      @extra_attrs = attrs
    end

    def percentage
      return 0 if @max.zero?

      [(@value.to_f / @max * 100).round, 100].min
    end

    def track_classes
      merge_classes(
        'w-full overflow-hidden rounded-full bg-rb-muted',
        SIZES[@size] || SIZES[:md]
      )
    end

    def bar_classes
      merge_classes(
        'h-full rounded-full transition-all duration-300',
        COLORS[@color] || COLORS[:default],
        @animated ? 'animate-pulse' : ''
      )
    end
  end
end
