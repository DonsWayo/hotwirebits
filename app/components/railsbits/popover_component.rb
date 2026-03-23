# frozen_string_literal: true

module RailsBits
  class PopoverComponent < Base
    renders_one :trigger

    def initialize(align: :center, side: :bottom, open: false, **attrs)
      @align = align
      @side = side
      @open = open
      @extra_attrs = attrs
    end

    private

    def popover_classes
      merge_classes(
        'absolute z-50 rounded-md border border-rb-border bg-rb-popover p-4 text-rb-popover-foreground shadow-md',
        'outline-none data-[state=open]:animate-in data-[state=closed]:animate-out',
        'data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0',
        'data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95',
        side_classes,
        @extra_attrs.delete(:class)
      )
    end

    def side_classes
      case @side
      when :top then 'bottom-full mb-2 data-[side=top]:slide-in-from-bottom-2'
      when :bottom then 'top-full mt-2 data-[side=bottom]:slide-in-from-top-2'
      when :left then 'right-full mr-2 data-[side=left]:slide-in-from-right-2'
      when :right then 'left-full ml-2 data-[side=right]:slide-in-from-left-2'
      end
    end

    def align_classes
      case @align
      when :start then 'left-0'
      when :center then 'left-1/2 -translate-x-1/2'
      when :end then 'right-0'
      end
    end
  end
end
