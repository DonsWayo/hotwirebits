# frozen_string_literal: true

module HotwireBits
  class MarqueeComponent < Base
    renders_one :content

    def initialize(direction: :left, speed: 30, pause_on_hover: true, **attrs)
      @direction = direction
      @speed = speed
      @pause_on_hover = pause_on_hover
      @extra_attrs = attrs
    end

    def vertical?
      %i[up down].include?(@direction)
    end

    def animation_name
      "hw-marquee-#{@direction}"
    end

    def container_classes
      merge_classes(
        'overflow-hidden',
        vertical? ? 'h-64' : 'w-full',
        @extra_attrs.delete(:class)
      )
    end

    def track_classes
      merge_classes(
        'flex',
        vertical? ? 'flex-col' : 'flex-row',
        @pause_on_hover ? 'hover:[animation-play-state:paused]' : nil
      )
    end
  end
end
