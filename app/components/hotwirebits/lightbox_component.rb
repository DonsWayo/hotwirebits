# frozen_string_literal: true

module HotwireBits
  class LightboxComponent < Base
    def initialize(images: [], current_index: 0, **attrs)
      @images = images
      @current_index = current_index
      @extra_attrs = attrs
    end
  end
end
