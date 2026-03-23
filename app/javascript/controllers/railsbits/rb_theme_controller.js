import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle"]
  static values = { mode: { type: String, default: "" } }

  connect() {
    const stored = localStorage.getItem("rb-theme")
    const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches
    this.modeValue = stored || (prefersDark ? "dark" : "light")
    this.apply()

    this.mediaQuery = window.matchMedia("(prefers-color-scheme: dark)")
    this.handleSystemChange = this.handleSystemChange.bind(this)
    this.mediaQuery.addEventListener("change", this.handleSystemChange)
  }

  disconnect() {
    this.mediaQuery.removeEventListener("change", this.handleSystemChange)
  }

  toggle() {
    this.modeValue = this.modeValue === "dark" ? "light" : "dark"
    this.apply()
    localStorage.setItem("rb-theme", this.modeValue)
    this.dispatch("change", { detail: { mode: this.modeValue } })
  }

  set(event) {
    this.modeValue = event.params.mode || event.currentTarget.dataset.mode
    this.apply()
    localStorage.setItem("rb-theme", this.modeValue)
  }

  apply() {
    document.documentElement.setAttribute("data-theme", this.modeValue)
    document.documentElement.classList.toggle("dark", this.modeValue === "dark")
    document.documentElement.classList.toggle("light", this.modeValue === "light")
    this.hasToggleTarget && this.toggleTarget.setAttribute("aria-label", `Switch to ${this.modeValue === "dark" ? "light" : "dark"} mode`)
  }

  handleSystemChange(event) {
    if (!localStorage.getItem("rb-theme")) {
      this.modeValue = event.matches ? "dark" : "light"
      this.apply()
    }
  }
}
