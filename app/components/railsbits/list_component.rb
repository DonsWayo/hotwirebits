# frozen_string_literal: true

module RailsBits
  class ListComponent < Base
    def initialize(divided: true, with_actions: false, **attrs)
      @divided = divided
      @with_actions = with_actions
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'space-y-0',
        @divided ? 'divide-y divide-rb-border border-y border-rb-border' : '',
        @extra_attrs.delete(:class)
      )
    end
  end
end
