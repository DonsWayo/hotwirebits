# frozen_string_literal: true

module HotwireBits
  class DiffComponent < Base
    renders_one :before_slot
    renders_one :after_slot

    def initialize(before_label: "Before", after_label: "After", **attrs)
      @before_label = before_label
      @after_label = after_label
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        "grid grid-cols-1 md:grid-cols-2 gap-4",
        @extra_attrs.delete(:class)
      )
    end
  end
end
