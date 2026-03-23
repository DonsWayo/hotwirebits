# frozen_string_literal: true

module RailsBits
  class DatePickerComponent < Base
    def initialize(name: nil, value: nil, placeholder: 'Pick a date', size: :md, disabled: false, min: nil, max: nil,
                   **attrs)
      @name = name
      @value = value
      @placeholder = placeholder
      @size = size
      @disabled = disabled
      @min = min
      @max = max
      @extra_attrs = attrs
    end

    def call
      tag.div(class: 'relative', data: { controller: 'rb-datepicker' }) do
        safe_join([
                    input_with_icon,
                    calendar_dropdown
                  ])
      end
    end

    private

    def input_with_icon
      tag.div(class: 'relative') do
        safe_join([
                    tag.div(class: 'absolute left-3 top-1/2 -translate-y-1/2 text-rb-muted-foreground') do
                      tag.svg(class: 'h-4 w-4', fill: 'none', stroke: 'currentColor', stroke_width: '2',
                              viewBox: '0 0 24 24') do
                        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round',
                                 d: 'M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z')
                      end
                    end,
                    tag.input(
                      type: 'date',
                      name: @name,
                      value: @value,
                      min: @min,
                      max: @max,
                      disabled: @disabled,
                      class: input_classes,
                      data: { action: 'focus->rb-datepicker#open' },
                      **@extra_attrs
                    )
                  ])
      end
    end

    def input_classes
      sizes = { sm: 'h-8 pl-9 text-xs', md: 'h-9 pl-9 text-sm', lg: 'h-10 pl-10 text-base' }
      merge_classes(
        'flex w-full rounded-md border border-rb-input bg-rb-background text-rb-foreground',
        'ring-offset-rb-background focus-visible:outline-none focus-visible:ring-2',
        'focus-visible:ring-rb-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50',
        sizes[@size] || sizes[:md]
      )
    end

    def calendar_dropdown
      tag.div(class: 'absolute z-50 mt-1 rounded-md border border-rb-border bg-rb-popover p-3 shadow-md hidden',
              data: { rb_datepicker_target: 'dropdown' }) do
        tag.p('Calendar', class: 'text-sm text-rb-muted-foreground')
      end
    end
  end
end
