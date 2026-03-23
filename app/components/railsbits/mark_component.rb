# frozen_string_literal: true

module RailsBits
  class MarkComponent < Base
    def initialize(color: nil, **attrs)
      @color = color
      @extra_attrs = attrs
    end

    def mark_classes
      merge_classes(
        @color || 'bg-yellow-200 text-inherit rounded-sm px-0.5',
        @extra_attrs.delete(:class)
      )
    end
  end
end
