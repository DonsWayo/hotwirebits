import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]
  static values = { tags: { type: Array, default: [] } }

  add() {
    const val = this.inputTarget.value.trim()
    if (!val) return
    this.tagsValue = [...this.tagsValue, val]
    this.inputTarget.value = ""
    this.dispatch("change", { detail: { tags: this.tagsValue } })
  }

  remove(event) {
    this.tagsValue = this.tagsValue.filter(t => t !== event.currentTarget.dataset.tag)
    this.dispatch("change", { detail: { tags: this.tagsValue } })
  }
}
