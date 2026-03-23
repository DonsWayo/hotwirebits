# frozen_string_literal: true

module RailsBits
  class GridComponent < Base
    COLS = (1..12).index_with { |n| "grid-cols-#{n}" }.freeze
    SM_COLS = (1..12).index_with { |n| "sm:grid-cols-#{n}" }.freeze
    MD_COLS = (1..12).index_with { |n| "md:grid-cols-#{n}" }.freeze
    LG_COLS = (1..12).index_with { |n| "lg:grid-cols-#{n}" }.freeze

    def initialize(columns: 1, gap: nil, sm_cols: nil, md_cols: nil, lg_cols: nil, **attrs)
      @columns = columns
      @gap = gap
      @sm_cols = sm_cols
      @md_cols = md_cols
      @lg_cols = lg_cols
      @extra_attrs = attrs
    end

    def grid_classes
      merge_classes(
        'grid',
        COLS[@columns],
        @sm_cols && SM_COLS[@sm_cols],
        @md_cols && MD_COLS[@md_cols],
        @lg_cols && LG_COLS[@lg_cols],
        @gap && "gap-#{@gap}",
        @extra_attrs.delete(:class)
      )
    end
  end
end
