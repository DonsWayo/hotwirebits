# frozen_string_literal: true

module RailsBits
  class ClipboardComponent < Base
    def initialize(text:, label: nil, success_message: 'Copied!', **attrs)
      @text = text
      @label = label
      @success_message = success_message
      @extra_attrs = attrs
    end

    def wrapper_classes
      merge_classes(
        'inline-flex items-center gap-2',
        @extra_attrs.delete(:class)
      )
    end
  end
end
