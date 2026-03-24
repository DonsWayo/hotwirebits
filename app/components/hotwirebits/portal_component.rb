# frozen_string_literal: true

module HotwireBits
  class PortalComponent < Base
    def initialize(target: 'body', **attrs)
      @target = target
      @extra_attrs = attrs
    end
  end
end
