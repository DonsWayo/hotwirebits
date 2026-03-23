# frozen_string_literal: true

module HotwireBits
  class PasswordStrengthComponent < Base
    LABELS = %w[Weak Fair Good Strong].freeze
    COLORS = %w[bg-red-500 bg-orange-500 bg-yellow-500 bg-green-500].freeze

    def initialize(password: '', **attrs)
      @password = password.to_s
      @extra_attrs = attrs
    end

    def call
      level = strength_level
      tag.div(class: 'space-y-1.5', data: { controller: 'hw-password-strength' }, **@extra_attrs) do
        safe_join([
                    tag.div(class: 'flex gap-1') do
                      safe_join(4.times.map do |i|
                        tag.div(class: "h-1.5 flex-1 rounded-full transition-colors #{i <= level && level >= 0 ? COLORS[level] : 'bg-hw-muted'}")
                      end)
                    end,
                    tag.p(LABELS[level] || 'Too short',
                          class: "text-xs #{if level >= 2
                                              'text-green-600'
                                            else
                                              level >= 1 ? 'text-yellow-600' : 'text-red-600'
                                            end}")
                  ])
      end
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
