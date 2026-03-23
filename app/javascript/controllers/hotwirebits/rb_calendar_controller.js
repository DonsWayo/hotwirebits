import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["month", "year", "grid", "prevMonth", "nextMonth", "selected"]
  static values = {
    date: { type: String, default: "" },
    month: { type: Number },
    year: { type: Number }
  }

  connect() {
    const now = new Date()
    this.monthValue = this.monthValue ?? now.getMonth()
    this.yearValue = this.yearValue ?? now.getFullYear()
    this.selectedDate = this.dateValue ? new Date(this.dateValue) : null
    this.render()
  }

  prevMonth() {
    this.monthValue--
    if (this.monthValue < 0) {
      this.monthValue = 11
      this.yearValue--
    }
    this.render()
  }

  nextMonth() {
    this.monthValue++
    if (this.monthValue > 11) {
      this.monthValue = 0
      this.yearValue++
    }
    this.render()
  }

  selectDate(event) {
    const day = parseInt(event.currentTarget.dataset.day, 10)
    this.selectedDate = new Date(this.yearValue, this.monthValue, day)
    this.render()
    this.dispatch("select", {
      detail: {
        date: this.selectedDate.toISOString().split("T")[0],
        day: this.selectedDate.getDate(),
        month: this.selectedDate.getMonth(),
        year: this.selectedDate.getFullYear()
      }
    })
  }

  render() {
    const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    if (this.hasMonthTarget) this.monthTarget.textContent = months[this.monthValue]
    if (this.hasYearTarget) this.yearTarget.textContent = this.yearValue
    if (!this.hasGridTarget) return

    this.gridTarget.innerHTML = ""
    const firstDay = new Date(this.yearValue, this.monthValue, 1).getDay()
    const daysInMonth = new Date(this.yearValue, this.monthValue + 1, 0).getDate()
    const today = new Date()

    for (let i = 0; i < firstDay; i++) {
      const empty = document.createElement("div")
      empty.className = "calendar-day empty"
      this.gridTarget.appendChild(empty)
    }

    for (let d = 1; d <= daysInMonth; d++) {
      const cell = document.createElement("button")
      cell.type = "button"
      cell.className = "calendar-day"
      cell.dataset.day = d
      cell.textContent = d

      const isToday = today.getDate() === d && today.getMonth() === this.monthValue && today.getFullYear() === this.yearValue
      const isSelected = this.selectedDate && this.selectedDate.getDate() === d && this.selectedDate.getMonth() === this.monthValue && this.selectedDate.getFullYear() === this.yearValue

      cell.classList.toggle("is-today", isToday)
      cell.classList.toggle("is-selected", isSelected)
      cell.setAttribute("aria-selected", isSelected.toString())
      cell.setAttribute("data-action", "click->hw-calendar#selectDate")
      this.gridTarget.appendChild(cell)
    }
  }
}
