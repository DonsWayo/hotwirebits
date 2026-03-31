import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "image"]
  static values = { index: { type: Number, default: 0 } }

  open(event) {
    this.indexValue = parseInt(event.currentTarget.dataset.index || 0, 10)
    if (this.hasOverlayTarget) this.overlayTarget.classList.remove("hidden")
    this.render()
  }

  close() {
    if (this.hasOverlayTarget) this.overlayTarget.classList.add("hidden")
  }

  next() {
    if (this.hasImageTarget) {
      this.indexValue = (this.indexValue + 1) % this.imageTargets.length
      this.render()
    }
  }

  prev() {
    if (this.hasImageTarget) {
      this.indexValue = (this.indexValue - 1 + this.imageTargets.length) % this.imageTargets.length
      this.render()
    }
  }

  render() {
    if (this.hasImageTarget) {
      this.imageTargets.forEach((img, i) => img.classList.toggle("hidden", i !== this.indexValue))
    }
  }
}
