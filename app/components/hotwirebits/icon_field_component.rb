# frozen_string_literal: true

module HotwireBits
  class IconFieldComponent < Base
    POSITIONS = {
      left: 'pr-3 pl-9',
      right: 'pl-3 pr-9'
    }.freeze

    def initialize(icon:, position: :left, **attrs)
      @icon = icon
      @position = position
      @extra_attrs = attrs
    end

    private

    def input_wrapper_classes
      merge_classes(
        '[&>input]:pl-9 [&>select]:pl-9',
        @position == :right ? '[&>input]:pr-9 [&>select]:pr-9' : ''
      )
    end

    def icon_classes = @position == :left ? 'left-3' : 'right-3'

    def icon_element
      tag.div(class: merge_classes('absolute top-1/2 -translate-y-1/2 text-hw-muted-foreground pointer-events-none', icon_classes)) do
        @icon.html_safe
      end
    end
  end
end
