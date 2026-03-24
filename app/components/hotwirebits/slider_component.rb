# frozen_string_literal: true

module HotwireBits
  class SliderComponent < Base
    def initialize(name: nil, value: 0, min: 0, max: 100, step: 1, disabled: false, show_value: false, color: nil,
                   **attrs)
      @name = name
      @value = value
      @min = min
      @max = max
      @step = step
      @disabled = disabled
      @show_value = show_value
      @color = color
      @extra_attrs = attrs
    end

    private

    def slider_classes
      merge_classes(
        'w-full h-2 bg-hw-input rounded-lg appearance-none cursor-pointer',
        'accent-hw-primary',
        'disabled:opacity-50 disabled:cursor-not-allowed',
        '[&::-webkit-slider-thumb]:appearance-none [&::-webkit-slider-thumb]:h-4',
        '[&::-webkit-slider-thumb]:w-4 [&::-webkit-slider-thumb]:rounded-full',
        '[&::-webkit-slider-thumb]:bg-hw-primary [&::-webkit-slider-thumb]:cursor-pointer',
        '[&::-moz-range-thumb]:h-4 [&::-moz-range-thumb]:w-4',
        '[&::-moz-range-thumb]:rounded-full [&::-moz-range-thumb]:bg-hw-primary',
        '[&::-moz-range-thumb]:border-0 [&::-moz-range-thumb]:cursor-pointer'
      )
    end
  end
end
