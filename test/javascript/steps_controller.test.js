import { describe, it, expect, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import StepsController from "../../app/javascript/controllers/hotwirebits/rb_steps_controller.js"

describe("StepsController", () => {
  let app

  const html = `
    <div data-controller="hw-steps" data-hw-steps-current-value="0">
      <div data-hw-steps-target="step" data-index="0">Step 1</div>
      <div data-hw-steps-target="connector"></div>
      <div data-hw-steps-target="step" data-index="1">Step 2</div>
      <div data-hw-steps-target="connector"></div>
      <div data-hw-steps-target="step" data-index="2">Step 3</div>
      <button data-action="hw-steps#next">Next</button>
      <button data-action="hw-steps#prev">Prev</button>
    </div>
  `

  afterEach(() => teardownController(app))

  it("activates first step on connect", async () => {
    const { application, container } = await setupController("hw-steps", StepsController, html)
    app = application

    const steps = container.querySelectorAll('[data-hw-steps-target="step"]')
    expect(steps[0].classList.contains("step-active")).toBe(true)
    expect(steps[0].getAttribute("aria-current")).toBe("step")
    expect(steps[1].classList.contains("step-pending")).toBe(true)
  })

  it("advances to next step", async () => {
    const { application, container } = await setupController("hw-steps", StepsController, html)
    app = application

    const nextBtn = container.querySelector('[data-action="hw-steps#next"]')
    nextBtn.click()
    await sleep(10)

    const steps = container.querySelectorAll('[data-hw-steps-target="step"]')
    expect(steps[0].classList.contains("step-completed")).toBe(true)
    expect(steps[1].classList.contains("step-active")).toBe(true)
    expect(steps[1].getAttribute("aria-current")).toBe("step")
  })

  it("goes back to previous step", async () => {
    const { application, container } = await setupController("hw-steps", StepsController, html)
    app = application

    const nextBtn = container.querySelector('[data-action="hw-steps#next"]')
    const prevBtn = container.querySelector('[data-action="hw-steps#prev"]')

    nextBtn.click()
    await sleep(10)
    prevBtn.click()
    await sleep(10)

    const steps = container.querySelectorAll('[data-hw-steps-target="step"]')
    expect(steps[0].classList.contains("step-active")).toBe(true)
    expect(steps[1].classList.contains("step-pending")).toBe(true)
  })

  it("does not go below 0", async () => {
    const { application, container } = await setupController("hw-steps", StepsController, html)
    app = application

    const prevBtn = container.querySelector('[data-action="hw-steps#prev"]')
    prevBtn.click()
    await sleep(10)

    const steps = container.querySelectorAll('[data-hw-steps-target="step"]')
    expect(steps[0].classList.contains("step-active")).toBe(true)
  })

  it("does not go above max", async () => {
    const { application, container } = await setupController("hw-steps", StepsController, html)
    app = application

    const nextBtn = container.querySelector('[data-action="hw-steps#next"]')
    nextBtn.click()
    await sleep(10)
    nextBtn.click()
    await sleep(10)
    nextBtn.click() // Should not go past index 2
    await sleep(10)

    const steps = container.querySelectorAll('[data-hw-steps-target="step"]')
    expect(steps[2].classList.contains("step-active")).toBe(true)
    expect(steps[2].getAttribute("aria-current")).toBe("step")
  })

  it("marks connectors done when step is completed", async () => {
    const { application, container } = await setupController("hw-steps", StepsController, html)
    app = application

    const nextBtn = container.querySelector('[data-action="hw-steps#next"]')
    nextBtn.click()
    await sleep(10)

    const connectors = container.querySelectorAll('[data-hw-steps-target="connector"]')
    expect(connectors[0].classList.contains("connector-done")).toBe(true)
    expect(connectors[1].classList.contains("connector-done")).toBe(false)
  })

  it("goTo handles NaN index safely (bug fix)", async () => {
    const { application, container } = await setupController("hw-steps", StepsController, html)
    app = application

    // Simulate goTo with invalid index — should not crash
    const controller = application.getControllerForElementAndIdentifier(
      container.querySelector('[data-controller="hw-steps"]'),
      "hw-steps"
    )
    controller.goTo({ currentTarget: { dataset: { index: "invalid" } }, params: {} })
    await sleep(10)

    // Should still be on step 0
    const steps = container.querySelectorAll('[data-hw-steps-target="step"]')
    expect(steps[0].classList.contains("step-active")).toBe(true)
  })

  it("goTo handles out-of-range index safely (bug fix)", async () => {
    const { application, container } = await setupController("hw-steps", StepsController, html)
    app = application

    const controller = application.getControllerForElementAndIdentifier(
      container.querySelector('[data-controller="hw-steps"]'),
      "hw-steps"
    )
    controller.goTo({ currentTarget: { dataset: { index: "999" } }, params: {} })
    await sleep(10)

    // Should still be on step 0
    const steps = container.querySelectorAll('[data-hw-steps-target="step"]')
    expect(steps[0].classList.contains("step-active")).toBe(true)
  })
})
