import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "trigger"]
  static values = { open: { type: Boolean, default: false }, duration: { type: Number, default: 300 } }

  connect() {
    if (!this.openValue) this.contentTarget.classList.add("hidden")
  }

  toggle() {
    this.openValue = !this.openValue
    if (this.openValue) {
      this.show()
    } else {
      this.hide()
    }
  }

  show() {
    const el = this.contentTarget
    el.classList.remove("hidden")
    el.style.height = "0px"
    el.style.overflow = "hidden"
    el.style.transition = `height ${this.durationValue}ms ease`
    requestAnimationFrame(() => {
      el.style.height = `${el.scrollHeight}px`
    })
    setTimeout(() => {
      el.style.height = ""
      el.style.overflow = ""
    }, this.durationValue)
    this.triggerTarget.setAttribute("aria-expanded", "true")
  }

  hide() {
    const el = this.contentTarget
    el.style.height = `${el.scrollHeight}px`
    el.style.overflow = "hidden"
    el.style.transition = `height ${this.durationValue}ms ease`
    requestAnimationFrame(() => {
      el.style.height = "0px"
    })
    setTimeout(() => {
      el.classList.add("hidden")
      el.style.height = ""
      el.style.overflow = ""
    }, this.durationValue)
    this.triggerTarget.setAttribute("aria-expanded", "false")
  }
}
