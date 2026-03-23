# frozen_string_literal: true

module RailsBits
  class BannerComponent < Base
    TYPES = {
      info: { bg: 'bg-rb-info text-rb-info-foreground',
              icon: 'M11.25 11.25l.041-.02a.75.75 0 011.063.852l-.708 2.836a.75.75 0 001.063.853l.041-.021M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9-3.75h.008v.008H12V8.25z' },
      warning: { bg: 'bg-rb-warning text-rb-warning-foreground',
                 icon: 'M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z' },
      promotion: { bg: 'bg-rb-primary text-rb-primary-foreground',
                   icon: 'M9.813 15.904L9 18.75l-.813-2.846a4.5 4.5 0 00-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 003.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 003.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 00-3.09 3.09zM18.259 8.715L18 9.75l-.259-1.035a3.375 3.375 0 00-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 002.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 002.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 00-2.456 2.456z' }
    }.freeze

    def initialize(message:, type: :info, dismissible: false, cta: nil, **attrs)
      @message = message
      @type = type
      @dismissible = dismissible
      @cta = cta
      @extra_attrs = attrs
    end

    private

    def type_config
      TYPES[@type] || TYPES[:info]
    end

    def banner_classes
      merge_classes(
        'w-full px-4 py-3',
        type_config[:bg],
        @extra_attrs.delete(:class)
      )
    end
  end
end
