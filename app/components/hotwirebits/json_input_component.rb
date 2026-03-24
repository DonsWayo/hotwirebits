# frozen_string_literal: true

module HotwireBits
  class JsonInputComponent < Base
    def initialize(name: nil, value: nil, placeholder: '{}', validate: true, rows: 6, **attrs)
      @name = name
      @value = value
      @placeholder = placeholder
      @validate = validate
      @rows = rows
      @extra_attrs = attrs
    end

    def formatted_value
      return '' unless @value.present?

      @value.is_a?(String) ? @value : JSON.pretty_generate(@value)
    end
  end
end
