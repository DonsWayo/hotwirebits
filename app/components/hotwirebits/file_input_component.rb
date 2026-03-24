# frozen_string_literal: true

module HotwireBits
  class FileInputComponent < Base
    def initialize(name: nil, accept: nil, multiple: false, disabled: false, label: 'Choose file', **attrs)
      @name = name
      @accept = accept
      @multiple = multiple
      @disabled = disabled
      @label = label
      @extra_attrs = attrs
    end

    private

    def label_classes
      merge_classes(
        'flex h-9 items-center justify-center rounded-md border border-dashed border-hw-input',
        'bg-hw-background px-3 text-sm text-hw-muted-foreground ring-offset-hw-background',
        'hover:bg-hw-accent hover:text-hw-accent-foreground cursor-pointer',
        'disabled:cursor-not-allowed disabled:opacity-50'
      )
    end
  end
end
