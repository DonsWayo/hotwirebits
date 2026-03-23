# frozen_string_literal: true

module HotwireBits
  class ChatBubbleComponent < Base
    renders_many :actions

    def initialize(message:, sender: nil, avatar: nil, time: nil, direction: :received, **attrs)
      @message = message
      @sender = sender
      @avatar = avatar
      @time = time
      @direction = direction
      @extra_attrs = attrs
    end

    def sent?
      @direction == :sent
    end

    def bubble_classes
      merge_classes(
        'max-w-[80%] rounded-2xl px-4 py-2.5 text-sm',
        sent? ? 'bg-hw-primary text-hw-primary-foreground rounded-br-sm' : 'bg-hw-muted text-hw-foreground rounded-bl-sm',
        @extra_attrs.delete(:class)
      )
    end

    def wrapper_classes
      merge_classes(
        'flex gap-2',
        sent? ? 'flex-row-reverse' : 'flex-row'
      )
    end
  end
end
