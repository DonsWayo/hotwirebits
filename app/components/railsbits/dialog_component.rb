# frozen_string_literal: true

module RailsBits
  class DialogComponent < Base
    renders_one :header
    renders_one :footer

    SIZES = {
      sm: 'max-w-sm',
      md: 'max-w-lg',
      lg: 'max-w-2xl',
      xl: 'max-w-4xl',
      full: 'max-w-[calc(100vw-2rem)] max-h-[calc(100vh-2rem)]'
    }.freeze

    def initialize(title: nil, size: :md, open: false, closable: true, **attrs)
      @title = title
      @size = size
      @open = open
      @closable = closable
      @extra_attrs = attrs
    end

    private

    def overlay_classes
      merge_classes(
        'fixed inset-0 z-50 bg-black/80',
        'data-[state=open]:animate-in data-[state=closed]:animate-out',
        'data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0'
      )
    end

    def dialog_classes
      merge_classes(
        'fixed left-1/2 top-1/2 z-50 grid w-full -translate-x-1/2 -translate-y-1/2',
        'gap-4 border border-rb-border bg-rb-background p-6 shadow-lg duration-200',
        'data-[state=open]:animate-in data-[state=closed]:animate-out',
        'data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0',
        'data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95',
        'data-[state=closed]:slide-out-to-left-1/2 data-[state=closed]:slide-out-to-top-[48%]',
        'data-[state=open]:slide-in-from-left-1/2 data-[state=open]:slide-in-from-top-[48%]',
        'rounded-lg',
        SIZES[@size] || SIZES[:md],
        @extra_attrs.delete(:class)
      )
    end
  end
end
