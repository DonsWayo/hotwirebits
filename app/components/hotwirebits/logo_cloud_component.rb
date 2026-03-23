# frozen_string_literal: true

module HotwireBits
  class LogoCloudComponent < Base
    def initialize(title: nil, logos: [], columns: 5, **attrs)
      @title = title
      @logos = logos
      @columns = [columns, 6].min
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'py-12 md:py-16 px-4',
        @extra_attrs.delete(:class)
      )
    end

    def grid_classes
      "grid grid-cols-2 sm:grid-cols-3 md:grid-cols-#{@columns} gap-8 items-center"
    end
  end
end
