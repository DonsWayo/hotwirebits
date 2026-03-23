# frozen_string_literal: true

module HotwireBits
  class SheetComponent < Base
    renders_one :header
    renders_one :footer

    SIDES = {
      right: {
        overlay: '',
        panel: 'inset-y-0 right-0 h-full w-3/4 border-l data-[state=closed]:slide-out-to-right data-[state=open]:slide-in-from-right sm:max-w-sm'
      },
      left: {
        overlay: '',
        panel: 'inset-y-0 left-0 h-full w-3/4 border-r data-[state=closed]:slide-out-to-left data-[state=open]:slide-in-from-left sm:max-w-sm'
      },
      top: {
        overlay: '',
        panel: 'inset-x-0 top-0 h-auto border-b data-[state=closed]:slide-out-to-top data-[state=open]:slide-in-from-top'
      },
      bottom: {
        overlay: '',
        panel: 'inset-x-0 bottom-0 h-auto border-t data-[state=closed]:slide-out-to-bottom data-[state=open]:slide-in-from-bottom'
      }
    }.freeze

    SIZES = { sm: '', md: '', lg: '', xl: '' }.freeze

    def initialize(side: :right, size: :md, open: false, title: nil, closable: true, **attrs)
      @side = side
      @size = size
      @open = open
      @title = title
      @closable = closable
      @extra_attrs = attrs
    end

    private

    def side_config
      SIDES[@side] || SIDES[:right]
    end
  end
end
