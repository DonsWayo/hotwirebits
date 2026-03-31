import { describe, it, expect, afterEach, beforeEach, vi } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import HighlightController from "../../app/javascript/controllers/hotwirebits/rb_highlight_controller.js"
import CookieConsentController from "../../app/javascript/controllers/hotwirebits/rb_cookie_consent_controller.js"
import FeedbackController from "../../app/javascript/controllers/hotwirebits/rb_feedback_controller.js"
import TagsController from "../../app/javascript/controllers/hotwirebits/rb_tags_controller.js"
import RatingController from "../../app/javascript/controllers/hotwirebits/rb_rating_controller.js"
import DrawerController from "../../app/javascript/controllers/hotwirebits/rb_drawer_controller.js"
import OtpController from "../../app/javascript/controllers/hotwirebits/rb_otp_controller.js"
import CountdownController from "../../app/javascript/controllers/hotwirebits/rb_countdown_controller.js"
import SpeedDialController from "../../app/javascript/controllers/hotwirebits/rb_speed_dial_controller.js"
import SearchController from "../../app/javascript/controllers/hotwirebits/rb_search_controller.js"

describe("HighlightController", () => {
  let app
  afterEach(() => teardownController(app))

  it("registers controller and has expected values/targets", async () => {
    const { application, container } = await setupController("hw-highlight", HighlightController,
      `<div data-controller="hw-highlight" data-hw-highlight-term-value="test" data-hw-highlight-case-sensitive-value="false">
        <div data-hw-highlight-target="content">Some text</div>
      </div>`)
    app = application
    const ctrl = application.getControllerForElementAndIdentifier(container.querySelector("[data-controller]"), "hw-highlight")
    expect(ctrl).toBeTruthy()
    expect(ctrl.termValue).toBe("test")
    expect(ctrl.caseSensitiveValue).toBe(false)
    expect(ctrl.hasContentTarget).toBe(true)
  })
})

describe("CookieConsentController", () => {
  let app
  beforeEach(() => { localStorage.clear() })
  afterEach(() => { teardownController(app); localStorage.clear() })

  it("hides banner on accept and stores preferences", async () => {
    const { application, container } = await setupController("hw-cookie-consent", CookieConsentController,
      `<div data-controller="hw-cookie-consent" data-hw-cookie-consent-key-value="hw-cookie-consent">
        <div data-hw-cookie-consent-target="banner">Cookie Banner</div>
        <div data-hw-cookie-consent-target="modal" class="hidden">Settings</div>
        <button data-action="click->hw-cookie-consent#accept">Accept</button>
      </div>`)
    app = application
    container.querySelector("button").click()
    await sleep(10)
    expect(container.querySelector("[data-hw-cookie-consent-target='banner']").classList.contains("hidden")).toBe(true)
    expect(localStorage.getItem("hw-cookie-consent")).toBeTruthy()
  })

  it("revokes consent", async () => {
    localStorage.setItem("hw-cookie-consent", JSON.stringify({ categories: ["essential"] }))
    const { application, container } = await setupController("hw-cookie-consent", CookieConsentController,
      `<div data-controller="hw-cookie-consent" data-hw-cookie-consent-key-value="hw-cookie-consent">
        <div data-hw-cookie-consent-target="banner" class="hidden">Cookie Banner</div>
        <div data-hw-cookie-consent-target="modal" class="hidden">Settings</div>
        <button data-action="click->hw-cookie-consent#revoke">Revoke</button>
      </div>`)
    app = application
    container.querySelector("button").click()
    await sleep(10)
    expect(localStorage.getItem("hw-cookie-consent")).toBeNull()
    expect(container.querySelector("[data-hw-cookie-consent-target='banner']").classList.contains("hidden")).toBe(false)
  })
})

describe("FeedbackController", () => {
  let app
  afterEach(() => teardownController(app))

  it("selects response and submits", async () => {
    const { application, container } = await setupController("hw-feedback", FeedbackController,
      `<div data-controller="hw-feedback" data-hw-feedback-type-value="rating">
        <div data-hw-feedback-target="form">
          <div data-hw-feedback-target="response" data-action="click->hw-feedback#selectResponse" data-value="good">Good</div>
          <div data-hw-feedback-target="response" data-action="click->hw-feedback#selectResponse" data-value="bad">Bad</div>
          <textarea data-hw-feedback-target="comment">Nice</textarea>
          <button data-action="click->hw-feedback#submit">Submit</button>
        </div>
      </div>`)
    app = application
    const responses = container.querySelectorAll("[data-hw-feedback-target='response']")
    responses[0].click()
    await sleep(10)
    expect(responses[0].classList.contains("selected")).toBe(true)
    expect(responses[1].classList.contains("selected")).toBe(false)
    let detail = null
    container.querySelector("[data-controller]").addEventListener("hw-feedback:submitted", (e) => { detail = e.detail })
    container.querySelector("[data-action*='submit']").click()
    await sleep(10)
    expect(detail).toBeTruthy()
    expect(detail.response).toBe("good")
    // Form should show thank you
    expect(container.querySelector(".feedback-thanks")).toBeTruthy()
  })
})

