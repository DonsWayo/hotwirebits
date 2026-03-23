# frozen_string_literal: true

module RailsBits
  class ColorPickerComponent < Base
    def initialize(name: nil, value: '#000000', disabled: false, show_input: true, **attrs)
      @name = name
      @value = value
      @disabled = disabled
      @show_input = show_input
      @extra_attrs = attrs
    end

    def call
      tag.div(class: 'flex items-center gap-2', data: { controller: 'rb-color-picker' }) do
        safe_join([
                    color_input,
                    (text_input if @show_input)
                  ])
      end
    end

    private

    def color_input
      tag.input(
        type: 'color',
        name: @name,
        value: @value,
        disabled: @disabled,
        class: 'h-9 w-9 cursor-pointer rounded-md border border-rb-input bg-transparent p-0.5 disabled:cursor-not-allowed disabled:opacity-50',
        data: { action: 'input->rb-color-picker#update' },
        **@extra_attrs
      )
    end

    def text_input
      tag.input(
        type: 'text',
        value: @value,
        disabled: @disabled,
        class: 'h-9 w-24 rounded-md border border-rb-input bg-rb-background px-3 text-sm text-rb-foreground ring-offset-rb-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-rb-ring focus-visible:ring-offset-2',
        data: { rb_color_picker_target: 'text', action: 'input->rb-color-picker#parse' }
      )
    end
  end
end
