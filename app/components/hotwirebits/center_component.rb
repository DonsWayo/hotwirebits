# frozen_string_literal: true

module HotwireBits
  class CenterComponent < Base
    def initialize(inline: false, height: nil, **attrs)
      @inline = inline
      @height = height
      @extra_attrs = attrs
    end

    def center_classes
      merge_classes(
        @inline ? 'inline-flex justify-center items-center' : 'flex justify-center items-center',
        @extra_attrs.delete(:class)
      )
    end

    def center_styles
      @height ? "height: #{@height};" : nil
    end
  end
end
