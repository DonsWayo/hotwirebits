# frozen_string_literal: true

module RailsBits
  class SearchComponent < Base
    def initialize(name: 'q', placeholder: 'Search...', suggestions: [], with_filters: false, value: nil, **attrs)
      @name = name
      @placeholder = placeholder
      @suggestions = suggestions
      @with_filters = with_filters
      @value = value
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'relative w-full',
        @extra_attrs.delete(:class)
      )
    end
  end
end
