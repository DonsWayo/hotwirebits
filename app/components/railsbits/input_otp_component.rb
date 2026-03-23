# frozen_string_literal: true

module RailsBits
  class InputOtpComponent < Base
    def initialize(name: nil, length: 6, value: nil, disabled: false, numeric_only: true, **attrs)
      @name = name
      @length = length
      @value = value.to_s
      @disabled = disabled
      @numeric_only = numeric_only
      @extra_attrs = attrs
    end

    def call
      tag.div(class: 'flex items-center gap-2', data: { controller: 'rb-otp' }) do
        safe_join([
                    hidden_input,
                    *@length.times.map do |i|
                      tag.input(
                        type: 'text',
                        maxlength: 1,
                        inputmode: @numeric_only ? 'numeric' : 'text',
                        disabled: @disabled,
                        value: @value[i],
                        class: input_classes,
                        data: { action: 'input->rb-otp#input keydown->rb-otp#keydown', index: i },
                        **@extra_attrs
                      )
                    end
                  ])
      end
    end

    private

    def hidden_input
      tag.input(type: 'hidden', name: @name, value: @value, data: { rb_otp_target: 'hidden' })
    end

    def input_classes
      merge_classes(
        'h-10 w-10 text-center text-lg font-semibold rounded-md border border-rb-input bg-rb-background',
        'text-rb-foreground ring-offset-rb-background focus-visible:outline-none',
        'focus-visible:ring-2 focus-visible:ring-rb-ring focus-visible:ring-offset-2',
        'disabled:cursor-not-allowed disabled:opacity-50'
      )
    end
  end
end
