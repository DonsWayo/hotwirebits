# frozen_string_literal: true

module RailsBits
  class RadioComponent < Base
    SIZES = {
      sm: 'h-3.5 w-3.5',
      md: 'h-4 w-4',
      lg: 'h-5 w-5'
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

    def call
      tag.label(class: 'flex items-center gap-2 cursor-pointer') do
        safe_join([
          input_element,
          (if @label
             tag.span(@label,
                      class: 'text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70')
           end)
        ].compact)
      end
    end

    private

    def input_element
      tag.input(
        type: 'radio',
        name: @name,
        value: @value,
        checked: @checked,
        disabled: @disabled,
        class: merge_classes(
          'peer aspect-square shrink-0 rounded-full border border-rb-input bg-rb-background text-rb-primary',
          'ring-offset-rb-background focus-visible:outline-none focus-visible:ring-2',
          'focus-visible:ring-rb-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50',
          SIZES[@size] || SIZES[:md]
        ),
        **@extra_attrs
      )
    end
  end
end
