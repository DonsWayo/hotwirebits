# frozen_string_literal: true

module RailsBits
  class TextareaComponent < Base
    def initialize(name: nil, value: nil, placeholder: nil, rows: 3, max_length: nil, disabled: false, readonly: false,
                   required: false, error: false, resize: true, **attrs)
      @name = name
      @value = value
      @placeholder = placeholder
      @rows = rows
      @max_length = max_length
      @disabled = disabled
      @readonly = readonly
      @required = required
      @error = error
      @resize = resize
      @extra_attrs = attrs
    end

    def call
      tag.textarea(
        name: @name,
        placeholder: @placeholder,
        rows: @rows,
        disabled: @disabled,
        readonly: @readonly,
        required: @required,
        maxlength: @max_length,
        class: textarea_classes,
        **@extra_attrs
      ) { @value }
    end

    private

    def textarea_classes
      error_classes = @error ? 'border-rb-destructive focus-visible:ring-rb-destructive' : 'border-rb-input focus-visible:ring-rb-ring'
      resize_class = @resize ? '' : 'resize-none'
      merge_classes(
        'flex min-h-[60px] w-full rounded-md border bg-rb-background px-3 py-2 text-sm text-rb-foreground',
        'ring-offset-rb-background placeholder:text-rb-muted-foreground',
        'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2',
        'disabled:cursor-not-allowed disabled:opacity-50',
        resize_class,
        error_classes
      )
    end
  end
end
