import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  select(event) {
    const value = event.currentTarget.dataset.value
    this.element.querySelectorAll("[data-action*='hw-toggle-group#select']").forEach(btn => {
      btn.setAttribute("aria-pressed", "false")
    })
    event.currentTarget.setAttribute("aria-pressed", "true")
    this.dispatch("select", { detail: { value } })
  }
}
