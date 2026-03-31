# frozen_string_literal: true

module HotwirebitsHelper
  def hw_merge_classes(*classes)
    classes.flatten.compact.join(" ")
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
    online: "bg-green-500",
    offline: "bg-gray-400",
    busy: "bg-red-500",
    away: "bg-yellow-500"
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

  # === RADIO ===
  RADIO_SIZES = {
    sm: "h-3.5 w-3.5",
    md: "h-4 w-4",
    lg: "h-5 w-5"
  }.freeze

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
    red: "bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400",
    orange: "bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-400",
    green: "bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400",
    blue: "bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400",
    purple: "bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-400"
  }.freeze

  # === INDICATOR ===
  INDICATOR_POSITIONS = {
    top_left: "-top-1 -left-1",
    top_right: "-top-1 -right-1",
    bottom_left: "-bottom-1 -left-1",
    bottom_right: "-bottom-1 -right-1"
  }.freeze

  # === STATUS ===
  STATUS_COLORS = {
    online: "bg-green-500",
    offline: "bg-gray-400",
    busy: "bg-red-500",
    away: "bg-yellow-500"
  }.freeze

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
end
