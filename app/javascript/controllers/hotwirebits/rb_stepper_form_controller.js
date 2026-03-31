import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step"]
  static values = { current: { type: Number, default: 0 } }

  next() { if (this.currentValue < this.stepTargets.length - 1) { this.currentValue++; this.render(); this.dispatch("change") } }
  prev() { if (this.currentValue > 0) { this.currentValue--; this.render(); this.dispatch("change") } }
  goTo(event) { this.currentValue = parseInt(event.currentTarget.dataset.step, 10); this.render(); this.dispatch("change") }
  render() { this.stepTargets.forEach((s, i) => s.classList.toggle("hidden", i !== this.currentValue)) }
}
