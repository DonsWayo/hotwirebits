# frozen_string_literal: true

module HotwireBits
  class MaskComponent < Base
    SHAPES = {
      circle: 'mask-circle',
      squircle: 'mask-squircle',
      hexagon: 'mask-hexagon',
      triangle: 'mask-triangle',
      diamond: 'mask-diamond'
    }.freeze

    def initialize(shape: :circle, **attrs)
      @shape = shape
      @extra_attrs = attrs
    end

    def mask_classes
      merge_classes(
        SHAPES[@shape],
        @extra_attrs.delete(:class)
      )
    end
  end
end
