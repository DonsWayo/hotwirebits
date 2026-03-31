import { describe, it, expect, afterEach, vi } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import DialogController from "../../app/javascript/controllers/hotwirebits/rb_dialog_controller.js"

describe("DialogController", () => {
  let app

  const html = `
    <div data-controller="hw-dialog">
      <button data-action="hw-dialog#open">Open</button>
      <dialog data-hw-dialog-target="panel">
        <button data-action="hw-dialog#close">Close</button>
        <input type="text" />
      </dialog>
    </div>
  `

  afterEach(() => teardownController(app))

  it("opens dialog with showModal", async () => {
    const { application, container } = await setupController("hw-dialog", DialogController, html)
    app = application

    const dialog = container.querySelector("dialog")
    // jsdom doesn't support showModal natively, mock it
    dialog.showModal = vi.fn(() => { dialog.open = true })
    dialog.close = vi.fn(() => { dialog.open = false })

    const openBtn = container.querySelector('[data-action="hw-dialog#open"]')
    openBtn.click()
    await sleep(10)

    expect(dialog.showModal).toHaveBeenCalled()
  })

  it("closes dialog", async () => {
    const { application, container } = await setupController("hw-dialog", DialogController, html)
    app = application

    const dialog = container.querySelector("dialog")
    dialog.showModal = vi.fn(() => { dialog.open = true })
    dialog.close = vi.fn(() => { dialog.open = false })

    const openBtn = container.querySelector('[data-action="hw-dialog#open"]')
    const closeBtn = container.querySelector('[data-action="hw-dialog#close"]')

    openBtn.click()
    await sleep(10)
    closeBtn.click()
    await sleep(10)

    expect(dialog.close).toHaveBeenCalled()
  })

  it("closes on Escape key", async () => {
    const { application, container } = await setupController("hw-dialog", DialogController, html)
    app = application

    const dialog = container.querySelector("dialog")
    const controller = container.querySelector('[data-controller="hw-dialog"]')
    dialog.showModal = vi.fn(() => { dialog.open = true })
    dialog.close = vi.fn(() => { dialog.open = false })

    const openBtn = container.querySelector('[data-action="hw-dialog#open"]')
    openBtn.click()
    await sleep(10)

    controller.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", bubbles: true }))
    await sleep(10)

    expect(dialog.close).toHaveBeenCalled()
  })
})
