# frozen_string_literal: true

module HotwireBits
  class ScrollAreaComponent < Base
    ORIENTATIONS = {
      vertical: 'overflow-y-auto overflow-x-hidden',
      horizontal: 'overflow-x-auto overflow-y-hidden'
    }.freeze

    def initialize(height: nil, orientation: :vertical, **attrs)
      @height = height
      @orientation = orientation
      @extra_attrs = attrs
    end

    def scroll_classes
      merge_classes(
        ORIENTATIONS[@orientation],
        'scrollbar-thin scrollbar-track-transparent scrollbar-thumb-hw-border',
        @extra_attrs.delete(:class)
      )
    end

    def scroll_styles
      @height ? "height: #{@height};" : nil
    end
  end
end
