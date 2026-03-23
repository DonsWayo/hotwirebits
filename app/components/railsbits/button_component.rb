# frozen_string_literal: true

module RailsBits
  class ButtonComponent < Base
    VARIANTS = {
      default: 'bg-rb-primary text-rb-primary-foreground hover:bg-rb-primary/90',
      destructive: 'bg-rb-destructive text-rb-destructive-foreground hover:bg-rb-destructive/90',
      outline: 'border border-rb-input bg-rb-background hover:bg-rb-accent hover:text-rb-accent-foreground',
      secondary: 'bg-rb-secondary text-rb-secondary-foreground hover:bg-rb-secondary/80',
      ghost: 'hover:bg-rb-accent hover:text-rb-accent-foreground',
      link: 'text-rb-primary underline-offset-4 hover:underline',
      success: 'bg-rb-success text-rb-success-foreground hover:bg-rb-success/90',
      warning: 'bg-rb-warning text-rb-warning-foreground hover:bg-rb-warning/90',
      info: 'bg-rb-info text-rb-info-foreground hover:bg-rb-info/90'
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
        'ring-offset-rb-background transition-colors focus-visible:outline-none focus-visible:ring-2',
        'focus-visible:ring-rb-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50',
        'cursor-pointer',
        VARIANTS[@variant] || VARIANTS[:default],
        SIZES[@size] || SIZES[:md]
      )
    end
  end
end
