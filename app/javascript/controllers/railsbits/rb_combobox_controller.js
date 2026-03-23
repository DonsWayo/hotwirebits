import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list", "option", "hidden"]
  static values = { open: { type: Boolean, default: false } }

  connect() {
    this.activeIndex = -1
    this.handleOutsideClick = this.handleOutsideClick.bind(this)
    document.addEventListener("click", this.handleOutsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick)
  }

  filter() {
    const query = this.inputTarget.value.toLowerCase()
    this.open()
    this.optionTargets.forEach((opt) => {
      const text = opt.textContent.toLowerCase()
      opt.classList.toggle("hidden", !text.includes(query))
    })
    this.activeIndex = -1
  }

  open() {
    this.openValue = true
    this.listTarget.classList.remove("hidden")
  }

  close() {
    this.openValue = false
    this.listTarget.classList.add("hidden")
    this.activeIndex = -1
  }

  select(event) {
    const value = event.currentTarget.dataset.value
    const label = event.currentTarget.textContent.trim()
    this.inputTarget.value = label
    if (this.hasHiddenTarget) this.hiddenTarget.value = value
    this.close()
    this.dispatch("select", { detail: { value, label } })
  }

  handleKeydown(event) {
    const visible = this.visibleOptions
    switch (event.key) {
      case "ArrowDown":
        event.preventDefault()
        this.activeIndex = Math.min(this.activeIndex + 1, visible.length - 1)
        this.highlightActive(visible)
        break
      case "ArrowUp":
        event.preventDefault()
        this.activeIndex = Math.max(this.activeIndex - 1, 0)
        this.highlightActive(visible)
        break
      case "Enter":
        event.preventDefault()
        if (this.activeIndex >= 0 && visible[this.activeIndex]) {
          visible[this.activeIndex].click()
        }
        break
      case "Escape":
        this.close()
        this.inputTarget.focus()
        break
    }
  }

  get visibleOptions() {
    return this.optionTargets.filter((el) => !el.classList.contains("hidden"))
  }

  highlightActive(visible) {
    this.optionTargets.forEach((el) => el.classList.remove("active"))
    if (visible[this.activeIndex]) {
      visible[this.activeIndex].classList.add("active")
      visible[this.activeIndex].scrollIntoView({ block: "nearest" })
    }
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) this.close()
  }
}
