# frozen_string_literal: true

module HotwireBits
  class MonthPickerInputComponent < Base
    def initialize(name: nil, value: nil, placeholder: 'Select month', **attrs)
      @name = name
      @value = value
      @placeholder = placeholder
      @extra_attrs = attrs
    end

    def formatted_value
      return '' unless @value.present?

      date = Date.parse(@value.to_s)
      "#{Date::MONTHNAMES[date.month]} #{date.year}"
    rescue StandardError
      @value.to_s
    end
  end
end
