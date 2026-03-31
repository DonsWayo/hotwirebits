# frozen_string_literal: true

require "test_helper"

class HotwirebitsHelperTest < ActionView::TestCase
  include HotwirebitsHelper

  # === merge_classes ===

  test "merge_classes joins class strings" do
    assert_equal "foo bar baz", merge_classes("foo", "bar", "baz")
  end

  test "merge_classes handles nil values" do
    assert_equal "foo bar", merge_classes("foo", nil, "bar")
  end

  test "merge_classes handles empty strings" do
    assert_equal "foo bar", merge_classes("foo", "", "bar")
  end

  test "merge_classes flattens arrays" do
    assert_equal "a b c d", merge_classes(["a", "b"], "c", "d")
  end

  test "merge_classes returns empty string for all nils" do
    assert_equal "", merge_classes(nil, nil)
  end

  # === safe_svg ===

  test "safe_svg returns empty string for nil" do
    assert_equal "".html_safe, safe_svg(nil)
  end

  test "safe_svg returns empty string for blank" do
    assert_equal "".html_safe, safe_svg("")
  end

  test "safe_svg passes through valid SVG" do
    svg = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 2L2 22h20z"/></svg>'
    assert_equal svg.html_safe, safe_svg(svg)
  end

  test "safe_svg escapes non-SVG content" do
    result = safe_svg("<script>alert('xss')</script>")
    refute result.include?("<script>")
    assert result.include?("&lt;script&gt;")
  end

  test "safe_svg passes through already-safe strings" do
    svg = '<svg xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="10"/></svg>'
    assert_equal svg.html_safe, safe_svg(svg.html_safe)
  end

  # === button_classes ===

  test "button_classes returns default variant classes" do
    classes = button_classes
    assert_includes classes, "inline-flex"
    assert_includes classes, "bg-hw-primary"
    assert_includes classes, "h-9"
  end

  test "button_classes supports destructive variant" do
    classes = button_classes(variant: :destructive)
    assert_includes classes, "bg-hw-destructive"
  end

  test "button_classes supports outline variant" do
    classes = button_classes(variant: :outline)
    assert_includes classes, "border"
    assert_includes classes, "bg-hw-background"
  end

  test "button_classes supports ghost variant" do
    classes = button_classes(variant: :ghost)
    assert_includes classes, "hover:bg-hw-accent"
    refute_includes classes, "bg-hw-primary"
  end

  test "button_classes supports sizes" do
    sm = button_classes(size: :sm)
    lg = button_classes(size: :lg)
    assert_includes sm, "h-8"
    assert_includes lg, "h-10"
  end

  test "button_classes handles disabled state" do
    classes = button_classes(disabled: true)
    assert_includes classes, "disabled:pointer-events-none"
    assert_includes classes, "disabled:opacity-50"
  end

  test "button_classes falls back to default for unknown variant" do
    classes = button_classes(variant: :nonexistent)
    assert_includes classes, "bg-hw-primary"
  end

  # === badge_classes ===

  test "badge_classes returns default classes" do
    classes = badge_classes
    assert_includes classes, "inline-flex"
    assert_includes classes, "rounded-full"
    assert_includes classes, "bg-hw-primary"
  end

  test "badge_classes supports variants" do
    assert_includes badge_classes(variant: :destructive), "bg-hw-destructive"
    assert_includes badge_classes(variant: :outline), "text-hw-foreground"
    assert_includes badge_classes(variant: :success), "bg-hw-success"
  end

  # === input_classes ===

  test "input_classes returns default classes" do
    classes = input_classes
    assert_includes classes, "flex"
    assert_includes classes, "w-full"
    assert_includes classes, "rounded-md"
    assert_includes classes, "border-hw-input"
  end

  test "input_classes handles error state" do
    classes = input_classes(error: true)
    assert_includes classes, "border-hw-destructive"
  end

  test "input_classes handles disabled state" do
    classes = input_classes(disabled: true)
    assert_includes classes, "disabled:cursor-not-allowed"
  end

  # === select_classes ===

  test "select_classes returns default classes" do
    classes = select_classes
    assert_includes classes, "appearance-none"
    assert_includes classes, "pr-8"
  end

  # === textarea_classes ===

  test "textarea_classes returns default classes" do
    classes = textarea_classes
    assert_includes classes, "min-h-[60px]"
    assert_includes classes, "py-2"
  end

  test "textarea_classes supports no-resize" do
    classes = textarea_classes(resize: false)
    assert_includes classes, "resize-none"
  end

  # === card_classes ===

  test "card_classes returns card styling" do
    classes = card_classes
    assert_includes classes, "rounded-lg"
    assert_includes classes, "border-hw-border"
    assert_includes classes, "bg-hw-card"
  end

  # === alert_classes ===

  test "alert_classes returns info type by default" do
    classes = alert_classes
    assert_includes classes, "border-hw-info"
  end

  test "alert_classes supports success type" do
    classes = alert_classes(type: :success)
    assert_includes classes, "border-hw-success"
  end

  test "alert_classes supports warning type" do
    classes = alert_classes(type: :warning)
    assert_includes classes, "border-hw-warning"
  end

  test "alert_classes supports error type" do
    classes = alert_classes(type: :error)
    assert_includes classes, "border-hw-destructive"
  end

  # === toast_classes ===

  test "toast_classes returns info type by default" do
    classes = toast_classes
    assert_includes classes, "border-hw-info"
  end

  test "toast_classes supports error type" do
    classes = toast_classes(type: :error)
    assert_includes classes, "border-hw-destructive"
  end

  # === tab_classes ===

  test "tab_classes inactive state" do
    classes = tab_classes(active: false)
    assert_includes classes, "text-hw-muted-foreground"
  end

  test "tab_classes active state" do
    classes = tab_classes(active: true)
    assert_includes classes, "bg-hw-background"
    assert_includes classes, "shadow-sm"
  end

  # === toggle_classes ===

  test "toggle_classes unpressed state" do
    classes = toggle_classes(pressed: false)
    assert_includes classes, "bg-transparent"
  end

  test "toggle_classes pressed state" do
    classes = toggle_classes(pressed: true)
    assert_includes classes, "bg-hw-accent"
  end

  # === tooltip_classes ===

  test "tooltip_classes returns tooltip styling" do
    classes = tooltip_classes
    assert_includes classes, "z-50"
    assert_includes classes, "rounded-md"
  end

  # === separator_classes ===

  test "separator_classes horizontal" do
    classes = separator_classes(orientation: :horizontal)
    assert_includes classes, "h-[1px]"
  end

  test "separator_classes vertical" do
    classes = separator_classes(orientation: :vertical)
    assert_includes classes, "h-full"
    assert_includes classes, "w-[1px]"
  end

  # === dialog_classes ===

  test "dialog_classes returns default size" do
    classes = dialog_classes
    assert_includes classes, "max-w-lg"
  end

  test "dialog_classes supports sizes" do
    assert_includes dialog_classes(size: :sm), "max-w-sm"
    assert_includes dialog_classes(size: :lg), "max-w-2xl"
    assert_includes dialog_classes(size: :xl), "max-w-4xl"
  end

  # === skeleton_classes ===

  test "skeleton_classes returns animate-pulse" do
    classes = skeleton_classes
    assert_includes classes, "animate-pulse"
    assert_includes classes, "rounded-md"
  end

  test "skeleton_classes supports circle shape" do
    classes = skeleton_classes(shape: :circle)
    assert_includes classes, "rounded-full"
  end

  test "skeleton_classes supports text shape" do
    classes = skeleton_classes(shape: :text)
    assert_includes classes, "h-4"
    assert_includes classes, "w-full"
  end

  # === chip_classes ===

  test "chip_classes returns default" do
    classes = chip_classes
    assert_includes classes, "rounded-full"
    assert_includes classes, "border-hw-border"
  end

  # === hero_classes ===

  test "hero_classes centered variant" do
    classes = hero_classes
    assert_includes classes, "text-center"
  end

  test "hero_classes split variant" do
    classes = hero_classes(variant: :split)
    assert_includes classes, "grid-cols-1"
    assert_includes classes, "lg:grid-cols-2"
  end

  # === stack_classes ===

  test "stack_classes returns flex column" do
    classes = stack_classes
    assert_includes classes, "flex-col"
    assert_includes classes, "gap-4"
  end

  test "stack_classes supports custom gap" do
    classes = stack_classes(gap: 8)
    assert_includes classes, "gap-8"
  end

  # === group_classes ===

  test "group_classes returns flex row" do
    classes = group_classes
    assert_includes classes, "flex"
    assert_includes classes, "gap-2"
    assert_includes classes, "flex-wrap"
  end

  # === container_classes ===

  test "container_classes returns default" do
    classes = container_classes
    assert_includes classes, "mx-auto"
    assert_includes classes, "px-4"
  end

  # === tag_classes ===

  test "tag_classes returns default" do
    classes = tag_classes
    assert_includes classes, "rounded-full"
    assert_includes classes, "bg-hw-muted"
  end

  test "tag_classes supports colors" do
    classes = tag_classes(color: :red)
    assert_includes classes, "bg-hw-destructive/10"
    assert_includes classes, "text-hw-destructive"
  end

  # === type_config ===

  test "type_config returns info config by default" do
    config = type_config
    assert config[:icon].present?
  end

  test "type_config returns success config" do
    config = type_config(:success)
    assert config[:icon].present?
  end

  # === grid_classes ===

  test "grid_classes returns grid with columns" do
    classes = grid_classes(columns: 3)
    assert_includes classes, "grid"
    assert_includes classes, "grid-cols-3"
    assert_includes classes, "gap-4"
  end

  # === pagination_item_classes ===

  test "pagination_item_classes inactive" do
    classes = pagination_item_classes(active: false)
    assert_includes classes, "border-hw-input"
  end

  test "pagination_item_classes active" do
    classes = pagination_item_classes(active: true)
    assert_includes classes, "bg-hw-primary"
  end

  # === ViewComponent slot stubs ===

  test "header? returns false" do
    assert_equal false, header?
  end

  test "footer? returns false" do
    assert_equal false, footer?
  end

  test "slides? returns false" do
    assert_equal false, slides?
  end

  test "confirm_action? returns false" do
    assert_equal false, confirm_action?
  end

  test "cancel_action? returns false" do
    assert_equal false, cancel_action?
  end

  test "content returns nil" do
    result = begin; content; rescue; nil; end
    assert_nil result
  end

  # === Constants defined ===

  test "BUTTON_VARIANTS is frozen" do
    assert BUTTON_VARIANTS.frozen?
    assert_includes BUTTON_VARIANTS.keys, :default
    assert_includes BUTTON_VARIANTS.keys, :destructive
    assert_includes BUTTON_VARIANTS.keys, :outline
    assert_includes BUTTON_VARIANTS.keys, :ghost
    assert_includes BUTTON_VARIANTS.keys, :link
  end

  test "BUTTON_SIZES is frozen" do
    assert BUTTON_SIZES.frozen?
    assert_includes BUTTON_SIZES.keys, :sm
    assert_includes BUTTON_SIZES.keys, :md
    assert_includes BUTTON_SIZES.keys, :lg
  end

  test "ALERT_TYPES is frozen" do
    assert ALERT_TYPES.frozen?
    assert_includes ALERT_TYPES.keys, :info
    assert_includes ALERT_TYPES.keys, :success
    assert_includes ALERT_TYPES.keys, :warning
    assert_includes ALERT_TYPES.keys, :error
  end

  test "TAG_COLORS is frozen" do
    assert TAG_COLORS.frozen?
    assert_includes TAG_COLORS.keys, :default
    assert_includes TAG_COLORS.keys, :red
    assert_includes TAG_COLORS.keys, :blue
  end

  test "STATUS_COLORS aliases AVATAR_STATUS" do
    assert_equal AVATAR_STATUS, STATUS_COLORS
  end
end
