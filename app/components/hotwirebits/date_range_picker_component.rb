# frozen_string_literal: true

module HotwireBits
  class DateRangePickerComponent < Base
    def initialize(name_start:, name_end:, start_date: nil, end_date: nil, placeholder: 'Select date range', **attrs)
      @name_start = name_start
      @name_end = name_end
      @start_date = start_date
      @end_date = end_date
      @placeholder = placeholder
      @extra_attrs = attrs
    end
  end
end
