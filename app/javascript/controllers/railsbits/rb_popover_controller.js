import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "trigger"]
  static values = { placement: { type: String, default: "bottom" }, open: { type: Boolean, default: false } }

  connect() {
    this.handleOutsideClick = this.handleOutsideClick.bind(this)
    this.handleKeydown = this.handleKeydown.bind(this)
    document.addEventListener("click", this.handleOutsideClick)
    document.addEventListener("keydown", this.handleKeydown)
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick)
    document.removeEventListener("keydown", this.handleKeydown)
  }

  toggle() {
    this.openValue ? this.close() : this.open()
  }

  open() {
    this.openValue = true
    this.contentTarget.classList.remove("hidden")
    this.positionContent()
    this.triggerTarget.setAttribute("aria-expanded", "true")
  }

  close() {
    this.openValue = false
    this.contentTarget.classList.add("hidden")
    this.triggerTarget.setAttribute("aria-expanded", "false")
  }

  positionContent() {
    const triggerRect = this.triggerTarget.getBoundingClientRect()
    const content = this.contentTarget
    const placements = {
      top: { top: triggerRect.top - content.offsetHeight - 8, left: triggerRect.left },
      bottom: { top: triggerRect.bottom + 8, left: triggerRect.left },
      left: { top: triggerRect.top, left: triggerRect.left - content.offsetWidth - 8 },
      right: { top: triggerRect.top, left: triggerRect.right + 8 }
    }
    const pos = placements[this.placementValue] || placements.bottom
    Object.assign(content.style, {
      position: "fixed",
      top: `${Math.max(0, pos.top)}px`,
      left: `${Math.max(0, pos.left)}px`
    })
  }

  handleOutsideClick(event) {
    if (!this.openValue) return
    if (!this.element.contains(event.target)) this.close()
  }

  handleKeydown(event) {
    if (event.key === "Escape" && this.openValue) this.close()
  }
}
