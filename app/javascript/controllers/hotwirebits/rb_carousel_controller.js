import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["track", "slide", "prev", "next", "dots", "dot"]
  static values = {
    index: { type: Number, default: 0 },
    autoplay: { type: Boolean, default: false },
    interval: { type: Number, default: 5000 },
    loop: { type: Boolean, default: true }
  }

  connect() {
    if (this.autoplayValue) this.startAutoplay()
    this.render()
  }

  disconnect() {
    this.stopAutoplay()
  }

  next() {
    const max = this.slideTargets.length - 1
    if (this.indexValue < max) {
      this.indexValue++
    } else if (this.loopValue) {
      this.indexValue = 0
    }
    this.render()
  }

  prev() {
    if (this.indexValue > 0) {
      this.indexValue--
    } else if (this.loopValue) {
      this.indexValue = this.slideTargets.length - 1
    }
    this.render()
  }

  goTo(event) {
    const index = parseInt(event.currentTarget.dataset.index || event.params.index, 10)
    this.indexValue = index
    this.render()
  }

  render() {
    this.slideTargets.forEach((slide, i) => {
      slide.classList.toggle("hidden", i !== this.indexValue)
      slide.setAttribute("aria-hidden", (i !== this.indexValue).toString())
    })
    this.dotTargets.forEach((dot, i) => {
      dot.classList.toggle("active", i === this.indexValue)
      dot.setAttribute("aria-selected", (i === this.indexValue).toString())
    })
    if (this.hasPrevTarget) this.prevTarget.disabled = !this.loopValue && this.indexValue === 0
    if (this.hasNextTarget) this.nextTarget.disabled = !this.loopValue && this.indexValue === this.slideTargets.length - 1
  }

  startAutoplay() {
    this.intervalId = setInterval(() => this.next(), this.intervalValue)
  }

  stopAutoplay() {
    if (this.intervalId) clearInterval(this.intervalId)
  }

  pauseAutoplay() {
    this.stopAutoplay()
  }

  resumeAutoplay() {
    if (this.autoplayValue) this.startAutoplay()
  }
}
