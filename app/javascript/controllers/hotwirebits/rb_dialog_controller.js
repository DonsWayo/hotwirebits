import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "overlay"]
  static values = { open: { type: Boolean, default: false } }

  connect() {
    this.handleKeydown = this.handleKeydown.bind(this)
    this.element.addEventListener("keydown", this.handleKeydown)
  }

  disconnect() {
    this.element.removeEventListener("keydown", this.handleKeydown)
  }

  open() {
    this.openValue = true
    this.contentTarget.showModal()
    this.trapFocus()
  }

  close() {
    this.openValue = false
    this.contentTarget.close()
    this.releaseFocus()
  }

  handleKeydown(event) {
    if (event.key === "Escape" && this.openValue) {
      event.preventDefault()
      this.close()
    }
  }

  trapFocus() {
    const focusable = this.contentTarget.querySelectorAll(
      'a[href], button:not([disabled]), input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"])'
    )
    if (focusable.length) focusable[0].focus()
    this.firstFocusable = focusable[0]
    this.lastFocusable = focusable[focusable.length - 1]
  }

  releaseFocus() {
    const trigger = document.querySelector(`[data-action~="hw-dialog#open"]`)
    if (trigger) trigger.focus()
  }

  trap(event) {
    if (event.key !== "Tab") return
    if (event.shiftKey && document.activeElement === this.firstFocusable) {
      event.preventDefault()
      this.lastFocusable.focus()
    } else if (!event.shiftKey && document.activeElement === this.lastFocusable) {
      event.preventDefault()
      this.firstFocusable.focus()
    }
  }
}
