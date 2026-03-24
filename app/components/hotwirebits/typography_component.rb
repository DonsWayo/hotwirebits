# frozen_string_literal: true

module HotwireBits
  class TypographyComponent < Base
    STYLES = {
      h1: 'scroll-m-20 text-4xl font-extrabold tracking-tight lg:text-5xl',
      h2: 'scroll-m-20 border-b border-hw-border pb-2 text-3xl font-semibold tracking-tight first:mt-0',
      h3: 'scroll-m-20 text-2xl font-semibold tracking-tight',
      h4: 'scroll-m-20 text-xl font-semibold tracking-tight',
      h5: 'scroll-m-20 text-lg font-semibold tracking-tight',
      h6: 'scroll-m-20 text-base font-semibold tracking-tight',
      p: 'leading-7 [&:not(:first-child)]:mt-6',
      lead: 'text-xl text-hw-muted-foreground',
      large: 'text-lg font-semibold',
      small: 'text-sm font-medium leading-none',
      muted: 'text-sm text-hw-muted-foreground',
      blockquote: 'mt-6 border-l-2 border-hw-border pl-6 italic',
      code: 'relative rounded bg-hw-muted px-[0.3rem] py-[0.2rem] font-mono text-sm font-semibold',
      list: 'my-6 ml-6 list-disc [&>li]:mt-2',
      inline_code: 'relative rounded bg-hw-muted px-[0.3rem] py-[0.2rem] font-mono text-sm font-semibold',
      mark: 'bg-yellow-200 dark:bg-yellow-800 px-0.5 rounded'
    }.freeze

    TAG_MAP = {
      h1: :h1, h2: :h2, h3: :h3, h4: :h4, h5: :h5, h6: :h6,
      p: :p, lead: :p, large: :div, small: :small, muted: :p,
      blockquote: :blockquote, code: :code, list: :ul, inline_code: :code, mark: :mark
    }.freeze

    def initialize(as: nil, **attrs)
      @as = as
      @extra_attrs = attrs
    end
  end
end
