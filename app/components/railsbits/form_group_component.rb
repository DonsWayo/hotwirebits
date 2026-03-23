# frozen_string_literal: true

module RailsBits
  class FormGroupComponent < Base
    def initialize(label: nil, hint: nil, error: nil, required: false, name: nil, horizontal: false, **attrs)
      @label = label
      @hint = hint
      @error = error
      @required = required
      @name = name
      @horizontal = horizontal
      @extra_attrs = attrs
    end

    def call
      if @horizontal
        tag.div(class: 'grid grid-cols-4 items-start gap-4', **@extra_attrs) do
          safe_join([
                      tag.div(class: 'pt-2') do
                        safe_join([
                          (tag.label(for: @name, class: 'text-sm font-medium text-rb-foreground') { @label } if @label),
                          (tag.span(' *', class: 'text-rb-destructive') if @required),
                          (tag.p(@hint, class: 'text-xs text-rb-muted-foreground mt-0.5') if @hint)
                        ].compact)
                      end,
                      tag.div(class: 'col-span-3') do
                        safe_join([
                          content,
                          (tag.p(@error, class: 'text-xs text-rb-destructive mt-1') if @error)
                        ].compact)
                      end
                    ])
        end
      else
        tag.div(class: 'space-y-2', **@extra_attrs) do
          safe_join([
            (if @label
               tag.label(for: @name,
                         class: 'text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70') do
                 safe_join([@label, (@required ? tag.span(' *', class: 'text-rb-destructive') : nil)].compact)
               end
             end),
            content,
            (tag.p(@hint, class: 'text-xs text-rb-muted-foreground') if @hint && !@error),
            (tag.p(@error, class: 'text-xs text-rb-destructive') if @error)
          ].compact)
        end
      end
    end
  end
end
