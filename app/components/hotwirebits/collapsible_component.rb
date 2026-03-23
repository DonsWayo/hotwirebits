# frozen_string_literal: true

module HotwireBits
  class CollapsibleComponent < Base
    def initialize(trigger_label:, open: false, **attrs)
      @open = open
      @trigger_label = trigger_label
      @extra_attrs = attrs
    end
  end
end
