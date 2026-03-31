# frozen_string_literal: true

module HotwireBits
  class Base < ViewComponent::Base
    private

    def merge_classes(*classes)
      classes.compact.join(' ')
    end
  end
end
