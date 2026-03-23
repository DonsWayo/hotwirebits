# frozen_string_literal: true

module HotwireBits
  class SpeedDialFabComponent < Base
    DIRECTIONS = %i[up left].freeze

    def initialize(icon: nil, actions: [], direction: :up, **attrs)
      @icon = icon || default_icon
      @actions = actions
      @direction = DIRECTIONS.include?(direction) ? direction : :up
      @extra_attrs = attrs
    end

    private

    def default_icon
      '<path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15"/>'
    end

    def action_position(index)
      case @direction
      when :up then "bottom: #{(index + 1) * 56}px; right: 0;"
      when :left then "right: #{(index + 1) * 56}px; bottom: 0;"
      end
    end
  end
end
