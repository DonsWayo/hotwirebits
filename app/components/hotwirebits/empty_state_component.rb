# frozen_string_literal: true

module HotwireBits
  class EmptyStateComponent < Base
    def initialize(title: nil, description: nil, icon: nil, action_label: nil, action_href: nil, **attrs)
      @title = title
      @description = description
      @icon = icon
      @action_label = action_label
      @action_href = action_href
      @extra_attrs = attrs
    end
  end
end
