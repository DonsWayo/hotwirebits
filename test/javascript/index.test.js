import { describe, it, expect } from "vitest"

/**
 * Tests that each Stimulus controller file can be imported without errors.
 * The index.js depends on a Rails application import so we test controllers individually.
 */
describe("Stimulus controllers importability", () => {
  const controllers = [
    "rb_accordion_controller",
    "rb_alert_controller",
    "rb_banner_controller",
    "rb_burger_controller",
    "rb_calendar_controller",
    "rb_carousel_controller",
    "rb_clipboard_controller",
    "rb_collapsible_controller",
    "rb_combobox_controller",
    "rb_cookie_consent_controller",
    "rb_countdown_controller",
    "rb_datepicker_controller",
    "rb_dialog_controller",
    "rb_drawer_controller",
    "rb_dropdown_controller",
    "rb_feedback_controller",
    "rb_highlight_controller",
    "rb_kanban_controller",
    "rb_marquee_controller",
    "rb_menubar_controller",
    "rb_multiselect_controller",
    "rb_otp_controller",
    "rb_password_controller",
    "rb_popover_controller",
    "rb_rating_controller",
    "rb_resizable_controller",
    "rb_search_controller",
    "rb_sheet_controller",
    "rb_sidebar_controller",
    "rb_speed_dial_controller",
    "rb_spoiler_controller",
    "rb_steps_controller",
    "rb_swap_controller",
    "rb_switch_controller",
    "rb_tabs_controller",
    "rb_tags_controller",
    "rb_theme_controller",
    "rb_toast_controller",
    "rb_toggle_controller",
    "rb_tree_controller",
    "rb_badge_controller",
    "rb_paginator_controller",
    "rb_toggle_button_controller",
    "rb_toggle_button_group_controller",
    "rb_activity_feed_controller",
    "rb_ai_chat_controller",
    "rb_angle_slider_controller",
    "rb_animated_number_controller",
    "rb_autocomplete_controller",
    "rb_code_highlight_controller",
    "rb_color_input_controller",
    "rb_color_picker_controller",
    "rb_command_bar_controller",
    "rb_compare_controller",
    "rb_confirm_dialog_controller",
    "rb_confirm_popup_controller",
    "rb_context_menu_controller",
    "rb_cookie_settings_controller",
    "rb_data_view_controller",
    "rb_date_range_controller",
    "rb_drag_drop_controller",
    "rb_file_browser_controller",
    "rb_hover_3d_controller",
    "rb_hover_card_controller",
    "rb_hover_gallery_controller",
    "rb_image_controller",
    "rb_image_compare_controller",
    "rb_image_zoom_controller",
    "rb_inline_edit_controller",
    "rb_inplace_controller",
    "rb_input_number_controller",
    "rb_json_input_controller",
    "rb_knob_controller",
    "rb_lightbox_controller",
    "rb_like_controller",
    "rb_listbox_controller",
    "rb_month_picker_controller",
    "rb_month_picker_input_controller",
    "rb_nav_menu_controller",
    "rb_newsletter_controller",
    "rb_notification_controller",
    "rb_panel_controller",
    "rb_password_strength_controller",
    "rb_password_toggle_controller",
    "rb_portal_controller",
    "rb_quickview_controller",
    "rb_range_slider_controller",
    "rb_rich_text_editor_controller",
    "rb_signature_controller",
    "rb_splitter_controller",
    "rb_stepper_form_controller",
    "rb_tag_input_controller",
    "rb_theme_selector_controller",
    "rb_time_picker_controller",
    "rb_tooltip_controller",
    "rb_two_factor_controller",
    "rb_validator_controller",
    "rb_voice_recorder_controller",
    "rb_text_rotate_controller",
  ]

  it("has 99 controller files", () => {
    expect(controllers.length).toBe(99)
  })

  controllers.forEach((name) => {
    it(`${name} exports a default Stimulus Controller class`, async () => {
      const mod = await import(`../../app/javascript/controllers/hotwirebits/${name}.js`)
      expect(mod.default).toBeDefined()
      expect(typeof mod.default).toBe("function")
      // All Stimulus controllers extend Controller which has a prototype
      expect(mod.default.prototype).toBeDefined()
    })
  })
})
