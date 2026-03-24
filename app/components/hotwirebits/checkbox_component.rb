# frozen_string_literal: true

module HotwireBits
  class CheckboxComponent < Base
    SIZES = {
      sm: 'h-3.5 w-3.5',
      md: 'h-4 w-4',
      lg: 'h-5 w-5'
    }.freeze

    def initialize(name: nil, value: nil, checked: false, indeterminate: false, disabled: false, label: nil, size: :md,
                   error: false, **attrs)
      @name = name
      @value = value
      @checked = checked
      @indeterminate = indeterminate
      @disabled = disabled
      @label = label
      @size = size
      @error = error
      @extra_attrs = attrs
    end

    private

    def input_element
      attrs = {
        type: 'checkbox',
        name: @name,
        value: @value,
        checked: @checked || @indeterminate,
        disabled: @disabled,
        class: input_classes,
        data: { action: 'change->hw-checkbox#toggle' }
      }
      tag.input(**attrs.merge(@extra_attrs))
    end

    def check_icon
      tag.span(class: 'pointer-events-none absolute inset-0 flex items-center justify-center') do
        tag.svg(class: merge_classes('text-hw-primary-foreground', SIZES[@size] || SIZES[:md]),
                fill: 'none', stroke: 'currentColor', stroke_width: '3', viewBox: '0 0 24 24') do
          tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', d: 'M5 13l4 4L19 7')
        end
      end
    end

    def input_classes
      error_classes = @error ? 'border-hw-destructive' : 'border-hw-input'
      merge_classes(
        'peer shrink-0 rounded-sm border bg-hw-background ring-offset-hw-background',
        'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2',
        'disabled:cursor-not-allowed disabled:opacity-50',
        'checked:bg-hw-primary checked:border-hw-primary',
        error_classes,
        SIZES[@size] || SIZES[:md]
      )
    end

    def label_classes
      'flex items-center gap-2 cursor-pointer'
    end

    def label_text_classes
      text_sizes = { sm: 'text-xs', md: 'text-sm', lg: 'text-base' }
      merge_classes('font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70',
                    text_sizes[@size] || text_sizes[:md])
    end
  end
end
