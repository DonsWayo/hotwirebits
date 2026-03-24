# frozen_string_literal: true

module HotwireBits
  class InlineEditComponent < Base
    TYPES = %i[text textarea select].freeze

    def initialize(name:, value: nil, type: :text, options: [], placeholder: nil, **attrs)
      @name = name
      @value = value
      @type = TYPES.include?(type) ? type : :text
      @options = options
      @placeholder = placeholder
      @extra_attrs = attrs
    end
  end
end
