# frozen_string_literal: true

module RailsBits
  class InputComponent < Base
    SIZES = {
      sm: 'h-8 px-3 text-xs',
      md: 'h-9 px-3 text-sm',
      lg: 'h-10 px-4 text-base'
    }.freeze

    def initialize(
      type: 'text',
      name: nil,
      value: nil,
      placeholder: nil,
      size: :md,
      disabled: false,
      readonly: false,
      required: false,
      error: false,
      icon: nil,
      icon_position: :left,
      autocomplete: nil,
      min: nil,
      max: nil,
      step: nil,
      pattern: nil,
      **attrs
    )
      @type = type
      @name = name
      @value = value
      @placeholder = placeholder
      @size = size
      @disabled = disabled
      @readonly = readonly
      @required = required
      @error = error
      @icon = icon
      @icon_position = icon_position
      @autocomplete = autocomplete
      @min = min
      @max = max
      @step = step
      @pattern = pattern
      @extra_attrs = attrs
    end

    def call
      if @icon
        tag.div(class: 'relative') do
          safe_join([
            icon_element,
            input_element
          ].compact)
        end
      else
        input_element
      end
    end

    private

    def input_element
      tag.input(
        type: @type,
        name: @name,
        value: @value,
        placeholder: @placeholder,
        disabled: @disabled,
        readonly: @readonly,
        required: @required,
        autocomplete: @autocomplete,
        min: @min,
        max: @max,
        step: @step,
        pattern: @pattern,
        class: input_classes,
        **@extra_attrs
      )
    end

    def input_classes
      error_classes = @error ? 'border-rb-destructive focus-visible:ring-rb-destructive' : 'border-rb-input focus-visible:ring-rb-ring'
      icon_padding = if @icon
                       @icon_position == :left ? 'pl-9' : 'pr-9'
                     else
                       ''
                     end

      merge_classes(
        'flex w-full rounded-md border bg-rb-background text-rb-foreground ring-offset-rb-background',
        'file:border-0 file:bg-transparent file:text-sm file:font-medium',
        'placeholder:text-rb-muted-foreground',
        'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2',
        'disabled:cursor-not-allowed disabled:opacity-50',
        error_classes,
        icon_padding,
        SIZES[@size] || SIZES[:md]
      )
    end

    def icon_element
      position_class = @icon_position == :left ? 'left-3' : 'right-3'
      tag.div(class: merge_classes('absolute top-1/2 -translate-y-1/2 text-rb-muted-foreground', position_class)) do
        @icon.html_safe
      end
    end
  end
end
