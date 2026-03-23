# frozen_string_literal: true

module HotwireBits
  class SpeedDialComponent < Base
    POSITIONS = {
      'bottom-right' => 'fixed bottom-6 right-6',
      'bottom-left' => 'fixed bottom-6 left-6',
      'top-right' => 'fixed top-6 right-6',
      'top-left' => 'fixed top-6 left-6'
    }.freeze

    def initialize(actions: [], direction: :up, position: 'bottom-right', **attrs)
      @actions = actions
      @direction = direction
      @position = position
      @extra_attrs = attrs
    end

    private

    def container_classes
      merge_classes('flex flex-col items-center gap-2', POSITIONS[@position])
    end

    def actions_classes
      merge_classes(
        'flex gap-2',
        @direction == :up ? 'flex-col-reverse items-center' : nil,
        @direction == :left ? 'flex-row-reverse items-center' : nil
      )
    end

    def fab_classes
      'inline-flex h-14 w-14 items-center justify-center rounded-full bg-hw-primary text-hw-primary-foreground shadow-lg hover:bg-hw-primary/90 transition-colors cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2'
    end

    def action_classes
      'inline-flex h-10 w-10 items-center justify-center rounded-full bg-hw-secondary text-hw-secondary-foreground shadow-md hover:bg-hw-secondary/80 transition-colors'
    end
  end
end
