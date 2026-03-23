# frozen_string_literal: true

module HotwireBits
  class IftaLabelComponent < Base
    def initialize(label:, name: nil, **attrs)
      @label = label
      @name = name
      @extra_attrs = attrs
    end

    def call
      tag.div(class: 'relative', **@extra_attrs) do
        safe_join([
                    tag.div(class: 'peer') { content },
                    tag.label(
                      for: @name,
                      class: 'absolute left-3 top-0 -translate-y-1/2 bg-hw-background px-1 text-xs font-medium text-hw-muted-foreground transition-all peer-focus:text-hw-primary'
                    ) { @label }
                  ])
      end
    end
  end
end
