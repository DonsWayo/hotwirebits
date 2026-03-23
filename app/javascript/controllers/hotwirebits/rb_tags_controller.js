import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "tag", "container"]
  static values = { tags: { type: Array, default: [] } }

  addTag() {
    const value = this.inputTarget.value.trim()
    if (!value || this.tagsValue.includes(value)) return
    this.tagsValue = [...this.tagsValue, value]
    this.inputTarget.value = ""
    this.render()
    this.dispatch("add", { detail: { value } })
  }

  removeTag(event) {
    const value = event.params.value || event.currentTarget.dataset.value
    this.tagsValue = this.tagsValue.filter((t) => t !== value)
    this.render()
    this.dispatch("remove", { detail: { value } })
  }

  handleKeydown(event) {
    if (event.key === "Enter") {
      event.preventDefault()
      this.addTag()
    }
    if (event.key === "Backspace" && !this.inputTarget.value && this.tagsValue.length) {
      this.tagsValue = this.tagsValue.slice(0, -1)
      this.render()
    }
  }

  render() {
    this.containerTarget.innerHTML = ""
    this.tagsValue.forEach((tag) => {
      const el = document.createElement("span")
      el.className = "tag-item"
      el.dataset.rbTagsTarget = "tag"
      el.innerHTML = `${this.escapeHtml(tag)}<button type="button" data-action="click->hw-tags#removeTag" data-hw-tags-value-param="${this.escapeHtml(tag)}" aria-label="Remove ${this.escapeHtml(tag)}">&times;</button>`
      this.containerTarget.appendChild(el)
    })
  }

  escapeHtml(text) {
    const div = document.createElement("div")
    div.textContent = text
    return div.innerHTML
  }
}
