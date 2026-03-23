# frozen_string_literal: true

module HotwireBits
  class ImageCompareComponent < Base
    def initialize(before:, after:, labels: nil, **attrs)
      @before = before
      @after = after
      @labels = labels
      @extra_attrs = attrs
    end
  end
end
