# frozen_string_literal: true

module HotwireBits
  class TimePickerComponent < Base
    FORMATS = %i[twelve twenty_four].freeze

    def initialize(name: nil, value: nil, time_format: :twenty_four, step: 1, disabled: false, **attrs)
      @name = name
      @value = value
      @time_format = time_format
      @step = step
      @disabled = disabled
      @extra_attrs = attrs
    end

    def twelve_hour?
      @time_format == :twelve
    end

    def input_classes
      merge_classes(
        "h-9 w-full rounded-md border border-hw-input bg-hw-background px-3 text-sm text-hw-foreground",
        "ring-offset-hw-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2",
        "disabled:cursor-not-allowed disabled:opacity-50"
      )
    end
  end
end
