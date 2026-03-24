# frozen_string_literal: true

module HotwireBits
  class ValidatorComponent < Base
    def initialize(field:, rules: [], message: nil, **attrs)
      @field = field
      @rules = rules
      @message = message
      @extra_attrs = attrs
    end
  end
end
