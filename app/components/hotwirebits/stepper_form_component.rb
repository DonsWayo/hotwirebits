# frozen_string_literal: true

module HotwireBits
  class StepperFormComponent < Base
    def initialize(steps: [], current_step: 0, submit_label: "Submit", **attrs)
      @steps = steps
      @current_step = current_step.to_i
      @submit_label = submit_label
      @extra_attrs = attrs
    end

    def total_steps
      @steps.size
    end

    def step_state(idx)
      if idx < @current_step then :completed
      elsif idx == @current_step then :current
      else :pending
      end
    end
  end
end
