# frozen_string_literal: true

module HotwireBits
  class MonthPickerComponent < Base
    MONTHS = %w[January February March April May June July August September October November December].freeze

    def initialize(name: nil, value: nil, min_date: nil, max_date: nil, **attrs)
      @name = name
      @value = value
      @min_date = min_date
      @max_date = max_date
      @extra_attrs = attrs
    end

    def current_month
      if @value.present?
        begin
          Date.parse(@value.to_s).month
        rescue
          Date.today.month
        end
      else
        Date.today.month
      end
    end

    def current_year
      if @value.present?
        begin
          Date.parse(@value.to_s).year
        rescue
          Date.today.year
        end
      else
        Date.today.year
      end
    end

    def min_year
      @min_date.present? ? Date.parse(@min_date.to_s).year : current_year - 10
    rescue
      current_year - 10
    end

    def max_year
      @max_date.present? ? Date.parse(@max_date.to_s).year : current_year + 10
    rescue
      current_year + 10
    end
  end
end
