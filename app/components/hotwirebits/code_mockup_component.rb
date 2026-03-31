# frozen_string_literal: true

module HotwireBits
  class CodeMockupComponent < Base
    LANGUAGES = %w[javascript typescript ruby python html css json bash yaml sql].freeze

    def initialize(code:, language: "javascript", with_line_numbers: true, with_header: true, **attrs)
      @code = code
      @language = language
      @with_line_numbers = with_line_numbers
      @with_header = with_header
      @extra_attrs = attrs
    end

    def lines
      @code.to_s.lines
    end
  end
end
