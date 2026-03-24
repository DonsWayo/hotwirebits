# frozen_string_literal: true

module HotwireBits
  class TextGradientComponent < Base
    DIRECTIONS = %w[to-r to-l to-b to-t to-br to-bl to-tr to-tl].freeze

    def initialize(from_color:, to_color:, direction: 'to-r', **attrs)
      @from_color = from_color
      @to_color = to_color
      @direction = DIRECTIONS.include?(direction) ? direction : 'to-r'
      @extra_attrs = attrs
    end

    def gradient_class
      "bg-gradient-#{@direction} from-#{@from_color} to-#{@to_color}"
    end
  end
end
