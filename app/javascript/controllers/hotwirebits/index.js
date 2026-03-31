// HotwireBits Stimulus controllers index
// Import this file in your app/javascript/controllers/index.js

import { application } from "../application"

// HotwireBits controllers — original
import RbAccordionController from "./hotwirebits/rb_accordion_controller"
import RbAlertController from "./hotwirebits/rb_alert_controller"
import RbBannerController from "./hotwirebits/rb_banner_controller"
import RbBurgerController from "./hotwirebits/rb_burger_controller"
import RbCalendarController from "./hotwirebits/rb_calendar_controller"
import RbCarouselController from "./hotwirebits/rb_carousel_controller"
import RbClipboardController from "./hotwirebits/rb_clipboard_controller"
import RbCollapsibleController from "./hotwirebits/rb_collapsible_controller"
import RbComboboxController from "./hotwirebits/rb_combobox_controller"
import RbCookieConsentController from "./hotwirebits/rb_cookie_consent_controller"
import RbCountdownController from "./hotwirebits/rb_countdown_controller"
import RbDatepickerController from "./hotwirebits/rb_datepicker_controller"
import RbDialogController from "./hotwirebits/rb_dialog_controller"
import RbDrawerController from "./hotwirebits/rb_drawer_controller"
import RbDropdownController from "./hotwirebits/rb_dropdown_controller"
import RbFeedbackController from "./hotwirebits/rb_feedback_controller"
import RbHighlightController from "./hotwirebits/rb_highlight_controller"
import RbKanbanController from "./hotwirebits/rb_kanban_controller"
import RbMarqueeController from "./hotwirebits/rb_marquee_controller"
import RbMenubarController from "./hotwirebits/rb_menubar_controller"
import RbMultiselectController from "./hotwirebits/rb_multiselect_controller"
import RbOtpController from "./hotwirebits/rb_otp_controller"
import RbPasswordController from "./hotwirebits/rb_password_controller"
import RbPopoverController from "./hotwirebits/rb_popover_controller"
import RbRatingController from "./hotwirebits/rb_rating_controller"
import RbResizableController from "./hotwirebits/rb_resizable_controller"
import RbSearchController from "./hotwirebits/rb_search_controller"
import RbSheetController from "./hotwirebits/rb_sheet_controller"
import RbSidebarController from "./hotwirebits/rb_sidebar_controller"
import RbSpeedDialController from "./hotwirebits/rb_speed_dial_controller"
import RbSpoilerController from "./hotwirebits/rb_spoiler_controller"
import RbStepsController from "./hotwirebits/rb_steps_controller"
import RbSwapController from "./hotwirebits/rb_swap_controller"
import RbSwitchController from "./hotwirebits/rb_switch_controller"
import RbTabsController from "./hotwirebits/rb_tabs_controller"
import RbTagsController from "./hotwirebits/rb_tags_controller"
import RbThemeController from "./hotwirebits/rb_theme_controller"
import RbToastController from "./hotwirebits/rb_toast_controller"
import RbToggleController from "./hotwirebits/rb_toggle_controller"
import RbTreeController from "./hotwirebits/rb_tree_controller"

// HotwireBits controllers — missing from original set
import RbBadgeController from "./hotwirebits/rb_badge_controller"
import RbPaginatorController from "./hotwirebits/rb_paginator_controller"
import RbToggleButtonController from "./hotwirebits/rb_toggle_button_controller"
import RbToggleButtonGroupController from "./hotwirebits/rb_toggle_button_group_controller"

