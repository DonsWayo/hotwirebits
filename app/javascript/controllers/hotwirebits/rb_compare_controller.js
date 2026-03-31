import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["before", "after", "slider"]
  static values = { position: { type: Number, default: 50 } }

  drag(event) {
    const rect = this.element.getBoundingClientRect()
    const x = (event.touches ? event.touches[0].clientX : event.clientX) - rect.left
    this.positionValue = Math.max(0, Math.min(100, (x / rect.width) * 100))
    this.render()
  }

  render() {
    if (this.hasSliderTarget) this.sliderTarget.style.left = `${this.positionValue}%`
    if (this.hasBeforeTarget) this.beforeTarget.style.clipPath = `inset(0 ${100 - this.positionValue}% 0 0)`
  }
}
