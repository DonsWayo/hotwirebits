import { describe, it, expect, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import CollapsibleController from "../../app/javascript/controllers/hotwirebits/rb_collapsible_controller.js"

describe("CollapsibleController", () => {
  let app

  const html = `
    <div data-controller="hw-collapsible">
      <button data-hw-collapsible-target="trigger" data-action="click->hw-collapsible#toggle">Toggle</button>
      <div data-hw-collapsible-target="content">Content here</div>
    </div>
  `

  afterEach(() => teardownController(app))

  it("hides content on connect when closed", async () => {
    const { application, container } = await setupController("hw-collapsible", CollapsibleController, html)
    app = application

    const content = container.querySelector('[data-hw-collapsible-target="content"]')
    expect(content.classList.contains("hidden")).toBe(true)
  })

  it("shows content when open value is true", async () => {
    const { application, container } = await setupController(
      "hw-collapsible",
      CollapsibleController,
      `<div data-controller="hw-collapsible" data-hw-collapsible-open-value="true">
        <button data-hw-collapsible-target="trigger" data-action="click->hw-collapsible#toggle">Toggle</button>
        <div data-hw-collapsible-target="content">Content</div>
      </div>`
    )
    app = application

    const content = container.querySelector('[data-hw-collapsible-target="content"]')
    expect(content.classList.contains("hidden")).toBe(false)
  })

  it("toggles content on click", async () => {
    const { application, container } = await setupController("hw-collapsible", CollapsibleController, html)
    app = application

    const button = container.querySelector("button")
    const content = container.querySelector('[data-hw-collapsible-target="content"]')

    expect(content.classList.contains("hidden")).toBe(true)

    button.click()
    await sleep(10)
    expect(content.classList.contains("hidden")).toBe(false)
  })

  it("sets aria-expanded on trigger", async () => {
    const { application, container } = await setupController("hw-collapsible", CollapsibleController, html)
    app = application

    const button = container.querySelector("button")

    button.click()
    await sleep(10)
    expect(button.getAttribute("aria-expanded")).toBe("true")
  })
})
