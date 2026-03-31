import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]
  static values = { min: { type: Number, default: 0 }, max: { type: Number, default: 100 }, step: { type: Number, default: 1 } }

  increment() { if (this.hasInputTarget) { this.inputTarget.value = Math.min(this.maxValue, (parseFloat(this.inputTarget.value) || 0) + this.stepValue); this.dispatch("change") } }
  decrement() { if (this.hasInputTarget) { this.inputTarget.value = Math.max(this.minValue, (parseFloat(this.inputTarget.value) || 0) - this.stepValue); this.dispatch("change") } }
}
