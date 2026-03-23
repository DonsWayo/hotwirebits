# frozen_string_literal: true

module RailsBits
  class ToggleComponent < Base
    VARIANTS = {
      default: 'bg-transparent hover:bg-rb-accent hover:text-rb-accent-foreground',
      outline: 'border border-rb-input bg-transparent hover:bg-rb-accent hover:text-rb-accent-foreground'
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

    def call
      tag.button(
        type: 'button',
        aria: { pressed: @pressed },
        disabled: @disabled,
        class: toggle_classes,
        data: { action: 'click->rb-toggle#toggle' },
        **@extra_attrs
      ) do
        content || @label
      end
    end

    private

    def toggle_classes
      merge_classes(
        'inline-flex items-center justify-center rounded-md font-medium ring-offset-rb-background',
        'transition-colors focus-visible:outline-none focus-visible:ring-2',
        'focus-visible:ring-rb-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50',
        'data-[state=on]:bg-rb-accent data-[state=on]:text-rb-accent-foreground cursor-pointer',
        VARIANTS[@variant] || VARIANTS[:default],
        SIZES[@size] || SIZES[:md]
      )
    end
  end
end
