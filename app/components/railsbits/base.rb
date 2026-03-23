# frozen_string_literal: true

module RailsBits
  class Base < ViewComponent::Base
    # Size options
    SIZES = %i[xs sm md lg xl].freeze

    # Common variant options
    VARIANTS = %i[default primary secondary destructive outline ghost link].freeze

    private

    def merge_classes(*classes)
      classes.compact.join(' ')
    end

    def variant_class(variant, map)
      map[variant] || map[:default]
    end

    def size_class(size, map)
      map[size] || map[:md]
    end
  end
end
