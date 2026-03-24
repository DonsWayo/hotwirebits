# frozen_string_literal: true

module HotwireBits
  class ToggleComponent < Base
    VARIANTS = {
      default: 'bg-transparent hover:bg-hw-accent hover:text-hw-accent-foreground',
      outline: 'border border-hw-input bg-transparent hover:bg-hw-accent hover:text-hw-accent-foreground'
    }.freeze

    SIZES = {
      sm: 'h-8 px-2 text-xs',
      md: 'h-9 px-3 text-sm',
      lg: 'h-10 px-4'
    }.freeze

    def initialize(label: nil, variant: :default, size: :md, pressed: false, disabled: false, **attrs)
      @label = label
      @variant = variant
      @size = size
      @pressed = pressed
      @disabled = disabled
      @extra_attrs = attrs
    end

    private

    def toggle_classes
      merge_classes(
        'inline-flex items-center justify-center rounded-md font-medium ring-offset-hw-background',
        'transition-colors focus-visible:outline-none focus-visible:ring-2',
        'focus-visible:ring-hw-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50',
        'data-[state=on]:bg-hw-accent data-[state=on]:text-hw-accent-foreground cursor-pointer',
        VARIANTS[@variant] || VARIANTS[:default],
        SIZES[@size] || SIZES[:md]
      )
    end
  end
end
