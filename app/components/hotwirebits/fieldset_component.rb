# frozen_string_literal: true

module HotwireBits
  class FieldsetComponent < Base
    def initialize(legend: nil, description: nil, disabled: false, **attrs)
      @legend = legend
      @description = description
      @disabled = disabled
      @extra_attrs = attrs
    end

    def call
      tag.fieldset(class: fieldset_classes, disabled: @disabled, **@extra_attrs) do
        safe_join([
          (tag.legend(class: 'text-sm font-medium text-hw-foreground') { @legend } if @legend),
          (tag.p(@description, class: 'text-xs text-hw-muted-foreground mt-1 mb-3') if @description),
          tag.div(class: 'space-y-3') { content }
        ].compact)
      end
    end

    private

    def fieldset_classes
      merge_classes(
        'rounded-lg border border-hw-border p-4',
        'disabled:opacity-50 disabled:cursor-not-allowed'
      )
    end
  end
end
