import { describe, it, expect, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import LightboxController from "../../app/javascript/controllers/hotwirebits/rb_lightbox_controller.js"

describe("LightboxController", () => {
  let app

  const html = `
    <div data-controller="hw-lightbox">
      <img data-hw-lightbox-target="image" data-index="0" data-action="click->hw-lightbox#open" src="a.jpg" />
      <img data-hw-lightbox-target="image" data-index="1" data-action="click->hw-lightbox#open" src="b.jpg" class="hidden" />
      <img data-hw-lightbox-target="image" data-index="2" data-action="click->hw-lightbox#open" src="c.jpg" class="hidden" />
      <div data-hw-lightbox-target="overlay" class="hidden">
        <button data-action="hw-lightbox#prev">Prev</button>
        <button data-action="hw-lightbox#next">Next</button>
        <button data-action="hw-lightbox#close">Close</button>
      </div>
    </div>
  `

  afterEach(() => teardownController(app))

  it("opens overlay on image click", async () => {
    const { application, container } = await setupController("hw-lightbox", LightboxController, html)
    app = application

    const img = container.querySelector('img[data-index="0"]')
    const overlay = container.querySelector('[data-hw-lightbox-target="overlay"]')

    img.click()
    await sleep(10)

    expect(overlay.classList.contains("hidden")).toBe(false)
  })

  it("closes overlay", async () => {
    const { application, container } = await setupController("hw-lightbox", LightboxController, html)
    app = application

    const img = container.querySelector('img[data-index="0"]')
    const overlay = container.querySelector('[data-hw-lightbox-target="overlay"]')
    const closeBtn = container.querySelector('[data-action="hw-lightbox#close"]')

    img.click()
    await sleep(10)
    expect(overlay.classList.contains("hidden")).toBe(false)

    closeBtn.click()
    await sleep(10)
    expect(overlay.classList.contains("hidden")).toBe(true)
  })

  it("navigates to next image", async () => {
    const { application, container } = await setupController("hw-lightbox", LightboxController, html)
    app = application

    const img = container.querySelector('img[data-index="0"]')
    img.click()
    await sleep(10)

    const nextBtn = container.querySelector('[data-action="hw-lightbox#next"]')
    nextBtn.click()
    await sleep(10)

    const images = container.querySelectorAll('[data-hw-lightbox-target="image"]')
    expect(images[0].classList.contains("hidden")).toBe(true)
    expect(images[1].classList.contains("hidden")).toBe(false)
    expect(images[2].classList.contains("hidden")).toBe(true)
  })

  it("wraps around from last to first image", async () => {
    const { application, container } = await setupController("hw-lightbox", LightboxController, html)
    app = application

    const img = container.querySelector('img[data-index="2"]')
    img.click()
    await sleep(10)

    const nextBtn = container.querySelector('[data-action="hw-lightbox#next"]')
    nextBtn.click()
    await sleep(10)

    const images = container.querySelectorAll('[data-hw-lightbox-target="image"]')
    expect(images[0].classList.contains("hidden")).toBe(false)
    expect(images[2].classList.contains("hidden")).toBe(true)
  })
})
