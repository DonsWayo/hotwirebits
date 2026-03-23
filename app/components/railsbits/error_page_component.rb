# frozen_string_literal: true

module RailsBits
  class ErrorPageComponent < Base
    CODES = {
      404 => { title: 'Page not found', description: 'Sorry, we couldn\'t find the page you\'re looking for.' },
      500 => { title: 'Internal server error',
               description: 'Something went wrong on our end. Please try again later.' },
      403 => { title: 'Forbidden', description: 'You don\'t have permission to access this resource.' },
      422 => { title: 'Unprocessable entity', description: 'The request was well-formed but had semantic errors.' }
    }.freeze

    def initialize(code: 404, title: nil, description: nil, action_label: nil, action_href: '/', **attrs)
      @code = code
      defaults = CODES[code] || CODES[404]
      @title = title || defaults[:title]
      @description = description || defaults[:description]
      @action_label = action_label
      @action_href = action_href
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'flex min-h-[50vh] flex-col items-center justify-center px-4 text-center',
        @extra_attrs.delete(:class)
      )
    end
  end
end
