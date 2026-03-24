# frozen_string_literal: true

module HotwireBits
  class BackgroundImageComponent < Base
    def initialize(src:, size: :cover, position: 'center', overlay: false, **attrs)
      @src = src
      @size = size
      @position = position
      @overlay = overlay
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes('relative', @extra_attrs.delete(:class))
    end
  end
end
