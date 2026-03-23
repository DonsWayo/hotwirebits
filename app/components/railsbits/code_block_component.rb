# frozen_string_literal: true

module RailsBits
  class CodeBlockComponent < Base
    def initialize(code:, language: nil, copyable: true, **attrs)
      @code = code
      @language = language
      @copyable = copyable
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'relative rounded-lg border border-rb-border bg-rb-muted',
        @extra_attrs.delete(:class)
      )
    end
  end
end
