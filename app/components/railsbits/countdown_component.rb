# frozen_string_literal: true

module RailsBits
  class CountdownComponent < Base
    def initialize(value: 0, target: 0, prefix: '', suffix: '', duration: 2000, **attrs)
      @value = value
      @target = target
      @prefix = prefix
      @suffix = suffix
      @duration = duration
      @extra_attrs = attrs
    end
  end
end
