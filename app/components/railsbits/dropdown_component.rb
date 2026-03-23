# frozen_string_literal: true

module RailsBits
  class DropdownComponent < Base
    def initialize(trigger_label: nil, align: :start, items: [], **attrs)
      @trigger_label = trigger_label
      @align = align
      @items = items
      @extra_attrs = attrs
    end

    private

    def panel_classes
      merge_classes(
        'absolute z-50 mt-1 min-w-[8rem] overflow-hidden rounded-md border border-rb-border bg-rb-popover p-1 text-rb-popover-foreground shadow-md',
        @align == :end ? 'right-0' : 'left-0'
      )
    end
  end
end
