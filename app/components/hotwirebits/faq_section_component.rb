# frozen_string_literal: true

module HotwireBits
  class FaqSectionComponent < Base
    def initialize(title: nil, items: [], **attrs)
      @title = title
      @items = items
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
