# frozen_string_literal: true

module HotwireBits
  class FormFieldsetComponent < Base
    def initialize(legend: nil, description: nil, **attrs)
      @legend = legend
      @description = description
      @extra_attrs = attrs
    end
  end
end
