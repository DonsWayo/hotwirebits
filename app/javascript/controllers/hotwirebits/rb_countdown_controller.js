import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["days", "hours", "minutes", "seconds", "bar"]
  static values = {
    end: { type: String, required: true },
    autoStart: { type: Boolean, default: true }
  }

  connect() {
    this.endDate = new Date(this.endValue).getTime()
    this.startDate = Date.now()
    this.rafId = null
    this.started = false
    if (this.autoStartValue) this.start()
  }

  disconnect() {
    this.stop()
  }

  start() {
    if (this.started) return
    this.started = true
    this.tick()
  }

  stop() {
    this.started = false
    if (this.rafId) cancelAnimationFrame(this.rafId)
  }

  tick() {
    if (!this.started) return
    const now = Date.now()
    const remaining = Math.max(0, this.endDate - now)
    const total = this.endDate - this.startDate

    const days = Math.floor(remaining / 86400000)
    const hours = Math.floor((remaining % 86400000) / 3600000)
    const minutes = Math.floor((remaining % 3600000) / 60000)
    const seconds = Math.floor((remaining % 60000) / 1000)

    if (this.hasDaysTarget) this.daysTarget.textContent = String(days).padStart(2, "0")
    if (this.hasHoursTarget) this.hoursTarget.textContent = String(hours).padStart(2, "0")
    if (this.hasMinutesTarget) this.minutesTarget.textContent = String(minutes).padStart(2, "0")
    if (this.hasSecondsTarget) this.secondsTarget.textContent = String(seconds).padStart(2, "0")
    if (this.hasBarTarget) {
      const progress = remaining / total
      this.barTarget.style.transform = `scaleX(${progress})`
    }

    if (remaining > 0) {
      this.rafId = requestAnimationFrame(() => this.tick())
    } else {
      this.started = false
      this.dispatch("complete")
    }
  }
}
