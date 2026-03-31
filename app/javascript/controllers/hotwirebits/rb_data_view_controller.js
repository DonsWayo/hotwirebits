import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { view: { type: String, default: "grid" } }

  switch(event) {
    this.viewValue = event.currentTarget.dataset.view
    this.dispatch("switch", { detail: { view: this.viewValue } })
  }
}
