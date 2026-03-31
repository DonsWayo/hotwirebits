# frozen_string_literal: true

module HotwireBits
  class Base < ViewComponent::Base
    include HotwirebitsHelper

    private

    def merge_classes(*classes)
      classes.flatten.compact.reject { |c| c.to_s.strip.empty? }.join(' ')
    end
  end
end
