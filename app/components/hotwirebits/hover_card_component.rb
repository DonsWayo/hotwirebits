# frozen_string_literal: true

module HotwireBits
  class HoverCardComponent < Base
    renders_one :trigger

    def initialize(align: :center, **attrs)
      @align = align
      @extra_attrs = attrs
    end

    private

    def card_classes
      merge_classes(
        "absolute z-50 w-64 rounded-md border border-hw-border bg-hw-popover p-4 text-hw-popover-foreground shadow-md",
        "outline-none data-[state=open]:animate-in data-[state=closed]:animate-out",
        "data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0",
        "data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95",
        "data-[side=bottom]:slide-in-from-top-2",
        "top-full mt-2",
        align_classes,
        @extra_attrs.delete(:class)
      )
    end

    def align_classes
      case @align
      when :start then "left-0"
      when :center then "left-1/2 -translate-x-1/2"
      when :end then "right-0"
      end
    end
  end
end
