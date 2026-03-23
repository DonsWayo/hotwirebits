# frozen_string_literal: true

module HotwireBits
  class HoverGalleryComponent < Base
    def initialize(images: [], height: 300, **attrs)
      @images = images
      @height = height
      @extra_attrs = attrs
    end

    def gallery_style
      "height: #{@height}px"
    end
  end
end
