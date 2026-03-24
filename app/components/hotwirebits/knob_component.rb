# frozen_string_literal: true

module HotwireBits
  class KnobComponent < Base
    SIZES = {
      sm: 48,
      md: 64,
      lg: 96
    }.freeze

    def initialize(value: 0, min: 0, max: 100, step: 1, size: :md, color: nil, name: nil, disabled: false, **attrs)
      @value = value.to_i
      @min = min.to_i
      @max = max.to_i
      @step = step.to_i
      @size = size
      @color = color || 'hw-primary'
      @name = name
      @disabled = disabled
      @extra_attrs = attrs
    end
  end
end
