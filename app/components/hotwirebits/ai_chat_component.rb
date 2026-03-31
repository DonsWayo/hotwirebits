# frozen_string_literal: true

module HotwireBits
  class AiChatComponent < Base
    def initialize(messages: [], placeholder: "Type a message...", send_label: "Send", **attrs)
      @messages = messages
      @placeholder = placeholder
      @send_label = send_label
      @extra_attrs = attrs
    end
  end
end
