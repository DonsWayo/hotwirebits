# frozen_string_literal: true

module HotwireBits
  class InputGroupComponent < Base
    def initialize(addon_before: nil, addon_after: nil, disabled: false, **attrs)
      @addon_before = addon_before
      @addon_after = addon_after
      @disabled = disabled
      @extra_attrs = attrs
    end

    def call
      tag.div(class: group_classes, **@extra_attrs) do
        safe_join([
          (addon_element(:before) if @addon_before),
          content,
          (addon_element(:after) if @addon_after)
        ].compact)
      end
    end

    private

    def group_classes
      merge_classes(
        'flex [&>*:first-child]:rounded-r-none [&>*:last-child]:rounded-l-none [&>*:not(:first-child):not(:last-child)]:rounded-none',
        '[&>*:not(:first-child)]:-ml-px'
      )
    end

    def addon_element(position)
      tag.span(class: addon_classes(position)) do
        if @addon_before.is_a?(String) && position == :before
          @addon_before
        else
          (@addon_after.is_a?(String) && position == :after ? @addon_after : nil)
        end
      end
    end

    def addon_classes(_position)
      merge_classes(
        'inline-flex items-center rounded-md border border-hw-input bg-hw-muted px-3 text-sm text-hw-muted-foreground',
        'whitespace-nowrap'
      )
    end
  end
end
