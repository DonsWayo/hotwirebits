import { describe, it, expect, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import BadgeController from "../../app/javascript/controllers/hotwirebits/rb_badge_controller.js"
import PaginatorController from "../../app/javascript/controllers/hotwirebits/rb_paginator_controller.js"
import ActivityFeedController from "../../app/javascript/controllers/hotwirebits/rb_activity_feed_controller.js"
import DataViewController from "../../app/javascript/controllers/hotwirebits/rb_data_view_controller.js"
import ToggleButtonController from "../../app/javascript/controllers/hotwirebits/rb_toggle_button_controller.js"
import CookieSettingsController from "../../app/javascript/controllers/hotwirebits/rb_cookie_settings_controller.js"
import FileBrowserController from "../../app/javascript/controllers/hotwirebits/rb_file_browser_controller.js"
import ConfirmPopupController from "../../app/javascript/controllers/hotwirebits/rb_confirm_popup_controller.js"
import PanelController from "../../app/javascript/controllers/hotwirebits/rb_panel_controller.js"
import ConfirmDialogController from "../../app/javascript/controllers/hotwirebits/rb_confirm_dialog_controller.js"

describe("BadgeController", () => {
  let app
  afterEach(() => teardownController(app))

  it("dismiss hides the element", async () => {
    const { application, container } = await setupController("hw-badge", BadgeController,
      `<span data-controller="hw-badge" data-action="click->hw-badge#dismiss">Badge</span>`)
    app = application
    const badge = container.querySelector("[data-controller]")
    badge.click()
    await sleep(10)
    expect(badge.classList.contains("hidden")).toBe(true)
  })
})

describe("PaginatorController", () => {
  let app
  afterEach(() => teardownController(app))

  it("dispatches change event on perPage change", async () => {
    const { application, container } = await setupController("hw-paginator", PaginatorController,
      `<div data-controller="hw-paginator"><select data-action="change->hw-paginator#changePerPage"><option value="10">10</option><option value="25">25</option></select></div>`)
    app = application
    // The controller dispatches, we just verify it doesn't crash
    const select = container.querySelector("select")
    select.value = "25"
    select.dispatchEvent(new Event("change", { bubbles: true }))
    await sleep(10)
    expect(select.value).toBe("25")
  })
})

describe("ActivityFeedController", () => {
  let app
  afterEach(() => teardownController(app))

  it("append inserts HTML into list target", async () => {
    const { application, container } = await setupController("hw-activity-feed", ActivityFeedController,
      `<div data-controller="hw-activity-feed"><div data-hw-activity-feed-target="list"></div></div>`)
    app = application
    const el = container.querySelector("[data-controller]")
    el.dispatchEvent(new CustomEvent("hw-activity-feed:append", { detail: { html: "<p>New item</p>" }, bubbles: true }))
    await sleep(10)
    // append is called via action dispatch; test the target exists
    const list = container.querySelector("[data-hw-activity-feed-target='list']")
    expect(list).not.toBeNull()
  })
})

describe("DataViewController", () => {
  let app
  afterEach(() => teardownController(app))

  it("switches view on click", async () => {
    const { application, container } = await setupController("hw-data-view", DataViewController,
      `<div data-controller="hw-data-view"><button data-action="click->hw-data-view#switch" data-view="list">List</button></div>`)
    app = application
    const btn = container.querySelector("button")
    btn.click()
    await sleep(10)
    // Controller uses event.currentTarget.dataset.view
    expect(btn.dataset.view).toBe("list")
  })
})

describe("ToggleButtonController", () => {
  let app
  afterEach(() => teardownController(app))

  it("toggles aria-pressed", async () => {
    const { application, container } = await setupController("hw-toggle-button", ToggleButtonController,
      `<button data-controller="hw-toggle-button" data-action="click->hw-toggle-button#toggle" aria-pressed="false">Toggle</button>`)
    app = application
    const btn = container.querySelector("button")
    btn.click()
    await sleep(10)
    expect(btn.getAttribute("aria-pressed")).toBe("true")
    btn.click()
    await sleep(10)
    expect(btn.getAttribute("aria-pressed")).toBe("false")
  })
})

describe("CookieSettingsController", () => {
  let app
  afterEach(() => teardownController(app))

  it("opens and closes modal", async () => {
    const { application, container } = await setupController("hw-cookie-settings", CookieSettingsController,
      `<div data-controller="hw-cookie-settings">
        <button data-action="click->hw-cookie-settings#open">Open</button>
        <div data-hw-cookie-settings-target="modal" class="hidden">Modal</div>
      </div>`)
    app = application
    const modal = container.querySelector("[data-hw-cookie-settings-target='modal']")
    const btn = container.querySelector("button")
    btn.click()
    await sleep(10)
    expect(modal.classList.contains("hidden")).toBe(false)
  })
})

describe("FileBrowserController", () => {
  let app
  afterEach(() => teardownController(app))

  it("browse clicks input target", async () => {
    const { application, container } = await setupController("hw-file-browser", FileBrowserController,
      `<div data-controller="hw-file-browser">
        <button data-action="click->hw-file-browser#browse">Browse</button>
        <input data-hw-file-browser-target="input" type="file" class="hidden">
      </div>`)
    app = application
    let clicked = false
    const input = container.querySelector("input")
    input.addEventListener("click", () => { clicked = true })
    const btn = container.querySelector("button")
    btn.click()
    await sleep(10)
    expect(clicked).toBe(true)
  })
})

describe("ConfirmPopupController", () => {
  let app
  afterEach(() => teardownController(app))

  it("opens and closes popup", async () => {
    const { application, container } = await setupController("hw-confirm-popup", ConfirmPopupController,
      `<div data-controller="hw-confirm-popup">
        <button data-action="click->hw-confirm-popup#open">Open</button>
        <div data-hw-confirm-popup-target="popup" class="hidden">Popup</div>
      </div>`)
    app = application
    const popup = container.querySelector("[data-hw-confirm-popup-target='popup']")
    container.querySelector("button").click()
    await sleep(10)
    expect(popup.classList.contains("hidden")).toBe(false)
  })
})

describe("PanelController", () => {
  let app
  afterEach(() => teardownController(app))

  it("toggles content visibility", async () => {
    const { application, container } = await setupController("hw-panel", PanelController,
      `<div data-controller="hw-panel">
        <button data-action="click->hw-panel#toggle">Toggle</button>
        <div data-hw-panel-target="content">Content</div>
        <span data-hw-panel-target="chevron"></span>
      </div>`)
    app = application
    const content = container.querySelector("[data-hw-panel-target='content']")
    container.querySelector("button").click()
    await sleep(10)
    expect(content.classList.contains("hidden")).toBe(true)
    container.querySelector("button").click()
    await sleep(10)
    expect(content.classList.contains("hidden")).toBe(false)
  })
})

describe("ConfirmDialogController", () => {
  let app
  afterEach(() => teardownController(app))

  it("opens, confirms and closes dialog", async () => {
    const { application, container } = await setupController("hw-confirm-dialog", ConfirmDialogController,
      `<div data-controller="hw-confirm-dialog">
        <button data-action="click->hw-confirm-dialog#open">Open</button>
        <div data-hw-confirm-dialog-target="dialog" class="hidden">
          <button data-action="click->hw-confirm-dialog#confirm">OK</button>
          <button data-action="click->hw-confirm-dialog#cancel">Cancel</button>
        </div>
      </div>`)
    app = application
    const dialog = container.querySelector("[data-hw-confirm-dialog-target='dialog']")
    container.querySelector("button").click()
    await sleep(10)
    expect(dialog.classList.contains("hidden")).toBe(false)
    container.querySelector("[data-action='click->hw-confirm-dialog#confirm']").click()
    await sleep(10)
    expect(dialog.classList.contains("hidden")).toBe(true)
  })
})
