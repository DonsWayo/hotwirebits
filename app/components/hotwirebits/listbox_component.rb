# frozen_string_literal: true

module HotwireBits
  class ListboxComponent < Base
    def initialize(name: nil, options: [], selected: nil, multiple: false, disabled: false, **attrs)
      @name = name
      @options = options
      @selected = Array(selected)
      @multiple = multiple
      @disabled = disabled
      @extra_attrs = attrs
    end

    def call
      tag.div(
        class: 'rounded-md border border-hw-input bg-hw-background',
        role: 'listbox',
        aria: { multiselectable: @multiple },
        data: { controller: 'hw-listbox' },
        **@extra_attrs
      ) do
        safe_join([
          *@options.map { |opt| option_element(opt) },
          (hidden_inputs if @name)
        ].compact)
      end
    end

    private

    def option_element(opt)
      selected = @selected.include?(opt[:value])
      tag.div(
        class: option_classes(selected, opt[:disabled]),
        role: 'option',
        aria: { selected: selected, disabled: opt[:disabled] },
        data: { action: opt[:disabled] ? nil : 'click->hw-listbox#select', value: opt[:value] }
      ) do
        safe_join([
          (check_icon if selected),
          tag.span(opt[:label], class: 'flex-1')
        ].compact)
      end
    end

    def option_classes(selected, disabled)
      merge_classes(
        'flex items-center gap-2 px-3 py-2 text-sm cursor-pointer transition-colors',
        'first:rounded-t-md last:rounded-b-md',
        'hover:bg-hw-accent hover:text-hw-accent-foreground',
        selected ? 'bg-hw-accent text-hw-accent-foreground' : 'text-hw-foreground',
        disabled ? 'opacity-50 pointer-events-none' : ''
      )
    end

    def check_icon
      tag.svg(class: 'h-4 w-4 text-hw-primary shrink-0', fill: 'none', stroke: 'currentColor', stroke_width: '2',
              viewBox: '0 0 24 24') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', d: 'M5 13l4 4L19 7')
      end
    end

    def hidden_inputs
      safe_join(@selected.map { |v| tag.input(type: 'hidden', name: @multiple ? "#{@name}[]" : @name, value: v) })
    end
  end
end
