# frozen_string_literal: true

module HotwireBits
  class RichTextEditorComponent < Base
    DEFAULT_TOOLBAR = %w[bold italic underline strikethrough link bullet_list ordered_list heading quote code].freeze

    def initialize(name:, value: nil, placeholder: nil, toolbar: DEFAULT_TOOLBAR, **attrs)
      @name = name
      @value = value
      @placeholder = placeholder
      @toolbar = toolbar
      @extra_attrs = attrs
    end
  end
end
