# frozen_string_literal: true

module HotwireBits
  class AccordionComponent < Base
    VARIANTS = {
      default: "",
      bordered: "border border-hw-border rounded-lg overflow-hidden",
      card: "border border-hw-border rounded-lg overflow-hidden shadow-sm"
    }.freeze

    def initialize(items: [], multiple: false, variant: :default, **attrs)
      @items = items
      @multiple = multiple
      @variant = variant
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        @multiple ? "" : "space-y-1",
        VARIANTS[@variant] || VARIANTS[:default],
        @extra_attrs.delete(:class)
      )
    end

    def panel_classes(index)
      if %i[bordered card].include?(@variant)
        (index > 0) ? "border-t border-hw-border" : ""
      else
        "border border-hw-border rounded-lg"
      end
    end
  end
end
