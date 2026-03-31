# frozen_string_literal: true

module HotwireBits
  class HeaderSectionComponent < Base
    renders_one :actions

    def initialize(title:, subtitle: nil, breadcrumbs: [], **attrs)
      @title = title
      @subtitle = subtitle
      @breadcrumbs = breadcrumbs
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes("pb-6 border-b border-hw-border", @extra_attrs.delete(:class))
    end
  end
end
