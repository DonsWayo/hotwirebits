# frozen_string_literal: true

module HotwireBits
  class RangeSliderComponent < Base
    def initialize(name_min: 'min', name_max: 'max', min: 0, max: 100, value_min: 25, value_max: 75, step: 1,
                   disabled: false, **attrs)
      @name_min = name_min
      @name_max = name_max
      @min = min.to_i
      @max = max.to_i
      @value_min = value_min.to_i
      @value_max = value_max.to_i
      @step = step.to_i
      @disabled = disabled
      @extra_attrs = attrs
    end

    private

    def track_element
      left_pct = ((@value_min - @min).to_f / [@max - @min, 1].max) * 100
      width_pct = ((@value_max - @value_min).to_f / [@max - @min, 1].max) * 100

      tag.div(class: 'absolute top-1/2 -translate-y-1/2 h-2 w-full rounded-full bg-hw-muted') do
        tag.div(
          class: 'absolute h-full rounded-full bg-hw-primary',
          style: "left: #{left_pct}%; width: #{width_pct}%",
          data: { rb_range_slider_target: 'track' }
        )
      end
    end

    def input_element(which)
      value = which == :min ? @value_min : @value_max
      tag.input(
        type: 'range',
        name: which == :min ? @name_min : @name_max,
        value: value,
        min: @min,
        max: @max,
        step: @step,
        disabled: @disabled,
        class: input_classes(which),
        data: { action: "input->hw-range-slider##{which}", rb_range_slider_target: which.to_s }
      )
    end

    def input_classes(which)
      merge_classes(
        'absolute top-0 left-0 w-full h-2 appearance-none bg-transparent pointer-events-none',
        '[&::-webkit-slider-thumb]:pointer-events-auto [&::-webkit-slider-thumb]:appearance-none [&::-webkit-slider-thumb]:h-4 [&::-webkit-slider-thumb]:w-4 [&::-webkit-slider-thumb]:rounded-full [&::-webkit-slider-thumb]:bg-hw-primary [&::-webkit-slider-thumb]:cursor-pointer [&::-webkit-slider-thumb]:border-2 [&::-webkit-slider-thumb]:border-hw-background [&::-webkit-slider-thumb]:shadow',
        '[&::-moz-range-thumb]:pointer-events-auto [&::-moz-range-thumb]:h-4 [&::-moz-range-thumb]:w-4 [&::-moz-range-thumb]:rounded-full [&::-moz-range-thumb]:bg-hw-primary [&::-moz-range-thumb]:cursor-pointer [&::-moz-range-thumb]:border-2 [&::-moz-range-thumb]:border-hw-background [&::-moz-range-thumb]:shadow',
        which == :min ? 'z-10' : 'z-20'
      )
    end
  end
end
