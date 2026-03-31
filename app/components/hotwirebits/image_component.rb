# frozen_string_literal: true

module HotwireBits
  class ImageComponent < Base
    def initialize(src:, alt:, caption: nil, fallback: nil, zoomable: false, width: nil, height: nil, **attrs)
      @src = src
      @alt = alt
      @caption = caption
      @fallback = fallback
      @zoomable = zoomable
      @width = width
      @height = height
      @extra_attrs = attrs
    end

    def figure_classes
      merge_classes(
        @zoomable ? "cursor-zoom-in" : "",
        @extra_attrs.delete(:class)
      )
    end
  end
end
