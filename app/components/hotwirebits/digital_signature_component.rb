# frozen_string_literal: true

module HotwireBits
  class DigitalSignatureComponent < Base
    def initialize(name:, width: 400, height: 200, pen_color: '#000000', pen_width: 2, **attrs)
      @name = name
      @width = width
      @height = height
      @pen_color = pen_color
      @pen_width = pen_width
      @extra_attrs = attrs
    end
  end
end
