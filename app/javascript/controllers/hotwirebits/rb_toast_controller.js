import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toast", "container"]
  static values = {
    duration: { type: Number, default: 3000 },
    position: { type: String, default: "bottom-right" }
  }

  connect() {
    if (!this.hasContainerTarget) {
      this.containerTarget = this.createContainer()
    }
  }

  show(event) {
    const message = event?.params?.message || event?.detail?.message || this.element.dataset.rbToastMessage || "Toast"
    const toast = document.createElement("div")
    toast.className = "toast-item animate-slide-in"
    toast.setAttribute("role", "alert")
    toast.setAttribute("aria-live", "polite")
    toast.textContent = message
    this.containerTarget.appendChild(toast)
    setTimeout(() => this.dismiss(toast), this.durationValue)
  }

  dismiss(toast) {
    toast.classList.add("animate-slide-out")
    toast.addEventListener("animationend", () => toast.remove())
  }

  createContainer() {
    const div = document.createElement("div")
    div.className = `toast-container toast-${this.positionValue}`
    div.setAttribute("data-hw-toast-target", "container")
    document.body.appendChild(div)
    return div
  }
}
