# frozen_string_literal: true

module HotwireBits
  class SidebarComponent < Base
    renders_one :header
    renders_one :body
    renders_one :footer

    def initialize(items: [], collapsed: false, width: 260, mobile: false, title: nil, **attrs)
      @items = items
      @collapsed = collapsed
      @width = width
      @mobile = mobile
      @title = title
      @extra_attrs = attrs
    end

    private

    def sidebar_classes
      merge_classes(
        "flex h-full flex-col border-r border-hw-border bg-hw-background",
        "transition-[width] duration-300 ease-in-out",
        @collapsed ? "w-16" : nil,
        @mobile ? "fixed inset-y-0 left-0 z-50 shadow-lg" : nil
      )
    end
  end
end
