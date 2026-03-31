# frozen_string_literal: true

module HotwireBits
  class BurgerComponent < Base
    def initialize(open: false, size: :md, **attrs)
      @open = open
      @size = size
      @extra_attrs = attrs
    end

    private

    def button_classes
      sizes = {
        sm: "h-8 w-8",
        md: "h-10 w-10",
        lg: "h-12 w-12"
      }
      merge_classes(
        "inline-flex items-center justify-center rounded-md text-hw-muted-foreground hover:bg-hw-accent hover:text-hw-accent-foreground transition-colors cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring",
        sizes[@size] || sizes[:md]
      )
    end

    def line_classes
      "block h-0.5 w-5 bg-current transition-all duration-300 ease-in-out"
    end
  end
end
