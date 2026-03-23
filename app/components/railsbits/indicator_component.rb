# frozen_string_literal: true

module RailsBits
  class IndicatorComponent < Base
    POSITIONS = {
      top_left: '-top-1 -left-1',
      top_right: '-top-1 -right-1',
      bottom_left: '-bottom-1 -left-1',
      bottom_right: '-bottom-1 -right-1'
    }.freeze

    def initialize(position: :top_right, color: nil, **attrs)
      @position = position
      @color = color
      @extra_attrs = attrs
    end

    def call
      tag.div(class: 'relative inline-flex') do
        safe_join([
          content,
          tag.div(class: indicator_classes, **@extra_attrs) do
            block_given? ? yield : nil
          end
        ].compact)
      end
    end

    private

    def indicator_classes
      color_class = @color || 'bg-rb-primary'
      merge_classes(
        'absolute flex items-center justify-center',
        POSITIONS[@position] || POSITIONS[:top_right],
        color_class
      )
    end
  end
end
