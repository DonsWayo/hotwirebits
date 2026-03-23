# frozen_string_literal: true

module RailsBits
  class MeterGroupComponent < Base
    COLORS = {
      default: 'bg-rb-primary',
      success: 'bg-rb-success',
      warning: 'bg-rb-warning',
      destructive: 'bg-rb-destructive',
      info: 'bg-rb-info'
    }.freeze

    def initialize(items: [], **attrs)
      @items = items
      @extra_attrs = attrs
    end

    def bar_percentage(item)
      max = item[:max] || 100
      return 0 if max.zero?

      [(item[:value].to_f / max * 100).round, 100].min
    end

    def bar_color(item)
      COLORS[item[:color]] || COLORS[:default]
    end

    def container_classes
      merge_classes(
        'space-y-3',
        @extra_attrs.delete(:class)
      )
    end
  end
end
