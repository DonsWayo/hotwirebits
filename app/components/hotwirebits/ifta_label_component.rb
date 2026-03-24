# frozen_string_literal: true

module HotwireBits
  class IftaLabelComponent < Base
    def initialize(label:, name: nil, **attrs)
      @label = label
      @name = name
      @extra_attrs = attrs
    end
  end
end
