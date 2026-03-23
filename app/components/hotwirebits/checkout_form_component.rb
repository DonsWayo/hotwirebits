# frozen_string_literal: true

module HotwireBits
  class CheckoutFormComponent < Base
    def initialize(steps: [], current_step: 0, **attrs)
      @steps = steps
      @current_step = current_step.to_i
      @extra_attrs = attrs
    end

    def step_status(index)
      if index < @current_step
        :complete
      elsif index == @current_step
        :current
      else
        :upcoming
      end
    end
  end
end
