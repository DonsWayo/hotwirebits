# frozen_string_literal: true

module HotwireBits
  class StatComponent < Base
    def initialize(title:, value:, description: nil, trend_up: nil, trend_value: nil, icon: nil, **attrs)
      @title = title
      @value = value
      @description = description
      @trend_up = trend_up
      @trend_value = trend_value
      @icon = icon
      @extra_attrs = attrs
    end

    def trend_color
      @trend_up ? "text-hw-success" : "text-hw-destructive"
    end

    def container_classes
      merge_classes(
        "rounded-lg border border-hw-border bg-hw-card p-4 shadow-sm",
        @extra_attrs.delete(:class)
      )
    end
  end
end
