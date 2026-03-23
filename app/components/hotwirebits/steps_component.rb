# frozen_string_literal: true

module HotwireBits
  class StepsComponent < Base
    def initialize(steps: [], current_step: 0, orientation: :horizontal, clickable: false, **attrs)
      @steps = steps
      @current_step = current_step.to_i
      @orientation = orientation
      @clickable = clickable
      @extra_attrs = attrs
    end

    private

    def container_classes
      merge_classes(
        @orientation == :horizontal ? 'flex items-start' : 'flex flex-col',
        @orientation == :horizontal ? 'w-full' : nil
      )
    end

    def step_state(idx)
      if idx < @current_step then :completed
      elsif idx == @current_step then :current
      else :pending
      end
    end

    def step_circle_classes(state)
      base = 'flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-sm font-medium transition-colors'
      case state
      when :completed then merge_classes(base, 'bg-hw-primary text-hw-primary-foreground')
      when :current then merge_classes(base, 'border-2 border-hw-primary text-hw-primary')
      else merge_classes(base, 'border-2 border-hw-border text-hw-muted-foreground')
      end
    end

    def connector_classes(idx)
      completed = idx < @current_step
      base = @orientation == :horizontal ? 'mt-4 h-0.5 flex-1 min-w-8' : 'ml-4 w-0.5 min-h-6'
      merge_classes(base, completed ? 'bg-hw-primary' : 'bg-hw-border')
    end
  end
end
