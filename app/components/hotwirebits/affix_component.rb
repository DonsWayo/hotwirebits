# frozen_string_literal: true

module HotwireBits
  class AffixComponent < Base
    def initialize(position: :top, offset: 0, z_index: 40, **attrs)
      @position = position
      @offset = offset
      @z_index = z_index
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        "w-full",
        (@position == :top) ? "fixed top-0" : "fixed bottom-0",
        @extra_attrs.delete(:class)
      )
    end

    def container_styles
      offset_prop = (@position == :top) ? "top: #{@offset}px;" : "bottom: #{@offset}px;"
      "#{offset_prop} z-index: #{@z_index};"
    end
  end
end
