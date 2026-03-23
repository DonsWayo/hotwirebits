# frozen_string_literal: true

module HotwireBits
  class CompareComponent < Base
    def initialize(before_src:, after_src:, before_label: 'Before', after_label: 'After', **attrs)
      @before_src = before_src
      @after_src = after_src
      @before_label = before_label
      @after_label = after_label
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes('relative overflow-hidden rounded-lg select-none', @extra_attrs.delete(:class))
    end
  end
end
