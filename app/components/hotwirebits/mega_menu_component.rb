# frozen_string_literal: true

module HotwireBits
  class MegaMenuComponent < Base
    def initialize(trigger_label:, columns: [], **attrs)
      @trigger_label = trigger_label
      @columns = columns
      @extra_attrs = attrs
    end
  end
end
