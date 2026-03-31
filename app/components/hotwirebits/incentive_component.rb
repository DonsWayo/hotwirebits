# frozen_string_literal: true

module HotwireBits
  class IncentiveComponent < Base
    def initialize(icon:, title:, description: nil, **attrs)
      @icon = icon
      @title = title
      @description = description
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes("flex flex-col items-center text-center", @extra_attrs.delete(:class))
    end
  end
end