// HotwireBits controllers — new stubs
import RbActivityFeedController from "./hotwirebits/rb_activity_feed_controller"
import RbAiChatController from "./hotwirebits/rb_ai_chat_controller"
import RbAngleSliderController from "./hotwirebits/rb_angle_slider_controller"
import RbAnimatedNumberController from "./hotwirebits/rb_animated_number_controller"
import RbAutocompleteController from "./hotwirebits/rb_autocomplete_controller"
import RbCodeHighlightController from "./hotwirebits/rb_code_highlight_controller"
import RbColorInputController from "./hotwirebits/rb_color_input_controller"
import RbColorPickerController from "./hotwirebits/rb_color_picker_controller"
import RbCommandBarController from "./hotwirebits/rb_command_bar_controller"
import RbCompareController from "./hotwirebits/rb_compare_controller"
import RbConfirmDialogController from "./hotwirebits/rb_confirm_dialog_controller"
import RbConfirmPopupController from "./hotwirebits/rb_confirm_popup_controller"
import RbContextMenuController from "./hotwirebits/rb_context_menu_controller"
import RbCookieSettingsController from "./hotwirebits/rb_cookie_settings_controller"
import RbDataViewController from "./hotwirebits/rb_data_view_controller"
import RbDateRangeController from "./hotwirebits/rb_date_range_controller"
import RbDragDropController from "./hotwirebits/rb_drag_drop_controller"
import RbFileBrowserController from "./hotwirebits/rb_file_browser_controller"
import RbHover3dController from "./hotwirebits/rb_hover_3d_controller"
import RbHoverCardController from "./hotwirebits/rb_hover_card_controller"
import RbHoverGalleryController from "./hotwirebits/rb_hover_gallery_controller"
import RbImageController from "./hotwirebits/rb_image_controller"
import RbImageCompareController from "./hotwirebits/rb_image_compare_controller"
import RbImageZoomController from "./hotwirebits/rb_image_zoom_controller"
import RbInlineEditController from "./hotwirebits/rb_inline_edit_controller"
import RbInplaceController from "./hotwirebits/rb_inplace_controller"
import RbInputNumberController from "./hotwirebits/rb_input_number_controller"
import RbJsonInputController from "./hotwirebits/rb_json_input_controller"
import RbKnobController from "./hotwirebits/rb_knob_controller"
import RbLightboxController from "./hotwirebits/rb_lightbox_controller"
import RbLikeController from "./hotwirebits/rb_like_controller"
import RbListboxController from "./hotwirebits/rb_listbox_controller"
import RbMonthPickerController from "./hotwirebits/rb_month_picker_controller"
import RbMonthPickerInputController from "./hotwirebits/rb_month_picker_input_controller"
import RbNavMenuController from "./hotwirebits/rb_nav_menu_controller"
import RbNewsletterController from "./hotwirebits/rb_newsletter_controller"
import RbNotificationController from "./hotwirebits/rb_notification_controller"
import RbPanelController from "./hotwirebits/rb_panel_controller"
import RbPasswordStrengthController from "./hotwirebits/rb_password_strength_controller"
import RbPasswordToggleController from "./hotwirebits/rb_password_toggle_controller"
import RbPortalController from "./hotwirebits/rb_portal_controller"
import RbQuickviewController from "./hotwirebits/rb_quickview_controller"
import RbRangeSliderController from "./hotwirebits/rb_range_slider_controller"
import RbRichTextEditorController from "./hotwirebits/rb_rich_text_editor_controller"
import RbSignatureController from "./hotwirebits/rb_signature_controller"
import RbSplitterController from "./hotwirebits/rb_splitter_controller"
import RbStepperFormController from "./hotwirebits/rb_stepper_form_controller"
import RbTagInputController from "./hotwirebits/rb_tag_input_controller"
import RbThemeSelectorController from "./hotwirebits/rb_theme_selector_controller"
import RbTimePickerController from "./hotwirebits/rb_time_picker_controller"
import RbTooltipController from "./hotwirebits/rb_tooltip_controller"
import RbTwoFactorController from "./hotwirebits/rb_two_factor_controller"
import RbValidatorController from "./hotwirebits/rb_validator_controller"
import RbVoiceRecorderController from "./hotwirebits/rb_voice_recorder_controller"
import TextRotateController from "./hotwirebits/text_rotate_controller"

