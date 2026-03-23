# frozen_string_literal: true

module RailsBits
  class KanbanBoardComponent < Base
    def initialize(columns: [], **attrs)
      @columns = columns
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'flex gap-4 overflow-x-auto pb-4',
        @extra_attrs.delete(:class)
      )
    end
  end
end
