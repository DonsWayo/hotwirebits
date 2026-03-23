# frozen_string_literal: true

module HotwireBits
  class NumberFormatterComponent < Base
    def initialize(value:, locale: nil, currency: nil, compact: false, precision: nil, **attrs)
      @value = value
      @locale = locale || I18n.locale
      @currency = currency
      @compact = compact
      @precision = precision
      @extra_attrs = attrs
    end

    def formatted_value
      opts = {}
      opts[:precision] = @precision if @precision

      if @currency
        number_to_currency(@value, locale: @locale, currency: @currency, **opts)
      elsif @compact
        number_to_human(@value, locale: @locale, **opts)
      else
        number_with_delimiter(@value, locale: @locale, **opts)
      end
    end
  end
end
