# frozen_string_literal: true

module HotwireBits
  class InputTagsComponent < Base
    def initialize(name: nil, value: [], placeholder: 'Add tag...', disabled: false, max: nil, **attrs)
      @name = name
      @value = value || []
      @placeholder = placeholder
      @disabled = disabled
      @max = max
      @extra_attrs = attrs
    end

    def call
      tag.div(
        class: 'flex flex-wrap gap-1.5 rounded-md border border-hw-input bg-hw-background p-1.5 ring-offset-hw-background focus-within:ring-2 focus-within:ring-hw-ring focus-within:ring-offset-2', data: { controller: 'hw-tags' }
      ) do
        safe_join([
                    *@value.map { |v| chip(v) },
                    tag.input(
                      type: 'text',
                      placeholder: @placeholder,
                      disabled: @disabled || (@max && @value.size >= @max),
                      class: 'flex-1 bg-transparent text-sm text-hw-foreground placeholder:text-hw-muted-foreground outline-none min-w-[80px]',
                      data: { action: 'keydown->hw-tags#keydown', rb_tags_target: 'input' },
                      **@extra_attrs
                    ),
                    *@value.map { |v| tag.input(type: 'hidden', name: "#{@name}[]", value: v) }
                  ])
      end
    end

    private

    def chip(value)
      tag.span(class: 'inline-flex items-center gap-1 rounded-sm bg-hw-secondary px-1.5 py-0.5 text-xs text-hw-secondary-foreground') do
        safe_join([
                    tag.span(value),
                    tag.button(type: 'button', class: 'text-hw-muted-foreground hover:text-hw-foreground',
                               data: { action: 'click->hw-tags#remove', value: value }) do
                      tag.svg(class: 'h-3 w-3', fill: 'none', stroke: 'currentColor', stroke_width: '2',
                              viewBox: '0 0 24 24') do
                        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', d: 'M6 18L18 6M6 6l12 12')
                      end
                    end
                  ])
      end
    end
  end
end
