# frozen_string_literal: true

module RailsBits
  class AccordionComponent < Base
    VARIANTS = {
      default: '',
      bordered: 'border border-rb-border rounded-lg overflow-hidden',
      card: 'border border-rb-border rounded-lg overflow-hidden shadow-sm'
    }.freeze

    def initialize(items: [], multiple: false, variant: :default, **attrs)
      @items = items
      @multiple = multiple
      @variant = variant
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        @multiple ? '' : 'space-y-1',
        VARIANTS[@variant] || VARIANTS[:default],
        @extra_attrs.delete(:class)
      )
    end

    def panel_classes(index)
      if %i[bordered card].include?(@variant)
        index > 0 ? 'border-t border-rb-border' : ''
      else
        'border border-rb-border rounded-lg'
      end
    end
  end
end
