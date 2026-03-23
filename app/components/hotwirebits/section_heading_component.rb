# frozen_string_literal: true

module HotwireBits
  class SectionHeadingComponent < Base
    ALIGNS = {
      left: 'text-left',
      center: 'text-center',
      right: 'text-right'
    }.freeze

    def initialize(title:, description: nil, align: :left, **attrs)
      @title = title
      @description = description
      @align = align
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        ALIGNS[@align] || ALIGNS[:left],
        @align == :center ? 'items-center' : nil,
        @extra_attrs.delete(:class)
      )
    end
  end
end
