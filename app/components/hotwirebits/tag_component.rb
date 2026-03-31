# frozen_string_literal: true

module HotwireBits
  class TagComponent < Base
    COLORS = {
      default: 'bg-hw-muted text-hw-muted-foreground',
      red: 'bg-hw-destructive/10 text-hw-destructive dark:bg-hw-destructive/20 dark:text-hw-destructive-foreground',
      orange: 'bg-hw-warning/10 text-hw-warning dark:bg-hw-warning/20 dark:text-hw-warning-foreground',
      yellow: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-hw-warning',
      green: 'bg-hw-success/10 text-hw-success dark:bg-hw-success/20 dark:text-hw-success-foreground',
      blue: 'bg-hw-info/10 text-hw-info dark:bg-hw-info/20 dark:text-hw-info-foreground',
      purple: 'bg-hw-primary/10 text-hw-primary dark:bg-hw-primary/20 dark:text-hw-primary-foreground',
      pink: 'bg-pink-100 text-pink-700 dark:bg-pink-900/30 dark:text-pink-400'
    }.freeze

    def initialize(label: nil, color: :default, pill: false, removable: false, **attrs)
      @label = label
      @color = color
      @pill = pill
      @removable = removable
      @extra_attrs = attrs
    end

    private

    def tag_classes
      radius = @pill ? 'rounded-full' : 'rounded'
      merge_classes(
        'inline-flex items-center px-2 py-0.5 text-xs font-medium',
        radius,
        COLORS[@color] || COLORS[:default]
      )
    end
  end
end
