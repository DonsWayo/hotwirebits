# frozen_string_literal: true

module HotwireBits
  class TagComponent < Base
    COLORS = {
      default: 'bg-hw-muted text-hw-muted-foreground',
      red: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400',
      orange: 'bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-400',
      yellow: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400',
      green: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400',
      blue: 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400',
      purple: 'bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-400',
      pink: 'bg-pink-100 text-pink-700 dark:bg-pink-900/30 dark:text-pink-400'
    }.freeze

    def initialize(label: nil, color: :default, pill: false, removable: false, **attrs)
      @label = label
      @color = color
      @pill = pill
      @removable = removable
      @extra_attrs = attrs
    end

    def call
      content_or_label = content || @label
      tag.span(class: tag_classes, **@extra_attrs) do
        safe_join([content_or_label].compact)
      end
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
