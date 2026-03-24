# frozen_string_literal: true

module HotwireBits
  class DragDropListComponent < Base
    ORIENTATIONS = %i[vertical horizontal].freeze

    def initialize(items: [], orientation: :vertical, **attrs)
      @items = items
      @orientation = ORIENTATIONS.include?(orientation) ? orientation : :vertical
      @extra_attrs = attrs
    end

    def list_classes
      merge_classes(
        'flex gap-2',
        @orientation == :horizontal ? 'flex-row flex-wrap' : 'flex-col'
      )
    end
  end
end