// Register all controllers — original
application.register("hw-accordion", RbAccordionController)
application.register("hw-alert", RbAlertController)
application.register("hw-banner", RbBannerController)
application.register("hw-burger", RbBurgerController)
application.register("hw-calendar", RbCalendarController)
application.register("hw-carousel", RbCarouselController)
application.register("hw-clipboard", RbClipboardController)
application.register("hw-collapsible", RbCollapsibleController)
application.register("hw-combobox", RbComboboxController)
application.register("hw-cookie-consent", RbCookieConsentController)
application.register("hw-countdown", RbCountdownController)
application.register("hw-datepicker", RbDatepickerController)
application.register("hw-dialog", RbDialogController)
application.register("hw-drawer", RbDrawerController)
application.register("hw-dropdown", RbDropdownController)
application.register("hw-feedback", RbFeedbackController)
application.register("hw-highlight", RbHighlightController)
application.register("hw-kanban", RbKanbanController)
application.register("hw-marquee", RbMarqueeController)
application.register("hw-menubar", RbMenubarController)
application.register("hw-multiselect", RbMultiselectController)
application.register("hw-otp", RbOtpController)
application.register("hw-password", RbPasswordController)
application.register("hw-popover", RbPopoverController)
application.register("hw-rating", RbRatingController)
application.register("hw-resizable", RbResizableController)
application.register("hw-search", RbSearchController)
application.register("hw-sheet", RbSheetController)
application.register("hw-sidebar", RbSidebarController)
application.register("hw-speed-dial", RbSpeedDialController)
application.register("hw-spoiler", RbSpoilerController)
application.register("hw-steps", RbStepsController)
application.register("hw-swap", RbSwapController)
application.register("hw-switch", RbSwitchController)
application.register("hw-tabs", RbTabsController)
application.register("hw-tags", RbTagsController)
application.register("hw-theme", RbThemeController)
application.register("hw-toast", RbToastController)
application.register("hw-toggle", RbToggleController)
application.register("hw-tree", RbTreeController)

// Register all controllers — missing from original set
application.register("hw-badge", RbBadgeController)
application.register("hw-paginator", RbPaginatorController)
application.register("hw-toggle-button", RbToggleButtonController)
application.register("hw-toggle-group", RbToggleButtonGroupController)

// Register all controllers — new stubs
application.register("hw-activity-feed", RbActivityFeedController)
application.register("hw-ai-chat", RbAiChatController)
application.register("hw-angle-slider", RbAngleSliderController)
application.register("hw-animated-number", RbAnimatedNumberController)
application.register("hw-autocomplete", RbAutocompleteController)
application.register("hw-code-highlight", RbCodeHighlightController)
application.register("hw-color-input", RbColorInputController)
application.register("hw-color-picker", RbColorPickerController)
application.register("hw-command-bar", RbCommandBarController)
application.register("hw-compare", RbCompareController)
application.register("hw-confirm-dialog", RbConfirmDialogController)
application.register("hw-confirm-popup", RbConfirmPopupController)
application.register("hw-context-menu", RbContextMenuController)
application.register("hw-cookie-settings", RbCookieSettingsController)
application.register("hw-data-view", RbDataViewController)
application.register("hw-date-range", RbDateRangeController)
application.register("hw-drag-drop", RbDragDropController)
application.register("hw-file-browser", RbFileBrowserController)
application.register("hover-3d", RbHover3dController)
application.register("hw-hover-card", RbHoverCardController)
application.register("hover-gallery", RbHoverGalleryController)
application.register("hw-image", RbImageController)
application.register("hw-image-compare", RbImageCompareController)
application.register("hw-image-zoom", RbImageZoomController)
application.register("hw-inline-edit", RbInlineEditController)
application.register("hw-inplace", RbInplaceController)
application.register("hw-input-number", RbInputNumberController)
application.register("hw-json-input", RbJsonInputController)
application.register("hw-knob", RbKnobController)
application.register("hw-lightbox", RbLightboxController)
application.register("hw-like", RbLikeController)
application.register("hw-listbox", RbListboxController)
application.register("hw-month-picker", RbMonthPickerController)
application.register("hw-month-picker-input", RbMonthPickerInputController)
application.register("hw-nav-menu", RbNavMenuController)
application.register("hw-newsletter", RbNewsletterController)
application.register("hw-notification", RbNotificationController)
application.register("hw-panel", RbPanelController)
application.register("hw-password-strength", RbPasswordStrengthController)
application.register("hw-password-toggle", RbPasswordToggleController)
application.register("hw-portal", RbPortalController)
application.register("hw-quickview", RbQuickviewController)
application.register("hw-range-slider", RbRangeSliderController)
application.register("hw-rich-text-editor", RbRichTextEditorController)
application.register("hw-signature", RbSignatureController)
application.register("hw-splitter", RbSplitterController)
application.register("hw-stepper-form", RbStepperFormController)
application.register("hw-tag-input", RbTagInputController)
application.register("hw-theme-selector", RbThemeSelectorController)
application.register("hw-time-picker", RbTimePickerController)
application.register("hw-tooltip", RbTooltipController)
application.register("hw-two-factor", RbTwoFactorController)
application.register("hw-validator", RbValidatorController)
application.register("hw-voice-recorder", RbVoiceRecorderController)
application.register("text-rotate", TextRotateController)

export default application
