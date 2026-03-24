# frozen_string_literal: true

module HotwireBits
  class PasswordToggleComponent < Base
    def initialize(target_input: nil, **attrs)
      @target_input = target_input
      @extra_attrs = attrs
    end
  end
end
