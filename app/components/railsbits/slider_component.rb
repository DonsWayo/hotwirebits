# frozen_string_literal: true

module RailsBits
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

    def call
      tag.div(class: 'relative w-full') do
        safe_join([
                    (if @show_value
                       tag.div(class: 'flex justify-between mb-2') do
                         safe_join([
                           tag.span(@min.to_s, class: 'text-xs text-rb-muted-foreground'),
                           (if @show_value
                              tag.span(@value.to_s, class: 'text-xs font-medium text-rb-foreground',
                                                    data: { rb_slider_target: 'value' })
                            end),
                           tag.span(@max.to_s, class: 'text-xs text-rb-muted-foreground')
                         ].compact)
                       end
                     end),
                    tag.input(
                      type: 'range',
                      name: @name,
                      value: @value,
                      min: @min,
                      max: @max,
                      step: @step,
                      disabled: @disabled,
                      class: slider_classes,
                      **@extra_attrs
                    )
                  ])
      end
    end

    private

    def slider_classes
      merge_classes(
        'w-full h-2 bg-rb-input rounded-lg appearance-none cursor-pointer',
        'accent-rb-primary',
        'disabled:opacity-50 disabled:cursor-not-allowed',
        '[&::-webkit-slider-thumb]:appearance-none [&::-webkit-slider-thumb]:h-4',
        '[&::-webkit-slider-thumb]:w-4 [&::-webkit-slider-thumb]:rounded-full',
        '[&::-webkit-slider-thumb]:bg-rb-primary [&::-webkit-slider-thumb]:cursor-pointer',
        '[&::-moz-range-thumb]:h-4 [&::-moz-range-thumb]:w-4',
        '[&::-moz-range-thumb]:rounded-full [&::-moz-range-thumb]:bg-rb-primary',
        '[&::-moz-range-thumb]:border-0 [&::-moz-range-thumb]:cursor-pointer'
      )
    end
  end
end
