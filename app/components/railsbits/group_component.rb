# frozen_string_literal: true

module RailsBits
  class GroupComponent < Base
    ALIGNS = {
      start: 'items-start', center: 'items-center', end: 'items-end',
      baseline: 'items-baseline', stretch: 'items-stretch'
    }.freeze

    def initialize(gap: nil, wrap: false, align: :center, **attrs)
      @gap = gap
      @wrap = wrap
      @align = align
      @extra_attrs = attrs
    end

    def group_classes
      merge_classes(
        'flex flex-row',
        @gap && "gap-#{@gap}",
        @wrap ? 'flex-wrap' : 'flex-nowrap',
        ALIGNS[@align],
        @extra_attrs.delete(:class)
      )
    end
  end
end
