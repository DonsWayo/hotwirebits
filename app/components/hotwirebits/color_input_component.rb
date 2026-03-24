# frozen_string_literal: true

module HotwireBits
  class ColorInputComponent < Base
    FORMATS = %i[hex rgb hsl].freeze

    def initialize(name:, value: '#000000', format: :hex, **attrs)
      @name = name
      @value = value
      @format = FORMATS.include?(format) ? format : :hex
      @extra_attrs = attrs
    end
  end
end