describe("TagsController", () => {
  let app
  afterEach(() => teardownController(app))

  it("adds and removes tags with render", async () => {
    const { application, container } = await setupController("hw-tags", TagsController,
      `<div data-controller="hw-tags">
        <div data-hw-tags-target="container"></div>
        <input data-hw-tags-target="input" value="vue">
        <button data-action="click->hw-tags#addTag">Add</button>
      </div>`)
    app = application
    const input = container.querySelector("input")
    const btn = container.querySelector("button")
    btn.click()
    await sleep(10)
    expect(container.querySelectorAll(".tag-item").length).toBe(1)
    expect(input.value).toBe("")
    // Add another — must set input value first
    input.value = "react"
    btn.click()
    await sleep(10)
    expect(container.querySelectorAll(".tag-item").length).toBe(2)
  })

  it("handles backspace to remove last tag", async () => {
    const { application, container } = await setupController("hw-tags", TagsController,
      `<div data-controller="hw-tags">
        <div data-hw-tags-target="container"></div>
        <input data-hw-tags-target="input" value="test" data-action="keydown->hw-tags#handleKeydown">
      </div>`)
    app = application
    const input = container.querySelector("input")
    // First add a tag by pressing Enter
    input.dispatchEvent(new KeyboardEvent("keydown", { key: "Enter", bubbles: true }))
    await sleep(10)
    expect(container.querySelectorAll(".tag-item").length).toBe(1)
    // Now clear input and press Backspace
    input.value = ""
    input.dispatchEvent(new KeyboardEvent("keydown", { key: "Backspace", bubbles: true }))
    await sleep(10)
    expect(container.querySelectorAll(".tag-item").length).toBe(0)
  })
})

describe("RatingController", () => {
  let app
  afterEach(() => teardownController(app))

  it("selects rating and renders stars", async () => {
    const { application, container } = await setupController("hw-rating", RatingController,
      `<div data-controller="hw-rating" data-hw-rating-rating-value="0">
        <span data-hw-rating-target="star" data-value="1" data-action="click->hw-rating#select">*</span>
        <span data-hw-rating-target="star" data-value="2" data-action="click->hw-rating#select">*</span>
        <span data-hw-rating-target="star" data-value="3" data-action="click->hw-rating#select">*</span>
      </div>`)
    app = application
    const stars = container.querySelectorAll("[data-hw-rating-target='star']")
    stars[1].click()
    await sleep(10)
    expect(stars[0].classList.contains("star-filled")).toBe(true)
    expect(stars[1].classList.contains("star-filled")).toBe(true)
    expect(stars[2].classList.contains("star-empty")).toBe(true)
    expect(container.querySelector("[data-controller]").getAttribute("aria-valuenow")).toBe("2")
  })

  it("ignores clicks when readonly", async () => {
    const { application, container } = await setupController("hw-rating", RatingController,
      `<div data-controller="hw-rating" data-hw-rating-rating-value="0" data-hw-rating-readonly-value="true">
        <span data-hw-rating-target="star" data-value="1" data-action="click->hw-rating#select">*</span>
      </div>`)
    app = application
    container.querySelector("[data-hw-rating-target='star']").click()
    await sleep(10)
    expect(container.querySelector("[data-controller]").getAttribute("aria-valuenow")).toBe("0")
  })
})

describe("DrawerController", () => {
  let app
  afterEach(() => teardownController(app))

  it("opens and closes drawer", async () => {
    const { application, container } = await setupController("hw-drawer", DrawerController,
      `<div data-controller="hw-drawer" data-hw-drawer-snap-points-value="[100]">
        <button data-action="click->hw-drawer#open">Open</button>
        <div data-hw-drawer-target="drawer" style="transform:translateY(100%);">Drawer</div>
      </div>`)
    app = application
    const drawer = container.querySelector("[data-hw-drawer-target='drawer']")
    container.querySelector("button").click()
    await sleep(10)
    expect(drawer.style.transform).toBe("translateY(0%)")
    // Close via Escape
    document.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", bubbles: true }))
    await sleep(10)
    expect(drawer.style.transform).toBe("translateY(100%)")
  })
})

