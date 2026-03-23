# frozen_string_literal: true

module HotwireBits
  class SpinnerComponent < Base
    SIZES = {
      xs: 'h-3 w-3',
      sm: 'h-4 w-4',
      md: 'h-6 w-6',
      lg: 'h-8 w-8',
      xl: 'h-12 w-12'
    }.freeze

    def initialize(size: :md, label: 'Loading...', show_label: false, **attrs)
      @size = size
      @label = label
      @show_label = show_label
      @extra_attrs = attrs
    end

    def call
      tag.div(class: 'inline-flex items-center gap-2', role: 'status', **@extra_attrs) do
        safe_join([
          tag.svg(class: merge_classes('animate-spin text-hw-muted-foreground', SIZES[@size] || SIZES[:md]),
                  xmlns: 'http://www.w3.org/2000/svg', fill: 'none', viewBox: '0 0 24 24') do
            safe_join([
                        tag.circle(class: 'opacity-25', cx: '12', cy: '12', r: '10', stroke: 'currentColor',
                                   stroke_width: '4'),
                        tag.path(class: 'opacity-75', fill: 'currentColor',
                                 d: 'M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z')
                      ])
          end,
          (@show_label ? tag.span(@label, class: 'text-sm text-hw-muted-foreground') : nil),
          tag.span(@label, class: 'sr-only')
        ].compact)
      end
    end
  end
end
