# frozen_string_literal: true

module HotwireBits
  class ImageZoomComponent < Base
    def initialize(src:, alt: nil, zoom_level: 2, container_size: nil, **attrs)
      @src = src
      @alt = alt
      @zoom_level = zoom_level.to_i
      @container_size = container_size
      @extra_attrs = attrs
    end

    def container_style
      @container_size ? "width: #{@container_size}px; height: #{@container_size}px;" : nil
    end
  end
end
