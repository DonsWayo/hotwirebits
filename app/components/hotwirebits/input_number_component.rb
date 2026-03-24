# frozen_string_literal: true

module HotwireBits
  class InputNumberComponent < Base
    SIZES = {
      sm: 'h-8 text-xs',
      md: 'h-9 text-sm',
      lg: 'h-10 text-base'
    }.freeze

    BUTTON_SIZES = {
      sm: 'h-8 w-8',
      md: 'h-9 w-9',
      lg: 'h-10 w-10'
    }.freeze

    def initialize(name: nil, value: 0, min: nil, max: nil, step: 1, currency: nil, size: :md, disabled: false, **attrs)
      @name = name
      @value = value
      @min = min
      @max = max
      @step = step
      @currency = currency
      @size = size
      @disabled = disabled
      @extra_attrs = attrs
    end

    private

    def input_element
      tag.div(class: 'relative flex items-center') do
        safe_join([
                    (if @currency
                       tag.span(@currency,
                                class: 'absolute left-2 text-xs text-hw-muted-foreground pointer-events-none')
                     end),
                    tag.input(
                      type: 'number',
                      name: @name,
                      value: @value,
                      min: @min,
                      max: @max,
                      step: @step,
                      disabled: @disabled,
                      class: merge_classes(
                        'w-16 bg-transparent text-center text-hw-foreground outline-none',
                        'border-x border-hw-input',
                        'disabled:cursor-not-allowed disabled:opacity-50',
                        'appearance-none [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none',
                        @currency ? 'pl-7' : '',
                        SIZES[@size] || SIZES[:md]
                      ),
                      data: { rb_input_number_target: 'input' }
                    )
                  ])
      end
    end

    def button_element(action)
      icon_path = action == :increment ? 'M5 15l7-7 7 7' : 'M19 9l-7 7-7-7'
      tag.button(
        type: 'button',
        disabled: @disabled,
        class: merge_classes(
          'inline-flex items-center justify-center text-hw-muted-foreground hover:bg-hw-accent hover:text-hw-accent-foreground transition-colors',
          'disabled:pointer-events-none disabled:opacity-50',
          BUTTON_SIZES[@size] || BUTTON_SIZES[:md]
        ),
        data: { action: "click->hw-input-number##{action}" }
      ) do
        tag.svg(class: 'h-4 w-4', fill: 'none', stroke: 'currentColor', stroke_width: '2', viewBox: '0 0 24 24') do
          tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', d: icon_path)
        end
      end
    end
  end
end
