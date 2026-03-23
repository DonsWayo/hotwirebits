# frozen_string_literal: true

module RailsBits
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
        'rounded-lg border border-rb-border bg-rb-card text-rb-card-foreground shadow-sm',
        @extra_attrs.delete(:class)
      )
    end
  end
end
