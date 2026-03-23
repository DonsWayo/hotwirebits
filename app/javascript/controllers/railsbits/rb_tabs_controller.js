import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]
  static values = { active: { type: Number, default: 0 } }

  connect() {
    this.showTab(this.activeValue)
  }

  select(event) {
    event.preventDefault()
    const index = this.tabTargets.indexOf(event.currentTarget)
    if (index >= 0) this.showTab(index)
  }

  showTab(index) {
    this.activeValue = index
    this.tabTargets.forEach((tab, i) => {
      const isActive = i === index
      tab.classList.toggle("active", isActive)
      tab.setAttribute("aria-selected", isActive.toString())
      tab.setAttribute("tabindex", isActive ? "0" : "-1")
    })
    this.panelTargets.forEach((panel, i) => {
      panel.classList.toggle("hidden", i !== index)
    })
  }

  nextTab() {
    const next = (this.activeValue + 1) % this.tabTargets.length
    this.showTab(next)
    this.tabTargets[next].focus()
  }

  prevTab() {
    const prev = (this.activeValue - 1 + this.tabTargets.length) % this.tabTargets.length
    this.showTab(prev)
    this.tabTargets[prev].focus()
  }

  handleKeydown(event) {
    if (event.key === "ArrowRight") this.nextTab()
    if (event.key === "ArrowLeft") this.prevTab()
  }
}
