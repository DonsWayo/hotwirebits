# frozen_string_literal: true

module HotwireBits
  class AppShellComponent < Base
    renders_one :header
    renders_one :sidebar
    renders_one :content
    renders_one :footer

    def initialize(sidebar_collapsed: false, **attrs)
      @sidebar_collapsed = sidebar_collapsed
      @extra_attrs = attrs
    end
  end
end
