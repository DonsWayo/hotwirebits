import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "toggle", "meter", "label"]
  static values = { visible: { type: Boolean, default: false } }

  toggle() {
    this.visibleValue = !this.visibleValue
    this.inputTarget.type = this.visibleValue ? "text" : "password"
    if (this.hasToggleTarget) {
      this.toggleTarget.setAttribute("aria-pressed", this.visibleValue.toString())
    }
  }

  checkStrength() {
    const value = this.inputTarget.value
    let score = 0
    if (value.length >= 8) score++
    if (/[a-z]/.test(value) && /[A-Z]/.test(value)) score++
    if (/\d/.test(value)) score++
    if (/[^a-zA-Z0-9]/.test(value)) score++

    const levels = ["weak", "fair", "good", "strong"]
    const level = levels[Math.min(score, levels.length) - 1] || "none"

    if (this.hasMeterTarget) {
      this.meterTarget.className = `strength-meter strength-${level}`
      this.meterTarget.setAttribute("aria-valuenow", score.toString())
    }
    if (this.hasLabelTarget) {
      this.labelTarget.textContent = level
    }

    this.dispatch("strength", { detail: { level, score } })
  }
}
