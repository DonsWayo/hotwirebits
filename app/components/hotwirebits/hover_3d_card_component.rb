# frozen_string_literal: true

module HotwireBits
  class Hover3dCardComponent < Base
    renders_one :content

    def initialize(intensity: 10, **attrs)
      @intensity = intensity
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes('group [perspective:1000px]', @extra_attrs.delete(:class))
    end
  end
end
