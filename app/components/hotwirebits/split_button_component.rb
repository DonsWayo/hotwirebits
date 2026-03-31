# frozen_string_literal: true

module HotwireBits
  class SplitButtonComponent < Base
    VARIANTS = {
      default: "bg-hw-primary text-hw-primary-foreground hover:bg-hw-primary/90",
      destructive: "bg-hw-destructive text-hw-destructive-foreground hover:bg-hw-destructive/90",
      outline: "border border-hw-input bg-hw-background hover:bg-hw-accent hover:text-hw-accent-foreground",
      secondary: "bg-hw-secondary text-hw-secondary-foreground hover:bg-hw-secondary/80"
    }.freeze

    def initialize(label:, variant: :default, items: [], **attrs)
      @label = label
      @variant = variant
      @items = items
      @extra_attrs = attrs
    end

    def button_classes
      merge_classes(
        "inline-flex h-9 items-center justify-center rounded-l-md px-4 text-sm font-medium transition-colors cursor-pointer",
        VARIANTS[@variant] || VARIANTS[:default]
      )
    end

    def trigger_classes
      merge_classes(
        "inline-flex h-9 w-9 items-center justify-center rounded-r-md border-l border-white/20 text-sm font-medium transition-colors cursor-pointer",
        VARIANTS[@variant] || VARIANTS[:default]
      )
    end
  end
end
