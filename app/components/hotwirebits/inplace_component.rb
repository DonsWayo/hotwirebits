# frozen_string_literal: true

module HotwireBits
  class InplaceComponent < Base
    def initialize(value: nil, display_class: nil, name: nil, placeholder: "Click to edit", disabled: false, **attrs)
      @value = value
      @display_class = display_class
      @name = name
      @placeholder = placeholder
      @disabled = disabled
      @extra_attrs = attrs
    end

    private

    def display_element
      tag.div(
        class: merge_classes("cursor-pointer rounded-md px-2 py-1 hover:bg-hw-accent transition-colors min-h-[2rem]",
          @display_class),
        data: {action: @disabled ? nil : "click->hw-inplace#edit", rb_inplace_target: "display"}
      ) do
        @value.presence || tag.span(@placeholder, class: "text-hw-muted-foreground")
      end
    end

    def edit_element
      tag.input(
        type: "text",
        name: @name,
        value: @value,
        class: "hidden w-full rounded-md border border-hw-input bg-hw-background px-2 py-1 text-sm text-hw-foreground focus:outline-none focus:ring-2 focus:ring-hw-ring",
        data: {
          rb_inplace_target: "input",
          action: "blur->hw-inplace#save keydown->hw-inplace#keydown"
        }
      )
    end
  end
end
