import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "trigger"]
  static values = { open: { type: Boolean, default: false } }

  connect() {
    this._beforeCache = () => { if (this.hasMenuTarget) this.menuTarget.classList.add("hidden") }
    document.addEventListener("turbo:before-cache", this._beforeCache)
    this.handleOutsideClick = this.handleOutsideClick.bind(this)
    this.handleKeydown = this.handleKeydown.bind(this)
    document.addEventListener("click", this.handleOutsideClick)
    document.addEventListener("keydown", this.handleKeydown)
  }

  disconnect() {
    document.removeEventListener("turbo:before-cache", this._beforeCache)
    this._beforeCache = () => { if (this.hasMenuTarget) this.menuTarget.classList.add("hidden") }
    document.addEventListener("turbo:before-cache", this._beforeCache)
    document.removeEventListener("click", this.handleOutsideClick)
    document.removeEventListener("keydown", this.handleKeydown)
  }

  toggle() {
    this.openValue ? this.close() : this.open()
  }

  open() {
    this.openValue = true
    this.menuTarget.classList.remove("hidden")
    this.triggerTarget.setAttribute("aria-expanded", "true")
  }

  close() {
    this.openValue = false
    this.menuTarget.classList.add("hidden")
    this.triggerTarget.setAttribute("aria-expanded", "false")
  }

  handleOutsideClick(event) {
    if (!this.openValue) return
    if (!this.element.contains(event.target)) this.close()
  }

  handleKeydown(event) {
    if (!this.openValue) return
    if (event.key === "Escape") {
      this.close()
      this.triggerTarget.focus()
    }
    if (event.key === "ArrowDown") {
      event.preventDefault()
      const items = this.menuTarget.querySelectorAll('[role="menuitem"]')
      if (items.length) items[0].focus()
    }
  }

  focusNext(event) {
    const items = Array.from(this.menuTarget.querySelectorAll('[role="menuitem"]'))
    const index = items.indexOf(document.activeElement)
    if (index < items.length - 1) {
      event.preventDefault()
      items[index + 1].focus()
    }
  }

  focusPrev(event) {
    const items = Array.from(this.menuTarget.querySelectorAll('[role="menuitem"]'))
    const index = items.indexOf(document.activeElement)
    if (index > 0) {
      event.preventDefault()
      items[index - 1].focus()
    }
  }
}
