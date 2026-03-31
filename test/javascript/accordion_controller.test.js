import { describe, it, expect, beforeEach, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import AccordionController from "../../app/javascript/controllers/hotwirebits/rb_accordion_controller.js"

describe("AccordionController", () => {
  let app

  afterEach(() => teardownController(app))

  it("toggles content visibility", async () => {
    const { application, container } = await setupController(
      "hw-accordion",
      AccordionController,
      `<div data-controller="hw-accordion">
        <button data-action="hw-accordion#toggle">Toggle</button>
        <div data-hw-accordion-target="content" class="hidden">Content</div>
      </div>`
    )
    app = application

    const button = container.querySelector("button")
    const content = container.querySelector('[data-hw-accordion-target="content"]')

    expect(content.classList.contains("hidden")).toBe(true)
    button.click()
    await sleep(10)
    expect(content.classList.contains("hidden")).toBe(false)
    button.click()
    await sleep(10)
    expect(content.classList.contains("hidden")).toBe(true)
  })

  it("sets aria-expanded on trigger", async () => {
    const { application, container } = await setupController(
      "hw-accordion",
      AccordionController,
      `<div data-controller="hw-accordion">
        <button data-action="hw-accordion#toggle">Toggle</button>
        <div data-hw-accordion-target="content" class="hidden">Content</div>
      </div>`
    )
    app = application

    const button = container.querySelector("button")
    button.click()
    await sleep(10)
    expect(button.getAttribute("aria-expanded")).toBe("true")
    button.click()
    await sleep(10)
    expect(button.getAttribute("aria-expanded")).toBe("false")
  })
})
