# frozen_string_literal: true

module HotwireBits
  class DashboardCardComponent < Base
    TRENDS = %i[up down neutral].freeze

    def initialize(title:, value:, trend: nil, trend_value: nil, icon: nil, chart_data: nil, **attrs)
      @title = title
      @value = value
      @trend = trend
      @trend_value = trend_value
      @icon = icon
      @chart_data = chart_data
      @extra_attrs = attrs
    end

    def trend_color
      case @trend
      when :up then 'text-hw-success'
      when :down then 'text-hw-destructive'
      else 'text-hw-muted-foreground'
      end
    end
  end
end
