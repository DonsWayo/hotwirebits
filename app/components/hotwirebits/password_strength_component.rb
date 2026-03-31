# frozen_string_literal: true

module HotwireBits
  class PasswordStrengthComponent < Base
    LABELS = %w[Weak Fair Good Strong].freeze
    COLORS = %w[bg-hw-destructive bg-hw-warning bg-hw-warning bg-hw-success].freeze

    def initialize(password: '', **attrs)
      @password = password.to_s
      @extra_attrs = attrs
    end

    private

    def strength_level
      score = 0
      score += 1 if @password.length >= 8
      score += 1 if @password =~ /[a-z]/ && @password =~ /[A-Z]/
      score += 1 if @password =~ /\d/
      score += 1 if @password =~ /[^a-zA-Z0-9]/
      [score - 1, 0].max
    end
  end
end
