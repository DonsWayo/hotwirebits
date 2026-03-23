import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["star"]
  static values = { rating: { type: Number, default: 0 }, readonly: { type: Boolean, default: false } }

  connect() {
    this.render()
  }

  select(event) {
    if (this.readonlyValue) return
    const value = parseInt(event.currentTarget.dataset.value, 10)
    this.ratingValue = value
    this.render()
    this.dispatch("change", { detail: { rating: value } })
  }

  hover(event) {
    if (this.readonlyValue) return
    const value = parseInt(event.currentTarget.dataset.value, 10)
    this.starTargets.forEach((star, i) => {
      star.classList.toggle("star-filled", i < value)
      star.classList.toggle("star-empty", i >= value)
    })
  }

  unhover() {
    if (this.readonlyValue) return
    this.render()
  }

  render() {
    this.starTargets.forEach((star, i) => {
      star.classList.toggle("star-filled", i < this.ratingValue)
      star.classList.toggle("star-empty", i >= this.ratingValue)
      star.setAttribute("aria-checked", (i === this.ratingValue - 1).toString())
    })
    this.element.setAttribute("aria-valuenow", this.ratingValue.toString())
  }

  handleKeydown(event) {
    if (this.readonlyValue) return
    if (event.key === "ArrowRight" || event.key === "ArrowUp") {
      event.preventDefault()
      this.ratingValue = Math.min(this.ratingValue + 1, this.starTargets.length)
      this.render()
    }
    if (event.key === "ArrowLeft" || event.key === "ArrowDown") {
      event.preventDefault()
      this.ratingValue = Math.max(this.ratingValue - 1, 0)
      this.render()
    }
  }
}
