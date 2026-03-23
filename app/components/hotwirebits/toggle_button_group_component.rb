# frozen_string_literal: true

module HotwireBits
  class ToggleButtonGroupComponent < Base
    def initialize(options: [], selected: nil, multiple: false, name: nil, disabled: false, **attrs)
      @options = options
      @selected = Array(selected)
      @multiple = multiple
      @name = name
      @disabled = disabled
      @extra_attrs = attrs
    end

    def call
      tag.div(class: group_classes, role: 'group', aria: { label: 'Toggle options' }, **@extra_attrs) do
        safe_join(@options.map { |opt| option_element(opt) })
      end
    end

    private

    def group_classes
      merge_classes('inline-flex rounded-md border border-hw-input bg-hw-background')
    end

    def option_element(opt)
      pressed = @selected.include?(opt[:value])
      tag.button(
        type: 'button',
        aria: { pressed: pressed },
        disabled: @disabled || opt[:disabled],
        class: option_classes(pressed, opt == @options.last, opt == @options.first),
        data: { action: 'click->hw-toggle-group#select', value: opt[:value] }
      ) do
        tag.span(opt[:label])
      end
    end

    def option_classes(pressed, last, first)
      radius = if first && last
                 'rounded-md'
               elsif first
                 'rounded-l-md'
               elsif last
                 'rounded-r-md'
               else
                 ''
               end

      merge_classes(
        'px-3 py-1.5 text-sm font-medium transition-colors cursor-pointer',
        'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-1',
        'disabled:pointer-events-none disabled:opacity-50',
        'border-r border-hw-input last:border-r-0',
        radius,
        pressed ? 'bg-hw-accent text-hw-accent-foreground' : 'bg-transparent text-hw-muted-foreground hover:bg-hw-accent hover:text-hw-accent-foreground'
      )
    end
  end
end
