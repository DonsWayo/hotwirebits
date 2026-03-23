# frozen_string_literal: true

module RailsBits
  class BoxComponent < Base
    TAGS = %i[div section article aside main nav header footer span p figure figcaption].freeze

    def initialize(as: :div, **attrs)
      @as = TAGS.include?(as) ? as : :div
      @extra_attrs = attrs
    end

    def box_classes
      @extra_attrs.delete(:class)
    end
  end
end
