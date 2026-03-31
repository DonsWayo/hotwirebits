import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toast"]
  static values = {
    duration: { type: Number, default: 3000 },
    position: { type: String, default: "bottom-right" }
  }

  connect() {
    this._container = this.element.querySelector("[data-hw-toast-target='container']") || this.createContainer()
  }

  disconnect() {
    if (this._container && this._container.parentElement === document.body) {
      this._container.remove()
    }
    this._container = null
  }

  show(event) {
    const message = event?.params?.message || event?.detail?.message || this.element.dataset.rbToastMessage || "Toast"
    const toast = document.createElement("div")
    toast.className = "toast-item animate-slide-in"
    toast.setAttribute("role", "alert")
    toast.setAttribute("aria-live", "polite")
    toast.textContent = message
    this._container.appendChild(toast)
    setTimeout(() => this.dismiss(toast), this.durationValue)
  }

  dismiss(toast) {
    toast.classList.add("animate-slide-out")
    toast.addEventListener("animationend", () => toast.remove())
  }

  createContainer() {
    const div = document.createElement("div")
    div.className = `toast-container toast-${this.positionValue}`
    document.body.appendChild(div)
    return div
  }
}
