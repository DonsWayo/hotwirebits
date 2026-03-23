import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["track", "content"]
  static values = {
    speed: { type: Number, default: 50 },
    direction: { type: String, default: "left" },
    pauseOnHover: { type: Boolean, default: true }
  }

  connect() {
    this.animating = true
    this.position = 0
    this.lastTime = null
    this.animate = this.animate.bind(this)
    this.setup()
    requestAnimationFrame(this.animate)

    if (this.pauseOnHoverValue) {
      this.element.addEventListener("mouseenter", () => { this.animating = false })
      this.element.addEventListener("mouseleave", () => {
        this.animating = true
        this.lastTime = null
        requestAnimationFrame(this.animate)
      })
    }
  }

  disconnect() {
    this.animating = false
  }

  setup() {
    if (!this.hasTrackTarget) return
    const children = Array.from(this.trackTarget.children)
    if (children.length === 1) {
      const clone = children[0].cloneNode(true)
      clone.setAttribute("aria-hidden", "true")
      this.trackTarget.appendChild(clone)
    }
  }

  animate(time) {
    if (!this.animating) return
    if (this.lastTime === null) this.lastTime = time
    const delta = time - this.lastTime
    this.lastTime = time

    const direction = this.directionValue === "left" ? -1 : 1
    this.position += (this.speedValue * delta / 1000) * direction

    const trackWidth = this.trackTarget.scrollWidth / 2
    if (direction === -1 && Math.abs(this.position) >= trackWidth) {
      this.position += trackWidth
    } else if (direction === 1 && this.position >= 0) {
      this.position -= trackWidth
    }

    this.trackTarget.style.transform = `translateX(${this.position}px)`
    requestAnimationFrame(this.animate)
  }
}
