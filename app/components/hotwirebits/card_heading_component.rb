# frozen_string_literal: true

module HotwireBits
  class CardHeadingComponent < Base
    def initialize(title:, subtitle: nil, action_label: nil, action_href: nil, **attrs)
      @title = title
      @subtitle = subtitle
      @action_label = action_label
      @action_href = action_href
      @extra_attrs = attrs
    end
  end
end
