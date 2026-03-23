# frozen_string_literal: true

module HotwireBits
  class PricingSectionComponent < Base
    def initialize(plans: [], title: nil, subtitle: nil, **attrs)
      @plans = plans
      @title = title
      @subtitle = subtitle
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'py-16 md:py-24 px-4',
        @extra_attrs.delete(:class)
      )
    end
  end
end
