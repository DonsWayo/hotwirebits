# frozen_string_literal: true

module HotwireBits
  class SpaceComponent < Base
    def initialize(h: nil, w: nil, **attrs)
      @h = h
      @w = w
      @extra_attrs = attrs
    end

    def space_styles
      styles = []
      styles << "height: #{@h};" if @h
      styles << "width: #{@w};" if @w
      styles.join(" ")
    end

    def space_classes
      merge_classes("shrink-0", @extra_attrs.delete(:class))
    end
  end
end
