# frozen_string_literal: true

module RailsBits
  class ChartComponent < Base
    TYPES = %i[line bar pie donut area].freeze

    def initialize(type: :line, data: [], height: 300, width: nil, show_values: false, **attrs)
      @type = type
      @data = data
      @height = height
      @width = width
      @show_values = show_values
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'w-full',
        @extra_attrs.delete(:class)
      )
    end

    def svg_width
      @width || '100%'
    end

    def max_value
      @data.map { |d| d[:value] || d[:values]&.max || 0 }.max.to_f
    end

    def sum_values
      @data.sum { |d| d[:value] || 0 }.to_f
    end

    def line_points
      return '' if @data.empty?

      max = max_value
      w = 100.0 / (@data.size - 1)
      @data.each_with_index.map do |d, i|
        x = (i * w).round(2)
        y = max.zero? ? 50 : (50 - (d[:value].to_f / max * 48)).round(2)
        "#{x},#{y}"
      end.join(' ')
    end

    def area_points
      points = line_points
      return '' if points.empty?

      w = 100.0 / (@data.size - 1)
      "#{points} #{((@data.size - 1) * w).round(2)},50 0,50"
    end

    def bar_width
      return 0 if @data.empty?

      (100.0 / @data.size * 0.7).round(2)
    end

    def bar_gap
      return 0 if @data.empty?

      (100.0 / @data.size * 0.15).round(2)
    end
  end
end
