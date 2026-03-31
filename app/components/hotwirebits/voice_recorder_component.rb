# frozen_string_literal: true

module HotwireBits
  class VoiceRecorderComponent < Base
    FORMATS = %w[webm mp3 wav].freeze

    def initialize(name:, max_duration: 60, format: "webm", **attrs)
      @name = name
      @max_duration = max_duration.to_i
      @format = FORMATS.include?(format) ? format : "webm"
      @extra_attrs = attrs
    end
  end
end
