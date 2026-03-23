# frozen_string_literal: true

module HotwireBits
  class ButtonComponent < Base
    VARIANTS = {
      default: 'bg-hw-primary text-hw-primary-foreground hover:bg-hw-primary/90',
      destructive: 'bg-hw-destructive text-hw-destructive-foreground hover:bg-hw-destructive/90',
      outline: 'border border-hw-input bg-hw-background hover:bg-hw-accent hover:text-hw-accent-foreground',
      secondary: 'bg-hw-secondary text-hw-secondary-foreground hover:bg-hw-secondary/80',
      ghost: 'hover:bg-hw-accent hover:text-hw-accent-foreground',
      link: 'text-hw-primary underline-offset-4 hover:underline',
      success: 'bg-hw-success text-hw-success-foreground hover:bg-hw-success/90',
      warning: 'bg-hw-warning text-hw-warning-foreground hover:bg-hw-warning/90',
      info: 'bg-hw-info text-hw-info-foreground hover:bg-hw-info/90'
    }.freeze

    SIZES = {
      xs: 'h-7 rounded-md px-2 text-xs',
      sm: 'h-8 rounded-md px-3 text-sm',
      md: 'h-9 rounded-md px-4 text-sm',
      lg: 'h-10 rounded-md px-8',
      xl: 'h-11 rounded-md px-10 text-base',
      icon: 'h-9 w-9'
    }.freeze

    def initialize(
      label: nil,
      variant: :default,
      size: :md,
      disabled: false,
      loading: false,
      href: nil,
      method: nil,
      type: nil,
      form: nil,
      formaction: nil,
      target: nil,
      **attrs
    )
      @label = label
      @variant = variant
      @size = size
      @disabled = disabled
      @loading = loading
      @href = href
      @method = method
      @type = type || (href ? nil : 'button')
      @form = form
      @formaction = formaction
      @target = target
      @extra_attrs = attrs
    end

    def call
      tag = @href ? :a : :button
      content_or_label = content || @label

      tag.public_send(
        tag,
        content_or_label,
        **button_attrs
      )
    end

    private

    def button_attrs
      attrs = {
        class: button_classes,
        disabled: @disabled || @loading,
        aria: { disabled: @disabled || @loading || nil }
      }
      attrs[:href] = @href if @href
      attrs[:data] = { turbo_method: @method } if @method
      attrs[:type] = @type if @type
      attrs[:form] = @form if @form
      attrs[:formaction] = @formaction if @formaction
      attrs[:target] = @target if @target
      attrs[:data] ||= {}
      attrs[:data][:rb_button_target] = 'button' if @loading
      attrs.merge(@extra_attrs)
    end

    def button_classes
      merge_classes(
        'inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium',
        'ring-offset-hw-background transition-colors focus-visible:outline-none focus-visible:ring-2',
        'focus-visible:ring-hw-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50',
        'cursor-pointer',
        VARIANTS[@variant] || VARIANTS[:default],
        SIZES[@size] || SIZES[:md]
      )
    end
  end
end
