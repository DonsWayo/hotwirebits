# frozen_string_literal: true

module RailsBits
  class SwitchComponent < Base
    SIZES = {
      sm: { track: 'h-5 w-9', thumb: 'h-4 w-4', translate: 'peer-checked:translate-x-4' },
      md: { track: 'h-6 w-11', thumb: 'h-5 w-5', translate: 'peer-checked:translate-x-5' },
      lg: { track: 'h-7 w-[52px]', thumb: 'h-6 w-6', translate: 'peer-checked:translate-x-6' }
    }.freeze

    def initialize(name: nil, checked: false, disabled: false, label: nil, size: :md, **attrs)
      @name = name
      @checked = checked
      @disabled = disabled
      @label = label
      @size = size
      @extra_attrs = attrs
    end

    def call
      tag.label(class: 'flex items-center gap-2 cursor-pointer') do
        safe_join([
          hidden_input,
          track,
          (@label ? tag.span(@label, class: 'text-sm font-medium') : nil)
        ].compact)
      end
    end

    private

    def hidden_input
      tag.input(type: 'hidden', name: @name, value: '0')
    end

    def track
      size_config = SIZES[@size] || SIZES[:md]
      tag.button(
        type: 'button',
        role: 'switch',
        aria: { checked: @checked },
        disabled: @disabled,
        class: merge_classes(
          'peer inline-flex shrink-0 cursor-pointer items-center rounded-full border-2 border-transparent',
          'transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-rb-ring',
          'focus-visible:ring-offset-2 focus-visible:ring-offset-rb-background disabled:cursor-not-allowed disabled:opacity-50',
          'bg-rb-input data-[checked]:bg-rb-primary',
          size_config[:track]
        ),
        data: { action: 'click->rb-switch#toggle', checked: @checked || nil },
        **@extra_attrs
      ) do
        tag.span(class: merge_classes(
          'pointer-events-none block rounded-full bg-rb-background shadow-lg ring-0 transition-transform',
          'translate-x-0 data-[checked]:translate-x-5',
          size_config[:thumb]
        ), data: { rb_switch_target: 'thumb' })
      end
    end
  end
end
