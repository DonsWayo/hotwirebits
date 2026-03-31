# frozen_string_literal: true

module HotwireBits
  class FieldsetComponent < Base
    def initialize(legend: nil, description: nil, disabled: false, **attrs)
      @legend = legend
      @description = description
      @disabled = disabled
      @extra_attrs = attrs
    end

    private

    def fieldset_classes
      merge_classes(
        "rounded-lg border border-hw-border p-4",
        "disabled:opacity-50 disabled:cursor-not-allowed"
      )
    end
  end
end
