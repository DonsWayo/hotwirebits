import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["actions", "action", "trigger"]
  static values = { open: { type: Boolean, default: false } }

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
    this.openValue = !this.openValue
    this.render()
  }

  open() {
    this.openValue = true
    this.render()
  }

  close() {
    this.openValue = false
    this.render()
  }

  render() {
    this.actionsTarget.classList.toggle("hidden", !this.openValue)
    if (this.hasTriggerTarget) {
      this.triggerTarget.setAttribute("aria-expanded", this.openValue.toString())
    }
    if (this.openValue && this.actionTargets.length) {
      this.actionTargets[0].focus()
    }
  }

  handleOutsideClick(event) {
    if (!this.openValue) return
    if (!this.element.contains(event.target)) this.close()
  }

  handleKeydown(event) {
    if (event.key === "Escape" && this.openValue) this.close()
    if (event.key === "ArrowDown" && this.openValue) {
      event.preventDefault()
      const items = this.actionTargets
      const index = items.indexOf(document.activeElement)
      if (index < items.length - 1) items[index + 1].focus()
    }
    if (event.key === "ArrowUp" && this.openValue) {
      event.preventDefault()
      const items = this.actionTargets
      const index = items.indexOf(document.activeElement)
      if (index > 0) items[index - 1].focus()
    }
  }
}
