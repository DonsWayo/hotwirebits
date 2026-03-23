# frozen_string_literal: true

module HotwireBits
  class DividerComponent < Base
    renders_one :label_slot

    def initialize(orientation: :horizontal, with_label: false, dashed: false, label: nil, **attrs)
      @orientation = orientation
      @with_label = with_label
      @dashed = dashed
      @label = label
      @extra_attrs = attrs
    end

    def divider_classes
      base = if @orientation == :horizontal
               'w-full border-t'
             else
               'h-full border-l'
             end
      merge_classes(
        base,
        @dashed ? 'border-dashed' : 'border-solid',
        'border-hw-border',
        @extra_attrs.delete(:class)
      )
    end
  end
end
