# frozen_string_literal: true

module RailsBits
  class TestimonialsSectionComponent < Base
    def initialize(testimonials: [], columns: 3, title: nil, **attrs)
      @testimonials = testimonials
      @columns = [columns, 3].min
      @title = title
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'py-16 md:py-24 px-4',
        @extra_attrs.delete(:class)
      )
    end

    def grid_classes
      "grid gap-6 grid-cols-1 md:grid-cols-#{@columns}"
    end
  end
end
