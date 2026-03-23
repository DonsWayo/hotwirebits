# frozen_string_literal: true

module RailsBits
  class StatsComponent < Base
    def initialize(columns: nil, **attrs)
      @columns = columns
      @extra_attrs = attrs
    end

    def container_classes
      grid_cols = case @columns
                  when 2 then 'sm:grid-cols-2'
                  when 3 then 'sm:grid-cols-2 lg:grid-cols-3'
                  when 4 then 'sm:grid-cols-2 lg:grid-cols-4'
                  else 'sm:grid-cols-2 lg:grid-cols-4'
                  end

      merge_classes(
        "grid gap-4 #{grid_cols}",
        @extra_attrs.delete(:class)
      )
    end
  end
end
