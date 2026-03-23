# frozen_string_literal: true

module HotwireBits
  class OrgChartComponent < Base
    def initialize(nodes: [], **attrs)
      @nodes = nodes
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes('overflow-x-auto', @extra_attrs.delete(:class))
    end
  end
end
