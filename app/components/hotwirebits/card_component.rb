# frozen_string_literal: true

module HotwireBits
  class CardComponent < Base
    renders_one :header
    renders_one :footer

    def initialize(title: nil, description: nil, **attrs)
      @title = title
      @description = description
      @extra_attrs = attrs
    end

    def card_classes
      merge_classes(
        "rounded-lg border border-hw-border bg-hw-card text-hw-card-foreground shadow-sm",
        @extra_attrs.delete(:class)
      )
    end
  end
end
