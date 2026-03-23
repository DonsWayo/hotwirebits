# frozen_string_literal: true

module HotwireBits
  class StackComponent < Base
    GAPS = {
      '0' => 'gap-0', '1' => 'gap-1', '2' => 'gap-2', '3' => 'gap-3',
      '4' => 'gap-4', '6' => 'gap-6', '8' => 'gap-8'
    }.freeze
    ALIGNS = {
      start: 'items-start', center: 'items-center', end: 'items-end', stretch: 'items-stretch'
    }.freeze

    def initialize(gap: '4', align: :stretch, **attrs)
      @gap = gap.to_s
      @align = align
      @extra_attrs = attrs
    end

    def stack_classes
      merge_classes(
        'flex flex-col',
        GAPS[@gap],
        ALIGNS[@align],
        @extra_attrs.delete(:class)
      )
    end
  end
end
