# frozen_string_literal: true

module HotwireBits
  class VideoPlayerComponent < Base
    ASPECT_RATIOS = {
      '16/9' => 'aspect-video',
      '4/3' => 'aspect-[4/3]',
      '1/1' => 'aspect-square',
      '21/9' => 'aspect-[21/9]'
    }.freeze

    def initialize(src:, poster: nil, autoplay: false, controls: true, aspect_ratio: '16/9', **attrs)
      @src = src
      @poster = poster
      @autoplay = autoplay
      @controls = controls
      @aspect_ratio = aspect_ratio
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'relative overflow-hidden rounded-lg bg-black',
        ASPECT_RATIOS[@aspect_ratio] || ASPECT_RATIOS['16/9'],
        @extra_attrs.delete(:class)
      )
    end
  end
end
