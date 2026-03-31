# frozen_string_literal: true

module HotwireBits
  class ToggleButtonComponent < Base
    def initialize(pressed: false, label: nil, icon: nil, disabled: false, **attrs)
      @pressed = pressed
      @label = label
      @icon = icon
      @disabled = disabled
      @extra_attrs = attrs
    end

    private

    def button_classes
      merge_classes(
        "inline-flex items-center gap-2 rounded-md px-3 py-2 text-sm font-medium",
        "ring-offset-hw-background transition-colors",
        "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2",
        "disabled:pointer-events-none disabled:opacity-50 cursor-pointer",
        @pressed ? "bg-hw-accent text-hw-accent-foreground" : "bg-transparent text-hw-muted-foreground hover:bg-hw-accent hover:text-hw-accent-foreground"
      )
    end

    def icon_element
      return unless @icon

      tag.span(class: "h-4 w-4") { safe_svg(@icon) }
    end
  end
end
