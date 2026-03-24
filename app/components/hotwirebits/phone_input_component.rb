# frozen_string_literal: true

module HotwireBits
  class PhoneInputComponent < Base
    def initialize(name: 'phone', value: nil, placeholder: '+1 (555) 000-0000', size: :md, country_code: nil,
                   disabled: false, **attrs)
      @name = name
      @value = value
      @placeholder = placeholder
      @size = size
      @country_code = country_code
      @disabled = disabled
      @extra_attrs = attrs
    end

    private

    def input_classes
      sizes = { sm: 'h-8 px-3 text-xs', md: 'h-9 px-3 text-sm', lg: 'h-10 px-4 text-base' }
      merge_classes(
        'flex w-full rounded-md border border-hw-input bg-hw-background text-hw-foreground',
        'ring-offset-hw-background placeholder:text-hw-muted-foreground',
        'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2',
        'disabled:cursor-not-allowed disabled:opacity-50',
        sizes[@size] || sizes[:md]
      )
    end
  end
end
