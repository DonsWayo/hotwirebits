# frozen_string_literal: true

module RailsBits
  class FeedbackComponent < Base
    TYPES = %i[thumbs stars emoji nps].freeze

    def initialize(type: :thumbs, question: nil, **attrs)
      @type = type
      @question = question
      @extra_attrs = attrs
    end

    private

    def emoji_options
      %w[😡 😟 😐 🙂 😄]
    end

    def nps_range
      (0..10).to_a
    end
  end
end
