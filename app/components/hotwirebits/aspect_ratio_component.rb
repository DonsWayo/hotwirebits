# frozen_string_literal: true

module HotwireBits
  class AspectRatioComponent < Base
    RATIOS = {
      '16_9' => 'aspect-video',
      '4_3' => 'aspect-[4/3]',
      '1_1' => 'aspect-square',
      '21_9' => 'aspect-[21/9]',
      custom: nil
    }.freeze

    def initialize(ratio: '16_9', custom_ratio: nil, **attrs)
      @ratio = ratio.to_s
      @custom_ratio = custom_ratio
      @extra_attrs = attrs
    end

    def ratio_classes
      merge_classes(
        @custom_ratio ? "aspect-[#{@custom_ratio}]" : RATIOS[@ratio],
        'w-full',
        @extra_attrs.delete(:class)
      )
    end
  end
end
