# frozen_string_literal: true

module RailsBits
  class NumberInputComponent < Base
    def initialize(name: nil, value: nil, min: nil, max: nil, step: 1, placeholder: nil, size: :md, disabled: false,
                   format: nil, **attrs)
      @name = name
      @value = value
      @min = min
      @max = max
      @step = step
      @placeholder = placeholder
      @size = size
      @disabled = disabled
      @format = format
      @extra_attrs = attrs
    end

    def call
      tag.input(
        type: 'number',
        name: @name,
        value: @value,
        placeholder: @placeholder,
        min: @min,
        max: @max,
        step: @step,
        disabled: @disabled,
        class: input_classes,
        **@extra_attrs
      )
    end

    private

    def input_classes
      sizes = { sm: 'h-8 px-3 text-xs', md: 'h-9 px-3 text-sm', lg: 'h-10 px-4 text-base' }
      merge_classes(
        'flex w-full rounded-md border border-rb-input bg-rb-background text-rb-foreground',
        'ring-offset-rb-background placeholder:text-rb-muted-foreground',
        'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-rb-ring focus-visible:ring-offset-2',
        'disabled:cursor-not-allowed disabled:opacity-50',
        sizes[@size] || sizes[:md]
      )
    end
  end
end
