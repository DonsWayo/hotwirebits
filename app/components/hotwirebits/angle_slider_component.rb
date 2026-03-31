# frozen_string_literal: true

module HotwireBits
  class AngleSliderComponent < Base
    def initialize(name: nil, value: 0, **attrs)
      @name = name
      @value = value.to_i.clamp(0, 360)
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes("relative inline-flex flex-col items-center gap-2", @extra_attrs.delete(:class))
    end

    def radians
      (@value - 90) * Math::PI / 180.0
    end
  end
end
