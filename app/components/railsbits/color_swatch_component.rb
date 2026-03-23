# frozen_string_literal: true

module RailsBits
  class ColorSwatchComponent < Base
    SIZES = {
      sm: 'h-5 w-5',
      md: 'h-7 w-7',
      lg: 'h-9 w-9'
    }.freeze

    def initialize(color:, size: :md, with_tooltip: true, **attrs)
      @color = color
      @size = size
      @with_tooltip = with_tooltip
      @extra_attrs = attrs
    end

    def call
      tag.span(
        class: merge_classes('inline-block rounded-full border border-rb-border cursor-pointer',
                             SIZES[@size] || SIZES[:md]),
        style: "background-color: #{@color}",
        title: @with_tooltip ? @color : nil,
        **@extra_attrs
      )
    end
  end
end
