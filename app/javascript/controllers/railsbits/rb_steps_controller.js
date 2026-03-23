import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step", "connector"]
  static values = { current: { type: Number, default: 0 } }

  connect() {
    this.render()
  }

  next() {
    if (this.currentValue < this.stepTargets.length - 1) {
      this.currentValue++
      this.render()
      this.dispatch("change", { detail: { index: this.currentValue } })
    }
  }

  prev() {
    if (this.currentValue > 0) {
      this.currentValue--
      this.render()
      this.dispatch("change", { detail: { index: this.currentValue } })
    }
  }

  goTo(event) {
    const index = parseInt(event.currentTarget.dataset.index || event.params.index, 10)
    this.currentValue = index
    this.render()
    this.dispatch("change", { detail: { index } })
  }

  render() {
    this.stepTargets.forEach((step, i) => {
      step.classList.toggle("step-active", i === this.currentValue)
      step.classList.toggle("step-completed", i < this.currentValue)
      step.classList.toggle("step-pending", i > this.currentValue)
      step.setAttribute("aria-current", i === this.currentValue ? "step" : "false")
    })
    this.connectorTargets.forEach((connector, i) => {
      connector.classList.toggle("connector-done", i < this.currentValue)
    })
  }
}
