# frozen_string_literal: true

module HotwireBits
  class PageHeadingComponent < Base
    renders_one :actions

    def initialize(title:, description: nil, tabs: [], **attrs)
      @title = title
      @description = description
      @tabs = tabs
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes("pb-4", @extra_attrs.delete(:class))
    end
  end
end
