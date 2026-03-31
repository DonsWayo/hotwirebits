# frozen_string_literal: true

module HotwireBits
  class RadioComponent < Base
    SIZES = {
      sm: "h-3.5 w-3.5",
      md: "h-4 w-4",
      lg: "h-5 w-5"
    }.freeze

    def initialize(name: nil, value: nil, checked: false, disabled: false, label: nil, size: :md, **attrs)
      @name = name
      @value = value
      @checked = checked
      @disabled = disabled
      @label = label
      @size = size
      @extra_attrs = attrs
    end

    private

    def input_element
      tag.input(
        type: "radio",
        name: @name,
        value: @value,
        checked: @checked,
        disabled: @disabled,
        class: merge_classes(
          "peer aspect-square shrink-0 rounded-full border border-hw-input bg-hw-background text-hw-primary",
          "ring-offset-hw-background focus-visible:outline-none focus-visible:ring-2",
          "focus-visible:ring-hw-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50",
          SIZES[@size] || SIZES[:md]
        ),
        **@extra_attrs
      )
    end
  end
end
