# frozen_string_literal: true

module HotwireBits
  class DropzoneComponent < Base
    def initialize(name:, accept: nil, multiple: false, max_size: nil, label: nil, description: nil, **attrs)
      @name = name
      @accept = accept
      @multiple = multiple
      @max_size = max_size
      @label = label || "Drop files here or click to upload"
      @description = description
      @extra_attrs = attrs
    end
  end
end
