// HotwireBits Stimulus controllers index
// Import this file in your app/javascript/controllers/index.js

import { application } from "./application"

// HotwireBits controllers
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

// Register all controllers
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

export default application
