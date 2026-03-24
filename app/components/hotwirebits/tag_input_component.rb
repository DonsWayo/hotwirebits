# frozen_string_literal: true

module HotwireBits
  class TagInputComponent < Base
    def initialize(name:, value: [], placeholder: 'Add tag...', max: nil, pattern: nil, disabled: false, **attrs)
      @name = name
      @value = Array(value)
      @placeholder = placeholder
      @max = max
      @pattern = pattern
      @disabled = disabled
      @extra_attrs = attrs
    end

    private

    def wrapper_classes
      merge_classes(
        'flex flex-wrap gap-1.5 rounded-md border border-hw-input bg-hw-background p-1.5',
        'ring-offset-hw-background focus-within:ring-2 focus-within:ring-hw-ring focus-within:ring-offset-2'
      )
    end

    def input_element
      tag.input(
        type: 'text',
        placeholder: @placeholder,
        disabled: @disabled || (@max && @value.size >= @max),
        pattern: @pattern,
        class: 'flex-1 bg-transparent text-sm text-hw-foreground placeholder:text-hw-muted-foreground outline-none min-w-[80px]',
        data: {
          action: 'keydown->hw-tag-input#keydown blur->hw-tag-input#blur',
          rb_tag_input_target: 'input'
        }
      )
    end

    def tag_chip(value)
      tag.span(class: 'inline-flex items-center gap-1 rounded-sm bg-hw-secondary px-1.5 py-0.5 text-xs text-hw-secondary-foreground') do
        safe_join([
                    tag.span(value),
                    tag.button(
                      type: 'button',
                      class: 'text-hw-muted-foreground hover:text-hw-foreground',
                      data: { action: 'click->hw-tag-input#remove', rb_tag_input_value_param: value }
                    ) do
                      tag.svg(class: 'h-3 w-3', fill: 'none', stroke: 'currentColor', stroke_width: '2',
                              viewBox: '0 0 24 24') do
                        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', d: 'M6 18L18 6M6 6l12 12')
                      end
                    end
                  ])
      end
    end
  end
end
