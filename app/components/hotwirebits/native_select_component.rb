# frozen_string_literal: true

module HotwireBits
  class NativeSelectComponent < Base
    def initialize(name: nil, options: [], selected: nil, placeholder: "Select...", disabled: false, **attrs)
      @name = name
      @options = options
      @selected = selected
      @placeholder = placeholder
      @disabled = disabled
      @extra_attrs = attrs
    end

    private

    def select_classes
      "h-9 w-full rounded-md border border-hw-input bg-hw-background px-3 text-sm text-hw-foreground ring-offset-hw-background focus:outline-none focus:ring-2 focus:ring-hw-ring focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
    end
  end
end
