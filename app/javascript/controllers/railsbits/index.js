// RailsBits Stimulus controllers index
// Import this file in your app/javascript/controllers/index.js

import { application } from "./application"

// RailsBits controllers
import RbAccordionController from "./railsbits/rb_accordion_controller"
import RbAlertController from "./railsbits/rb_alert_controller"
import RbBannerController from "./railsbits/rb_banner_controller"
import RbBurgerController from "./railsbits/rb_burger_controller"
import RbCalendarController from "./railsbits/rb_calendar_controller"
import RbCarouselController from "./railsbits/rb_carousel_controller"
import RbClipboardController from "./railsbits/rb_clipboard_controller"
import RbCollapsibleController from "./railsbits/rb_collapsible_controller"
import RbComboboxController from "./railsbits/rb_combobox_controller"
import RbCookieConsentController from "./railsbits/rb_cookie_consent_controller"
import RbCountdownController from "./railsbits/rb_countdown_controller"
import RbDatepickerController from "./railsbits/rb_datepicker_controller"
import RbDialogController from "./railsbits/rb_dialog_controller"
import RbDrawerController from "./railsbits/rb_drawer_controller"
import RbDropdownController from "./railsbits/rb_dropdown_controller"
import RbFeedbackController from "./railsbits/rb_feedback_controller"
import RbHighlightController from "./railsbits/rb_highlight_controller"
import RbKanbanController from "./railsbits/rb_kanban_controller"
import RbMarqueeController from "./railsbits/rb_marquee_controller"
import RbMenubarController from "./railsbits/rb_menubar_controller"
import RbMultiselectController from "./railsbits/rb_multiselect_controller"
import RbOtpController from "./railsbits/rb_otp_controller"
import RbPasswordController from "./railsbits/rb_password_controller"
import RbPopoverController from "./railsbits/rb_popover_controller"
import RbRatingController from "./railsbits/rb_rating_controller"
import RbResizableController from "./railsbits/rb_resizable_controller"
import RbSearchController from "./railsbits/rb_search_controller"
import RbSheetController from "./railsbits/rb_sheet_controller"
import RbSidebarController from "./railsbits/rb_sidebar_controller"
import RbSpeedDialController from "./railsbits/rb_speed_dial_controller"
import RbSpoilerController from "./railsbits/rb_spoiler_controller"
import RbStepsController from "./railsbits/rb_steps_controller"
import RbSwapController from "./railsbits/rb_swap_controller"
import RbSwitchController from "./railsbits/rb_switch_controller"
import RbTabsController from "./railsbits/rb_tabs_controller"
import RbTagsController from "./railsbits/rb_tags_controller"
import RbThemeController from "./railsbits/rb_theme_controller"
import RbToastController from "./railsbits/rb_toast_controller"
import RbToggleController from "./railsbits/rb_toggle_controller"
import RbTreeController from "./railsbits/rb_tree_controller"

// Register all controllers
application.register("rb-accordion", RbAccordionController)
application.register("rb-alert", RbAlertController)
application.register("rb-banner", RbBannerController)
application.register("rb-burger", RbBurgerController)
application.register("rb-calendar", RbCalendarController)
application.register("rb-carousel", RbCarouselController)
application.register("rb-clipboard", RbClipboardController)
application.register("rb-collapsible", RbCollapsibleController)
application.register("rb-combobox", RbComboboxController)
application.register("rb-cookie-consent", RbCookieConsentController)
application.register("rb-countdown", RbCountdownController)
application.register("rb-datepicker", RbDatepickerController)
application.register("rb-dialog", RbDialogController)
application.register("rb-drawer", RbDrawerController)
application.register("rb-dropdown", RbDropdownController)
application.register("rb-feedback", RbFeedbackController)
application.register("rb-highlight", RbHighlightController)
application.register("rb-kanban", RbKanbanController)
application.register("rb-marquee", RbMarqueeController)
application.register("rb-menubar", RbMenubarController)
application.register("rb-multiselect", RbMultiselectController)
application.register("rb-otp", RbOtpController)
application.register("rb-password", RbPasswordController)
application.register("rb-popover", RbPopoverController)
application.register("rb-rating", RbRatingController)
application.register("rb-resizable", RbResizableController)
application.register("rb-search", RbSearchController)
application.register("rb-sheet", RbSheetController)
application.register("rb-sidebar", RbSidebarController)
application.register("rb-speed-dial", RbSpeedDialController)
application.register("rb-spoiler", RbSpoilerController)
application.register("rb-steps", RbStepsController)
application.register("rb-swap", RbSwapController)
application.register("rb-switch", RbSwitchController)
application.register("rb-tabs", RbTabsController)
application.register("rb-tags", RbTagsController)
application.register("rb-theme", RbThemeController)
application.register("rb-toast", RbToastController)
application.register("rb-toggle", RbToggleController)
application.register("rb-tree", RbTreeController)

export default application
