# frozen_string_literal: true

module HotwireBits
  class FloatLabelComponent < Base
    def initialize(label:, name: nil, **attrs)
      @label = label
      @name = name
      @extra_attrs = attrs
    end

    def call
      tag.div(class: 'relative', **@extra_attrs) do
        safe_join([
                    content,
                    tag.label(
                      for: @name,
                      class: 'absolute left-3 top-1/2 -translate-y-1/2 text-sm text-hw-muted-foreground transition-all pointer-events-none peer-placeholder-shown:top-1/2 peer-placeholder-shown:text-sm peer-focus:top-2 peer-focus:text-xs peer-focus:text-hw-primary peer-[:not(:placeholder-shown)]:top-2 peer-[:not(:placeholder-shown)]:text-xs'
                    ) { @label }
                  ])
      end
    end
  end
end
