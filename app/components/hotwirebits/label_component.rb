# frozen_string_literal: true

module HotwireBits
  class LabelComponent < Base
    def initialize(for_field: nil, required: false, optional: false, **attrs)
      @for_field = for_field
      @required = required
      @optional = optional
      @extra_attrs = attrs
    end

    private

    def label_classes
      'text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70'
    end
  end
end
