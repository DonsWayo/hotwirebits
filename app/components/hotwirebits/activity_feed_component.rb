# frozen_string_literal: true

module HotwireBits
  class ActivityFeedComponent < Base
    def initialize(items: [], load_more: false, **attrs)
      @items = items
      @load_more = load_more
      @extra_attrs = attrs
    end
  end
end
