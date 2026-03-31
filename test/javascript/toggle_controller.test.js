import { describe, it, expect, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import ToggleController from "../../app/javascript/controllers/hotwirebits/rb_toggle_controller.js"

describe("ToggleController", () => {
  let app

  const html = `
    <button data-controller="hw-toggle" data-action="click->hw-toggle#toggle">
      Toggle
    </button>
  `

  afterEach(() => teardownController(app))

  it("sets aria-pressed false on connect", async () => {
    const { application, container } = await setupController("hw-toggle", ToggleController, html)
    app = application

    const button = container.querySelector("button")
    expect(button.getAttribute("aria-pressed")).toBe("false")
  })

  it("toggles pressed state on click", async () => {
    const { application, container } = await setupController("hw-toggle", ToggleController, html)
    app = application

    const button = container.querySelector("button")
    button.click()
    await sleep(10)
    expect(button.getAttribute("aria-pressed")).toBe("true")
    expect(button.classList.contains("is-pressed")).toBe(true)

    button.click()
    await sleep(10)
    expect(button.getAttribute("aria-pressed")).toBe("false")
    expect(button.classList.contains("is-unpressed")).toBe(true)
  })

  it("applies css classes for pressed state", async () => {
    const { application, container } = await setupController("hw-toggle", ToggleController, html)
    app = application

    const button = container.querySelector("button")
    expect(button.classList.contains("is-unpressed")).toBe(true)
    expect(button.classList.contains("is-pressed")).toBe(false)

    button.click()
    await sleep(10)
    expect(button.classList.contains("is-pressed")).toBe(true)
    expect(button.classList.contains("is-unpressed")).toBe(false)
  })
})