describe("OtpController", () => {
  let app
  afterEach(() => teardownController(app))

  it("advances focus on input and assembles value", async () => {
    const { application, container } = await setupController("hw-otp", OtpController,
      `<div data-controller="hw-otp">
        <input data-hw-otp-target="input" data-action="input->hw-otp#onInput keydown->hw-otp#onKeydown" maxlength="1">
        <input data-hw-otp-target="input" data-action="input->hw-otp#onInput keydown->hw-otp#onKeydown" maxlength="1">
        <input data-hw-otp-target="input" data-action="input->hw-otp#onInput keydown->hw-otp#onKeydown" maxlength="1">
        <input data-hw-otp-target="input" data-action="input->hw-otp#onInput keydown->hw-otp#onKeydown" maxlength="1">
      </div>`)
    app = application
    const inputs = container.querySelectorAll("input")
    inputs[0].value = "1"
    inputs[0].dispatchEvent(new Event("input", { bubbles: true }))
    await sleep(10)
    expect(document.activeElement).toBe(inputs[1])
    inputs[1].value = "2"
    inputs[1].dispatchEvent(new Event("input", { bubbles: true }))
    await sleep(10)
    expect(document.activeElement).toBe(inputs[2])
  })

  it("navigates back on Backspace", async () => {
    const { application, container } = await setupController("hw-otp", OtpController,
      `<div data-controller="hw-otp">
        <input data-hw-otp-target="input" data-action="input->hw-otp#onInput keydown->hw-otp#onKeydown" maxlength="1">
        <input data-hw-otp-target="input" data-action="input->hw-otp#onInput keydown->hw-otp#onKeydown" maxlength="1">
      </div>`)
    app = application
    const inputs = container.querySelectorAll("input")
    inputs[1].focus()
    inputs[1].value = ""
    inputs[1].dispatchEvent(new KeyboardEvent("keydown", { key: "Backspace", bubbles: true }))
    await sleep(10)
    expect(document.activeElement).toBe(inputs[0])
  })
})

describe("CountdownController", () => {
  let app
  afterEach(() => teardownController(app))

  it("renders countdown values", async () => {
    const future = new Date(Date.now() + 90061000).toISOString() // ~1d 1h 1m 1s
    const { application, container } = await setupController("hw-countdown", CountdownController,
      `<div data-controller="hw-countdown" data-hw-countdown-end-value="${future}" data-hw-countdown-auto-start-value="false">
        <span data-hw-countdown-target="days">00</span>
        <span data-hw-countdown-target="hours">00</span>
        <span data-hw-countdown-target="minutes">00</span>
        <span data-hw-countdown-target="seconds">00</span>
      </div>`)
    app = application
    const ctrl = application.getControllerForElementAndIdentifier(container.querySelector("[data-controller]"), "hw-countdown")
    ctrl.start()
    await sleep(100)
    ctrl.stop()
    expect(container.querySelector("[data-hw-countdown-target='days']").textContent).toBe("01")
  })
})

describe("SpeedDialController", () => {
  let app
  afterEach(() => teardownController(app))

  it("toggles actions menu", async () => {
    const { application, container } = await setupController("hw-speed-dial", SpeedDialController,
      `<div data-controller="hw-speed-dial">
        <button data-hw-speed-dial-target="trigger" data-action="click->hw-speed-dial#toggle" aria-expanded="false">+</button>
        <div data-hw-speed-dial-target="actions" class="hidden">
          <button data-hw-speed-dial-target="action">A</button>
          <button data-hw-speed-dial-target="action">B</button>
        </div>
      </div>`)
    app = application
    const actions = container.querySelector("[data-hw-speed-dial-target='actions']")
    container.querySelector("[data-hw-speed-dial-target='trigger']").click()
    await sleep(10)
    expect(actions.classList.contains("hidden")).toBe(false)
    expect(container.querySelector("[data-hw-speed-dial-target='trigger']").getAttribute("aria-expanded")).toBe("true")
    // Close with Escape
    document.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", bubbles: true }))
    await sleep(10)
    expect(actions.classList.contains("hidden")).toBe(true)
  })
})

describe("SearchController", () => {
  let app
  afterEach(() => teardownController(app))

  it("dispatches search event after debounce", async () => {
    const { application, container } = await setupController("hw-search", SearchController,
      `<div data-controller="hw-search" data-hw-search-delay-value="10">
        <input data-hw-search-target="input" data-action="input->hw-search#search" value="test">
        <div data-hw-search-target="results" class="hidden"></div>
      </div>`)
    app = application
    let searched = false
    container.querySelector("[data-controller]").addEventListener("hw-search:search", () => { searched = true })
    container.querySelector("input").dispatchEvent(new Event("input", { bubbles: true }))
    await sleep(100)
    expect(searched).toBe(true)
  })

  it("hides results on Escape", async () => {
    const { application, container } = await setupController("hw-search", SearchController,
      `<div data-controller="hw-search" data-hw-search-delay-value="10">
        <input data-hw-search-target="input" data-action="keydown->hw-search#handleKeydown" value="">
        <div data-hw-search-target="results">Results</div>
      </div>`)
    app = application
    const results = container.querySelector("[data-hw-search-target='results']")
    container.querySelector("input").dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", bubbles: true }))
    await sleep(10)
    expect(results.classList.contains("hidden")).toBe(true)
  })
})
