import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  changePerPage(event) {
    this.dispatch("change", { detail: { perPage: event.target.value } })
  }
}
