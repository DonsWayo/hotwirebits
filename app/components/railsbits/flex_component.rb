# frozen_string_literal: true

module RailsBits
  class FlexComponent < Base
    DIRECTIONS = { row: 'flex-row', column: 'flex-col' }.freeze
    WRAPS = { wrap: 'flex-wrap', nowrap: 'flex-nowrap', reverse: 'flex-wrap-reverse' }.freeze
    JUSTIFIES = {
      start: 'justify-start', end: 'justify-end', center: 'justify-center',
      between: 'justify-between', around: 'justify-around', evenly: 'justify-evenly'
    }.freeze
    ALIGNS = {
      start: 'items-start', end: 'items-end', center: 'items-center',
      baseline: 'items-baseline', stretch: 'items-stretch'
    }.freeze

    def initialize(direction: :row, wrap: nil, justify: nil, align: nil, gap: nil, **attrs)
      @direction = direction
      @wrap = wrap
      @justify = justify
      @align = align
      @gap = gap
      @extra_attrs = attrs
    end

    def flex_classes
      merge_classes(
        'flex',
        DIRECTIONS[@direction],
        @wrap && WRAPS[@wrap],
        @justify && JUSTIFIES[@justify],
        @align && ALIGNS[@align],
        @gap && "gap-#{@gap}",
        @extra_attrs.delete(:class)
      )
    end
  end
end
