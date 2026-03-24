# frozen_string_literal: true

module HotwireBits
  class CloseButtonComponent < Base
    SIZES = {
      sm: 'h-6 w-6',
      md: 'h-8 w-8',
      lg: 'h-10 w-10'
    }.freeze

    ICON_SIZES = {
      sm: 'h-3 w-3',
      md: 'h-4 w-4',
      lg: 'h-5 w-5'
    }.freeze

    def initialize(size: :md, label: 'Close', disabled: false, **attrs)
      @size = size
      @label = label
      @disabled = disabled
      @extra_attrs = attrs
    end

    private

    def button_classes
      merge_classes(
        'inline-flex items-center justify-center rounded-md text-hw-muted-foreground',
        'hover:bg-hw-accent hover:text-hw-accent-foreground transition-colors',
        'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2',
        'disabled:pointer-events-none disabled:opacity-50',
        SIZES[@size] || SIZES[:md]
      )
    end

    def icon_classes
      ICON_SIZES[@size] || ICON_SIZES[:md]
    end
  end
end
