# frozen_string_literal: true

module RailsBits
  class LabelComponent < Base
    def initialize(for_field: nil, required: false, optional: false, **attrs)
      @for_field = for_field
      @required = required
      @optional = optional
      @extra_attrs = attrs
    end

    def call
      tag.label(class: label_classes, for: @for_field, **@extra_attrs) do
        safe_join([
          content,
          (tag.span(' *', class: 'text-rb-destructive') if @required),
          (tag.span(' (optional)', class: 'text-rb-muted-foreground font-normal text-xs ml-1') if @optional)
        ].compact)
      end
    end

    private

    def label_classes
      'text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70'
    end
  end
end
