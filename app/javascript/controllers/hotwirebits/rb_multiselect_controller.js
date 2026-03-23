import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown", "option", "tag", "input", "hidden"]
  static values = { selected: { type: Array, default: [] }, open: { type: Boolean, default: false } }

  connect() {
    this.handleOutsideClick = this.handleOutsideClick.bind(this)
    document.addEventListener("click", this.handleOutsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick)
  }

  toggle() {
    this.openValue ? this.close() : this.open()
  }

  open() {
    this.openValue = true
    this.dropdownTarget.classList.remove("hidden")
  }

  close() {
    this.openValue = false
    this.dropdownTarget.classList.add("hidden")
  }

  select(event) {
    const value = event.currentTarget.dataset.value
    if (!this.selectedValue.includes(value)) {
      this.selectedValue = [...this.selectedValue, value]
      event.currentTarget.classList.add("selected")
      this.syncHidden()
      this.renderTags()
    } else {
      this.deselect(value)
      event.currentTarget.classList.remove("selected")
    }
  }

  deselect(value) {
    this.selectedValue = this.selectedValue.filter((v) => v !== value)
    this.syncHidden()
    this.renderTags()
  }

  removeTag(event) {
    const value = event.params.value || event.currentTarget.dataset.value
    this.deselect(value)
    this.optionTargets.forEach((opt) => {
      if (opt.dataset.value === value) opt.classList.remove("selected")
    })
  }

  renderTags() {
    this.tagTargets.forEach((tag) => {
      const value = tag.dataset.value
      tag.classList.toggle("hidden", !this.selectedValue.includes(value))
    })
  }

  syncHidden() {
    if (!this.hasHiddenTarget) return
    this.hiddenTarget.innerHTML = ""
    this.selectedValue.forEach((value) => {
      const input = document.createElement("input")
      input.type = "hidden"
      input.name = this.hiddenTarget.dataset.name || "selected[]"
      input.value = value
      this.hiddenTarget.appendChild(input)
    })
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) this.close()
  }

  handleKeydown(event) {
    if (event.key === "Escape") this.close()
  }
}
