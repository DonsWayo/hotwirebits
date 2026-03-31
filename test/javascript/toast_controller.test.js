import { describe, it, expect, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import ToastController from "../../app/javascript/controllers/hotwirebits/rb_toast_controller.js"

describe("ToastController", () => {
  let app

  const html = `
    <div data-controller="hw-toast" data-hw-toast-duration-value="1000">
      <button data-action="hw-toast#show" data-hw-toast-message-param="Hello!">Show</button>
    </div>
  `

  afterEach(() => {
    teardownController(app)
    // Clean up any toast containers appended to body
    document.querySelectorAll(".toast-container").forEach((el) => el.remove())
  })

  it("creates a toast container on connect", async () => {
    const { application } = await setupController("hw-toast", ToastController, html)
    app = application
    await sleep(100)

    const container = document.querySelector(".toast-container")
    expect(container).not.toBeNull()
  })

  it("shows a toast message", async () => {
    const { application, container } = await setupController("hw-toast", ToastController, html)
    app = application
    await sleep(100)

    const button = container.querySelector("button")
    button.click()
    await sleep(50)

    const toast = document.querySelector(".toast-item")
    expect(toast).not.toBeNull()
    expect(toast.getAttribute("role")).toBe("alert")
  })

  it("toast container has correct position class", async () => {
    const { application } = await setupController("hw-toast", ToastController, html)
    app = application
    await sleep(100)

    const container = document.querySelector(".toast-container")
    expect(container.classList.contains("toast-bottom-right")).toBe(true)
  })
})
