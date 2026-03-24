# frozen_string_literal: true

module HotwireBits
  class TwoFactorComponent < Base
    def initialize(name: nil, length: 6, auto_submit: false, with_timer: false, resend_url: nil, **attrs)
      @name = name
      @length = length
      @auto_submit = auto_submit
      @with_timer = with_timer
      @resend_url = resend_url
      @extra_attrs = attrs
    end
  end
end
