# frozen_string_literal: true

module HotwireBits
  class IndicatorBadgeComponent < Base
    POSITIONS = {
      top_left: 'top-0 left-0 -translate-x-1/2 -translate-y-1/2',
      top_right: 'top-0 right-0 translate-x-1/2 -translate-y-1/2',
      bottom_left: 'bottom-0 left-0 -translate-x-1/2 translate-y-1/2',
      bottom_right: 'bottom-0 right-0 translate-x-1/2 translate-y-1/2'
    }.freeze

    def initialize(content: nil, position: :top_right, color: nil, dot: false, **attrs)
      @content = content
      @position = position
      @color = color || 'bg-hw-primary'
      @dot = dot
      @extra_attrs = attrs
    end

    def wrapper_classes
      'relative inline-flex'
    end

    def badge_classes
      merge_classes(
        'absolute flex items-center justify-center rounded-full',
        POSITIONS[@position] || POSITIONS[:top_right],
        @color,
        @dot ? 'h-2.5 w-2.5' : 'h-5 min-w-5 px-1 text-xs font-medium text-hw-primary-foreground'
      )
    end
  end
end
