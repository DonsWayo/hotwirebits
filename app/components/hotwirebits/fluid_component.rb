# frozen_string_literal: true

module HotwireBits
  class FluidComponent < Base
    def initialize(**attrs)
      @extra_attrs = attrs
    end

    def fluid_classes
      merge_classes("w-full", @extra_attrs.delete(:class))
    end
  end
end
