# frozen_string_literal: true

module HotwireBits
  class FormGroupComponent < Base
    def initialize(label: nil, hint: nil, error: nil, required: false, name: nil, horizontal: false, **attrs)
      @label = label
      @hint = hint
      @error = error
      @required = required
      @name = name
      @horizontal = horizontal
      @extra_attrs = attrs
    end
  end
end
