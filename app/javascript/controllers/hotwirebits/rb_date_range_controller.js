import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["start", "end"]
  static values = { startDate: { type: String, default: "" }, endDate: { type: String, default: "" } }

  selectStart(event) { this.startDateValue = event.currentTarget.dataset.date; this.dispatch("change", { detail: { start: this.startDateValue, end: this.endDateValue } }) }
  selectEnd(event) { this.endDateValue = event.currentTarget.dataset.date; this.dispatch("change", { detail: { start: this.startDateValue, end: this.endDateValue } }) }
}
