import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["banner", "modal", "settings"]
  static values = {
    accepted: { type: Boolean, default: false },
    key: { type: String, default: "hw-cookie-consent" },
    categories: { type: Array, default: ["essential"] }
  }

  connect() {
    const stored = localStorage.getItem(this.keyValue)
    if (stored) {
      this.acceptedValue = true
      this.bannerTarget?.classList.add("hidden")
    }
  }

  accept() {
    this.savePreferences(this.categoriesValue)
    this.bannerTarget?.classList.add("hidden")
  }

  acceptAll() {
    this.savePreferences([...this.categoriesValue, "analytics", "marketing"])
    this.bannerTarget?.classList.add("hidden")
  }

  reject() {
    this.savePreferences(["essential"])
    this.bannerTarget?.classList.add("hidden")
  }

  openSettings() {
    this.modalTarget?.classList.remove("hidden")
  }

  closeSettings() {
    this.modalTarget?.classList.add("hidden")
  }

  savePreferences(categories) {
    const prefs = { categories, timestamp: Date.now() }
    localStorage.setItem(this.keyValue, JSON.stringify(prefs))
    this.acceptedValue = true
    this.dispatch("accept", { detail: prefs })
  }

  get preferences() {
    const stored = localStorage.getItem(this.keyValue)
    return stored ? JSON.parse(stored) : null
  }

  revoke() {
    localStorage.removeItem(this.keyValue)
    this.acceptedValue = false
    this.bannerTarget?.classList.remove("hidden")
    this.dispatch("revoke")
  }
}
