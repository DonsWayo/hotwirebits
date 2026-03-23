# frozen_string_literal: true

module RailsBits
  class PasswordInputComponent < Base
    def initialize(name: 'password', value: nil, placeholder: 'Enter password', size: :md, show_toggle: true,
                   show_strength: false, disabled: false, required: false, **attrs)
      @name = name
      @value = value
      @placeholder = placeholder
      @size = size
      @show_toggle = show_toggle
      @show_strength = show_strength
      @disabled = disabled
      @required = required
      @extra_attrs = attrs
    end

    def call
      tag.div(class: 'relative', data: { controller: 'rb-password' }) do
        safe_join([
          input_element,
          (toggle_button if @show_toggle),
          (strength_meter if @show_strength)
        ].compact)
      end
    end

    private

    def size_classes
      { sm: 'h-8 px-3 text-xs pr-9', md: 'h-9 px-3 text-sm pr-10',
        lg: 'h-10 px-4 text-base pr-12' }[@size] || 'h-9 px-3 text-sm pr-10'
    end

    def input_element
      tag.input(
        type: 'password',
        name: @name,
        value: @value,
        placeholder: @placeholder,
        disabled: @disabled,
        required: @required,
        class: merge_classes(
          'flex w-full rounded-md border border-rb-input bg-rb-background text-rb-foreground ring-offset-rb-background',
          'placeholder:text-rb-muted-foreground focus-visible:outline-none focus-visible:ring-2',
          'focus-visible:ring-rb-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50',
          size_classes
        ),
        data: { rb_password_target: 'input' },
        **@extra_attrs
      )
    end

    def toggle_button
      tag.button(
        type: 'button',
        class: 'absolute right-0 top-0 flex h-full items-center px-3 text-rb-muted-foreground hover:text-rb-foreground',
        data: { action: 'click->rb-password#toggle' }
      ) do
        tag.span(data: { rb_password_target: 'icon' }) do
          tag.svg(class: 'h-4 w-4', fill: 'none', stroke: 'currentColor', stroke_width: '2', viewBox: '0 0 24 24') do
            tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', d: 'M15 12a3 3 0 11-6 0 3 3 0 016 0z') +
              tag.path(stroke_linecap: 'round', stroke_linejoin: 'round',
                       d: 'M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z')
          end
        end
      end
    end

    def strength_meter
      tag.div(class: 'mt-2', data: { rb_password_target: 'meter' }) do
        tag.div(class: 'flex gap-1 mb-1') do
          4.times.map do |_i|
            tag.div(class: 'h-1 w-full rounded-full bg-rb-muted', data: { rb_password_target: 'bar' })
          end.join.html_safe
        end +
          tag.p(class: 'text-xs text-rb-muted-foreground', data: { rb_password_target: 'label' },
                text: 'Password strength')
      end
    end
  end
end
