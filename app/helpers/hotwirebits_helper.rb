# frozen_string_literal: true

module HotwirebitsHelper
  SAFE_SVG_TAG = /\A\s*<svg[\s>]/i
  SAFE_ATTRIBUTES = /\s+(class|id|xmlns|viewBox|fill|stroke|stroke-width|stroke-linecap|stroke-linejoin|d|path|width|height|x|y|cx|cy|r|rx|ry|points|transform|style|opacity|data-|aria-|role)=/i

  def hw_merge_classes(*classes)
    classes.flatten.compact.reject { |c| c.to_s.strip.empty? }.join(" ")
  end

  def safe_svg(html)
    return "".html_safe if html.blank?
    return html.html_safe if html.html_safe? || html.match?(SAFE_SVG_TAG)

    ERB::Util.html_escape(html)
  end

  # === BUTTON ===
  BUTTON_VARIANTS = {
    default: "bg-hw-primary text-hw-primary-foreground hover:bg-hw-primary/90",
    destructive: "bg-hw-destructive text-hw-destructive-foreground hover:bg-hw-destructive/90",
    outline: "border border-hw-input bg-hw-background hover:bg-hw-accent hover:text-hw-accent-foreground",
    secondary: "bg-hw-secondary text-hw-secondary-foreground hover:bg-hw-secondary/80",
    ghost: "hover:bg-hw-accent hover:text-hw-accent-foreground",
    link: "text-hw-primary underline-offset-4 hover:underline",
    success: "bg-hw-success text-hw-success-foreground hover:bg-hw-success/90",
    warning: "bg-hw-warning text-hw-warning-foreground hover:bg-hw-warning/90",
    info: "bg-hw-info text-hw-info-foreground hover:bg-hw-info/90"
  }.freeze

  BUTTON_SIZES = {
    xs: "h-7 rounded-md px-2 text-xs",
    sm: "h-8 rounded-md px-3 text-sm",
    md: "h-9 rounded-md px-4 text-sm",
    lg: "h-10 rounded-md px-8",
    xl: "h-11 rounded-md px-10 text-base",
    icon: "h-9 w-9"
  }.freeze

  def hw_button_classes(variant: :default, size: :md, disabled: false)
    hw_merge_classes(
      "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium",
      "ring-offset-hw-background transition-colors focus-visible:outline-none focus-visible:ring-2",
      "focus-visible:ring-hw-ring focus-visible:ring-offset-2 cursor-pointer",
      disabled && "disabled:pointer-events-none disabled:opacity-50",
      BUTTON_VARIANTS[variant] || BUTTON_VARIANTS[:default],
      BUTTON_SIZES[size] || BUTTON_SIZES[:md]
    )
  end

  # === BADGE ===
  BADGE_VARIANTS = {
    default: "border-transparent bg-hw-primary text-hw-primary-foreground",
    secondary: "border-transparent bg-hw-secondary text-hw-secondary-foreground",
    destructive: "border-transparent bg-hw-destructive text-hw-destructive-foreground",
    outline: "text-hw-foreground",
    success: "border-transparent bg-hw-success text-hw-success-foreground",
    warning: "border-transparent bg-hw-warning text-hw-warning-foreground",
    info: "border-transparent bg-hw-info text-hw-info-foreground"
  }.freeze

  BADGE_SIZES = {
    sm: "px-1.5 py-0 text-[10px]",
    md: "px-2.5 py-0.5 text-xs",
    lg: "px-3 py-1 text-sm"
  }.freeze

  def hw_badge_classes(variant: :default, size: :md)
    hw_merge_classes(
      "inline-flex items-center rounded-full border font-semibold transition-colors",
      BADGE_VARIANTS[variant] || BADGE_VARIANTS[:default],
      BADGE_SIZES[size] || BADGE_SIZES[:md]
    )
  end

  # === AVATAR ===
  AVATAR_SIZES = {
    xs: "h-6 w-6 text-[10px]",
    sm: "h-8 w-8 text-xs",
    md: "h-10 w-10 text-sm",
    lg: "h-12 w-12 text-base",
    xl: "h-16 w-16 text-lg"
  }.freeze

  AVATAR_STATUS = {
    online: "bg-hw-success",
    offline: "bg-hw-muted-foreground/60",
    busy: "bg-hw-destructive",
    away: "bg-hw-warning"
  }.freeze

  # === INPUT ===
  INPUT_SIZES = {
    sm: "h-8 px-3 text-xs",
    md: "h-9 px-3 text-sm",
    lg: "h-10 px-4 text-base"
  }.freeze

  def hw_input_classes(size: :md, error: false, disabled: false)
    hw_merge_classes(
      "flex w-full rounded-md border bg-hw-background text-hw-foreground ring-offset-hw-background",
      "placeholder:text-hw-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2",
      disabled && "disabled:cursor-not-allowed disabled:opacity-50",
      error ? "border-hw-destructive focus-visible:ring-hw-destructive" : "border-hw-input focus-visible:ring-hw-ring",
      INPUT_SIZES[size] || INPUT_SIZES[:md]
    )
  end

  # === CHECKBOX ===
  CHECKBOX_SIZES = {
    sm: "h-3.5 w-3.5",
    md: "h-4 w-4",
    lg: "h-5 w-5"
  }.freeze

  def hw_checkbox_classes(size: :md, error: false)
    hw_merge_classes(
      "peer shrink-0 rounded-sm border bg-hw-background ring-offset-hw-background",
      "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2",
      "disabled:cursor-not-allowed disabled:opacity-50",
      "checked:bg-hw-primary checked:border-hw-primary",
      error ? "border-hw-destructive" : "border-hw-input",
      CHECKBOX_SIZES[size] || CHECKBOX_SIZES[:md]
    )
  end

  # === SELECT ===
  SELECT_SIZES = {
    sm: "h-8 px-3 text-xs",
    md: "h-9 px-3 text-sm",
    lg: "h-10 px-4 text-base"
  }.freeze

  def hw_select_classes(size: :md, error: false)
    hw_merge_classes(
      "flex w-full rounded-md border bg-hw-background text-hw-foreground ring-offset-hw-background",
      "placeholder:text-hw-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2",
      "appearance-none pr-8",
      error ? "border-hw-destructive focus-visible:ring-hw-destructive" : "border-hw-input focus-visible:ring-hw-ring",
      SELECT_SIZES[size] || SELECT_SIZES[:md]
    )
  end

  # === TEXTAREA ===
  def hw_textarea_classes(error: false, resize: true)
    hw_merge_classes(
      "flex min-h-[60px] w-full rounded-md border bg-hw-background px-3 py-2 text-sm text-hw-foreground",
      "ring-offset-hw-background placeholder:text-hw-muted-foreground",
      "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2",
      "disabled:cursor-not-allowed disabled:opacity-50",
      !resize && "resize-none",
      error ? "border-hw-destructive focus-visible:ring-hw-destructive" : "border-hw-input focus-visible:ring-hw-ring"
    )
  end

  # === SPINNER ===
  SPINNER_SIZES = {
    xs: "h-3 w-3",
    sm: "h-4 w-4",
    md: "h-6 w-6",
    lg: "h-8 w-8",
    xl: "h-12 w-12"
  }.freeze

  # === CARD ===
  def hw_card_classes
    "rounded-lg border border-hw-border bg-hw-card text-hw-card-foreground shadow-sm"
  end

  # === ALERT ===
  ALERT_TYPES = {
    info: "border-hw-info/50 text-hw-info bg-hw-info/10",
    success: "border-hw-success/50 text-hw-success bg-hw-success/10",
    warning: "border-hw-warning/50 text-hw-warning bg-hw-warning/10",
    error: "border-hw-destructive/50 text-hw-destructive bg-hw-destructive/10"
  }.freeze

  def hw_alert_classes(type: :info)
    hw_merge_classes(
      "relative w-full rounded-lg border p-4",
      ALERT_TYPES[type] || ALERT_TYPES[:info]
    )
  end

  # === PROGRESS ===
  PROGRESS_COLORS = {
    default: "bg-hw-primary",
    success: "bg-hw-success",
    warning: "bg-hw-warning",
    destructive: "bg-hw-destructive"
  }.freeze

  # === SKELETON ===
  def hw_skeleton_classes(shape: :rectangle)
    base = "animate-pulse bg-hw-muted"
    case shape
    when :circle then "#{base} rounded-full"
    when :text then "#{base} rounded h-4 w-full"
    else "#{base} rounded-md"
    end
  end

  # === TABS ===
  def hw_tab_classes(active: false)
    hw_merge_classes(
      "inline-flex items-center justify-center whitespace-nowrap rounded-sm px-3 py-1.5 text-sm font-medium",
      "ring-offset-hw-background transition-all focus-visible:outline-none focus-visible:ring-2",
      "focus-visible:ring-hw-ring focus-visible:ring-offset-2 cursor-pointer",
      active ? "bg-hw-background text-hw-foreground shadow-sm" : "text-hw-muted-foreground hover:text-hw-foreground"
    )
  end

  # === TOGGLE ===
  def hw_toggle_classes(pressed: false)
    hw_merge_classes(
      "inline-flex items-center justify-center rounded-md font-medium ring-offset-hw-background",
      "transition-colors focus-visible:outline-none focus-visible:ring-2",
      "focus-visible:ring-hw-ring focus-visible:ring-offset-2 cursor-pointer",
      "hover:bg-hw-accent hover:text-hw-accent-foreground",
      pressed ? "bg-hw-accent text-hw-accent-foreground" : "bg-transparent"
    )
  end

  # === TOOLTIP ===
  def hw_tooltip_classes
    "z-50 overflow-hidden rounded-md border border-hw-border bg-hw-bg px-3 py-1.5 text-sm text-hw-fg shadow-md"
  end

  # === SEPARATOR ===
  def hw_separator_classes(orientation: :horizontal)
    if orientation == :vertical
      "shrink-0 bg-hw-border h-full w-[1px]"
    else
      "shrink-0 bg-hw-border h-[1px] w-full"
    end
  end

  # === DIALOG ===
  def hw_dialog_classes(size: :md)
    sizes = {sm: "max-w-sm", md: "max-w-lg", lg: "max-w-2xl", xl: "max-w-4xl", full: "max-w-[calc(100vw-2rem)]"}
    hw_merge_classes(
      "relative w-full rounded-lg border border-hw-border bg-hw-bg p-6 shadow-lg",
      sizes[size] || sizes[:md]
    )
  end

  # === DROPDOWN ===
  def hw_dropdown_classes
    "z-50 min-w-[8rem] overflow-hidden rounded-md border border-hw-border bg-hw-bg p-1 shadow-md"
  end

  # === PAGINATION ===
  def hw_pagination_item_classes(active: false)
    hw_merge_classes(
      "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium",
      "ring-offset-hw-background transition-colors cursor-pointer",
      "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2",
      active ? "bg-hw-primary text-hw-primary-foreground" : "border border-hw-input bg-hw-background hover:bg-hw-accent"
    )
  end

  # === TOAST ===
  TOAST_TYPES = {
    success: "border-hw-success bg-hw-success/10",
    error: "border-hw-destructive bg-hw-destructive/10",
    warning: "border-hw-warning bg-hw-warning/10",
    info: "border-hw-info bg-hw-info/10"
  }.freeze

  def hw_toast_classes(type: :info)
    hw_merge_classes(
      "pointer-events-auto relative flex w-full items-center justify-between space-x-4 overflow-hidden rounded-md border p-4 shadow-lg",
      TOAST_TYPES[type] || TOAST_TYPES[:info]
    )
  end

  # === RATING ===
  RATING_SIZES = {sm: "h-4 w-4", md: "h-5 w-5", lg: "h-6 w-6", xl: "h-8 w-8"}.freeze

  # === SLIDER ===
  def hw_slider_classes
    "w-full h-2 bg-hw-input rounded-lg appearance-none cursor-pointer accent-hw-primary"
  end

  # === FORM GROUP ===
  def hw_form_group_classes(horizontal: false)
    horizontal ? "grid grid-cols-4 items-start gap-4" : "space-y-2"
  end

  # === CHIP ===
  def hw_chip_classes(size: :md)
    sizes = {sm: "h-6 text-xs px-2 gap-1", md: "h-8 text-sm px-2.5 gap-1.5", lg: "h-10 text-sm px-3 gap-2"}
    hw_merge_classes(
      "inline-flex items-center rounded-full border border-hw-border bg-hw-background text-hw-foreground font-medium",
      sizes[size] || sizes[:md]
    )
  end

  # === TAG ===
  TAG_COLORS = {
    default: "bg-hw-muted text-hw-muted-foreground",
    red: "bg-hw-destructive/10 text-hw-destructive dark:bg-hw-destructive/20 dark:text-hw-destructive-foreground",
    orange: "bg-hw-warning/10 text-hw-warning dark:bg-hw-warning/20 dark:text-hw-warning-foreground",
    green: "bg-hw-success/10 text-hw-success dark:bg-hw-success/20 dark:text-hw-success-foreground",
    blue: "bg-hw-info/10 text-hw-info dark:bg-hw-info/20 dark:text-hw-info-foreground",
    purple: "bg-hw-primary/10 text-hw-primary dark:bg-hw-primary/20 dark:text-hw-primary-foreground"
  }.freeze

  # === INDICATOR ===
  INDICATOR_POSITIONS = {
    top_left: "-top-1 -left-1",
    top_right: "-top-1 -right-1",
    bottom_left: "-bottom-1 -left-1",
    bottom_right: "-bottom-1 -right-1"
  }.freeze

  # === STATUS ===
  STATUS_COLORS = AVATAR_STATUS

  # === KBD ===
  KBD_SIZES = {sm: "px-1 py-0.5 text-[10px]", md: "px-1.5 py-0.5 text-xs", lg: "px-2 py-1 text-sm"}.freeze

  # === ACCORDION ===
  ACCORDION_VARIANTS = {
    default: "",
    bordered: "border border-hw-border rounded-lg overflow-hidden",
    card: "border border-hw-border rounded-lg bg-hw-card overflow-hidden"
  }.freeze

  # === HERO ===
  def hw_hero_classes(variant: :centered)
    case variant
    when :split then "grid grid-cols-1 lg:grid-cols-2 gap-8 items-center"
    when :with_image then "flex flex-col items-center text-center gap-6"
    else "flex flex-col items-center text-center gap-4"
    end
  end

  # === PRICING ===
  def hw_pricing_card_classes(highlighted: false)
    hw_merge_classes(
      "rounded-lg border p-6 flex flex-col",
      highlighted ? "border-hw-primary bg-hw-primary/5 shadow-lg scale-105" : "border-hw-border bg-hw-card"
    )
  end

  # === FILE INPUT ===
  def hw_file_input_classes
    "flex h-9 items-center justify-center rounded-md border border-dashed border-hw-input bg-hw-background px-3 text-sm text-hw-muted-foreground hover:bg-hw-accent cursor-pointer"
  end

  # === CONTAINER ===
  CONTAINER_SIZES = {
    sm: "max-w-screen-sm",
    md: "max-w-screen-md",
    lg: "max-w-screen-lg",
    xl: "max-w-screen-xl",
    "2xl": "max-w-screen-2xl",
    full: "max-w-full"
  }.freeze

  # === GRID ===
  GRID_COLS = {
    1 => "grid-cols-1", 2 => "grid-cols-2", 3 => "grid-cols-3",
    4 => "grid-cols-4", 5 => "grid-cols-5", 6 => "grid-cols-6",
    12 => "grid-cols-12"
  }.freeze

  # === FLEX ===
  FLEX_DIRECTIONS = {row: "flex-row", column: "flex-col", "row-reverse": "flex-row-reverse",
                     "column-reverse": "flex-col-reverse"}.freeze

  # === STACK ===
  def hw_stack_classes(gap: 4, align: nil)
    hw_merge_classes(
      "flex flex-col",
      "gap-#{gap}",
      align && "items-#{align}"
    )
  end

  # === GROUP ===
  def hw_group_classes(gap: 2, wrap: true)
    hw_merge_classes("flex items-center", "gap-#{gap}", wrap && "flex-wrap")
  end

  # === ASPECT RATIO ===
  ASPECT_RATIOS = {"16_9": "aspect-video", "4_3": "aspect-[4/3]", "1_1": "aspect-square",
                   "21_9": "aspect-[21/9]"}.freeze

  # === SCROLL AREA ===
  def hw_scroll_area_classes(height: "200px")
    "overflow-auto scrollbar-thin scrollbar-thumb-hw-border"
  end

  # ============================================================================
  # STANDALONE PARTIAL COMPATIBILITY
  # These aliases and methods make standalone ERB partials work without
  # ViewComponent instance methods.
  # ============================================================================

  # Core utility alias
  alias_method :merge_classes, :hw_merge_classes

  # CSS class method aliases (without hw_ prefix)
  alias_method :button_classes, :hw_button_classes
  alias_method :badge_classes, :hw_badge_classes
  alias_method :input_classes, :hw_input_classes
  alias_method :checkbox_classes, :hw_checkbox_classes
  alias_method :select_classes, :hw_select_classes
  alias_method :textarea_classes, :hw_textarea_classes
  alias_method :card_classes, :hw_card_classes
  alias_method :alert_classes, :hw_alert_classes
  alias_method :skeleton_classes, :hw_skeleton_classes
  alias_method :tab_classes, :hw_tab_classes
  alias_method :toggle_classes, :hw_toggle_classes
  alias_method :tooltip_classes, :hw_tooltip_classes
  alias_method :separator_classes, :hw_separator_classes
  alias_method :dialog_classes, :hw_dialog_classes
  alias_method :dropdown_classes, :hw_dropdown_classes
  alias_method :pagination_item_classes, :hw_pagination_item_classes
  alias_method :toast_classes, :hw_toast_classes
  alias_method :slider_classes, :hw_slider_classes
  alias_method :form_group_classes, :hw_form_group_classes
  alias_method :chip_classes, :hw_chip_classes
  alias_method :hero_classes, :hw_hero_classes
  alias_method :pricing_card_classes, :hw_pricing_card_classes
  alias_method :file_input_classes, :hw_file_input_classes
  alias_method :stack_classes, :hw_stack_classes
  alias_method :group_classes, :hw_group_classes
  alias_method :scroll_area_classes, :hw_scroll_area_classes

  # --- Missing CSS class methods called by partials ---

  def container_classes(size: :md)
    hw_merge_classes("mx-auto w-full px-4", CONTAINER_SIZES[size] || CONTAINER_SIZES[:md])
  end

  def overlay_classes
    "fixed inset-0 z-50 bg-black/80 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0"
  end

  def panel_classes(index = nil)
    "rounded-lg border border-hw-border bg-hw-card overflow-hidden"
  end

  def nav_classes
    "flex items-center justify-between w-full"
  end

  def tag_classes(color: :default)
    hw_merge_classes(
      "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold",
      TAG_COLORS[color] || TAG_COLORS[:default]
    )
  end

  def wrapper_classes
    "relative"
  end

  def icon_classes
    "h-4 w-4"
  end

  def label_classes
    "text-sm font-medium leading-none"
  end

  def list_classes
    "list-none p-0 m-0 space-y-1"
  end

  def link_classes
    "text-hw-primary underline-offset-4 hover:underline"
  end

  def section_classes
    "py-12"
  end

  def box_classes
    "rounded-lg border border-hw-border bg-hw-card p-4"
  end

  def center_classes
    "flex items-center justify-center"
  end

  def flex_classes(direction: :row, gap: nil)
    hw_merge_classes("flex", FLEX_DIRECTIONS[direction] || "flex-row", gap && "gap-#{gap}")
  end

  def grid_classes(columns: 3, gap: 4)
    hw_merge_classes("grid", GRID_COLS[columns] || "grid-cols-#{columns}", "gap-#{gap}")
  end

  def space_classes(size: 4)
    "space-y-#{size}"
  end

  def fluid_classes
    "w-full"
  end

  def divider_classes(orientation: :horizontal)
    hw_separator_classes(orientation: orientation)
  end

  def join_classes
    "inline-flex"
  end

  def mask_classes
    "overflow-hidden"
  end

  def scroll_classes
    "overflow-auto"
  end

  def mark_classes
    "bg-yellow-200 dark:bg-yellow-800 px-0.5 rounded"
  end

  def kbd_classes(size: :md)
    hw_merge_classes(
      "inline-flex items-center rounded border border-hw-border bg-hw-muted font-mono font-medium text-hw-muted-foreground",
      KBD_SIZES[size] || KBD_SIZES[:md]
    )
  end

  def sidebar_classes
    "flex flex-col h-full border-r border-hw-border bg-hw-background"
  end

  def menu_classes
    "flex flex-col gap-0.5"
  end

  def trigger_classes
    "inline-flex items-center justify-center"
  end

  def bar_classes
    "h-2 bg-hw-primary rounded-full transition-transform origin-left"
  end

  def dot_classes(active: false)
    hw_merge_classes("h-2 w-2 rounded-full transition-colors", active ? "bg-hw-primary" : "bg-hw-muted-foreground/40")
  end

  def header_classes
    "flex items-center justify-between"
  end

  def inner_classes
    ""
  end

  def figure_classes
    "overflow-hidden rounded-lg"
  end

  def frame_classes
    "rounded-lg border border-hw-border overflow-hidden"
  end

  def option_classes
    "relative flex cursor-pointer select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none hover:bg-hw-accent hover:text-hw-accent-foreground"
  end

  def popup_classes
    "z-50 rounded-md border border-hw-border bg-hw-popover shadow-md"
  end

  def position_classes
    "relative"
  end

  def bubble_classes
    "rounded-lg bg-hw-card p-4 shadow-sm"
  end

  def effect_classes
    ""
  end

  def track_classes
    "h-2 bg-hw-input rounded-full"
  end

  def connector_classes
    "flex-1 h-px bg-hw-border"
  end

  def step_circle_classes(active: false, completed: false)
    hw_merge_classes(
      "flex h-8 w-8 items-center justify-center rounded-full border-2 text-sm font-medium",
      completed ? "border-hw-primary bg-hw-primary text-hw-primary-foreground" : "",
      active ? "border-hw-primary text-hw-primary" : "border-hw-border text-hw-muted-foreground"
    )
  end

  def notification_classes
    "rounded-lg border border-hw-border bg-hw-card p-4 shadow-lg"
  end

  def fieldset_classes
    "space-y-4 rounded-lg border border-hw-border p-4"
  end

  def action_classes
    "inline-flex items-center justify-center"
  end

  def actions_classes
    "flex flex-col gap-2"
  end

  def fab_classes
    "inline-flex h-14 w-14 items-center justify-center rounded-full bg-hw-primary text-hw-primary-foreground shadow-lg"
  end

  def speed_dial_classes
    "fixed bottom-6 right-6 z-50"
  end

  def confirm_classes
    hw_button_classes(variant: :primary)
  end

  def cancel_classes
    hw_button_classes(variant: :outline)
  end

  def confirm_button_classes
    hw_button_classes(variant: :primary)
  end

  def input_number_classes
    hw_input_classes
  end

  # --- Type/config methods for feedback components ---

  ALERT_CONFIG = {
    info: {icon: "M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"},
    success: {icon: "M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"},
    warning: {icon: "M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"},
    error: {icon: "M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"}
  }.freeze

  def type_config(type = :info)
    ALERT_CONFIG[type] || ALERT_CONFIG[:info]
  end

  BANNER_CONFIG = {
    info: {icon: "M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"},
    success: {icon: "M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"},
    warning: {icon: "M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"},
    error: {icon: "M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"}
  }.freeze

  def banner_classes(type: :info)
    hw_merge_classes(
      "relative w-full rounded-lg border p-4",
      ALERT_TYPES[type] || ALERT_TYPES[:info]
    )
  end

  def banner_config(type = :info)
    BANNER_CONFIG[type] || BANNER_CONFIG[:info]
  end

  def ratio_classes(ratio: "16/9")
    case ratio
    when "16/9" then "aspect-video"
    when "4/3" then "aspect-[4/3]"
    when "1/1" then "aspect-square"
    else "aspect-[#{ratio}]"
    end
  end

  def container_styles
    ""
  end

  # --- ViewComponent slot compatibility (safe stubs) ---

  def header?
    false
  end

  def header
    nil
  end

  def footer?
    false
  end

  def footer
    nil
  end

  def slides?
    false
  end

  def confirm_action?
    false
  end

  def confirm_action
    nil
  end

  def cancel_action?
    false
  end

  def cancel_action
    nil
  end

  def all_slides
    []
  end

  # --- Constants referenced by partials ---

  INPUT_NUMBER_BUTTON_SIZES = {
    sm: "h-7 w-7",
    md: "h-9 w-9",
    lg: "h-10 w-10"
  }.freeze
end
