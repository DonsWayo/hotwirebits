import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results", "suggestion"]
  static values = { url: { type: String, default: "" }, delay: { type: Number, default: 300 } }

  connect() {
    this.timeout = null
    this.handleOutsideClick = this.handleOutsideClick.bind(this)
    document.addEventListener("click", this.handleOutsideClick)
  }

  disconnect() {
    clearTimeout(this.timeout)
    document.removeEventListener("click", this.handleOutsideClick)
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => this.performSearch(), this.delayValue)
  }

  async performSearch() {
    const query = this.inputTarget.value.trim()
    if (!query) {
      this.hideResults()
      return
    }

    if (this.urlValue) {
      try {
        const params = new URLSearchParams({ q: query })
        const response = await fetch(`${this.urlValue}?${params}`)
        const html = await response.text()
        this.resultsTarget.innerHTML = html
        this.showResults()
      } catch (e) {
        this.dispatch("error", { detail: { error: e } })
      }
    } else {
      this.dispatch("search", { detail: { query } })
    }
  }

  selectSuggestion(event) {
    const value = event.currentTarget.dataset.value || event.currentTarget.textContent.trim()
    this.inputTarget.value = value
    this.hideResults()
    this.dispatch("select", { detail: { value } })
  }

  showResults() {
    this.resultsTarget.classList.remove("hidden")
  }

  hideResults() {
    this.resultsTarget.classList.add("hidden")
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      this.hideResults()
      this.inputTarget.focus()
    }
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) this.hideResults()
  }
}
