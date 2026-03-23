import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "calendar", "grid", "month", "year", "hidden"]
  static values = { date: { type: String, default: "" }, open: { type: Boolean, default: false }, month: Number, year: Number }

  connect() {
    const now = new Date()
    this.monthValue = this.monthValue ?? now.getMonth()
    this.yearValue = this.yearValue ?? now.getFullYear()
    this.selectedDate = this.dateValue ? new Date(this.dateValue) : null

    this.handleOutsideClick = this.handleOutsideClick.bind(this)
    document.addEventListener("click", this.handleOutsideClick)

    if (this.selectedDate && this.hasInputTarget) {
      this.inputTarget.value = this.formatDate(this.selectedDate)
    }
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick)
  }

  open() {
    this.openValue = true
    this.calendarTarget.classList.remove("hidden")
    this.render()
  }

  close() {
    this.openValue = false
    this.calendarTarget.classList.add("hidden")
  }

  toggle() {
    this.openValue ? this.close() : this.open()
  }

  prevMonth() {
    this.monthValue--
    if (this.monthValue < 0) { this.monthValue = 11; this.yearValue-- }
    this.render()
  }

  nextMonth() {
    this.monthValue++
    if (this.monthValue > 11) { this.monthValue = 0; this.yearValue++ }
    this.render()
  }

  selectDate(event) {
    const day = parseInt(event.currentTarget.dataset.day, 10)
    this.selectedDate = new Date(this.yearValue, this.monthValue, day)
    this.inputTarget.value = this.formatDate(this.selectedDate)
    if (this.hasHiddenTarget) this.hiddenTarget.value = this.selectedDate.toISOString().split("T")[0]
    this.close()
    this.dispatch("select", { detail: { date: this.selectedDate } })
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
      empty.className = "datepicker-day empty"
      this.gridTarget.appendChild(empty)
    }

    for (let d = 1; d <= daysInMonth; d++) {
      const cell = document.createElement("button")
      cell.type = "button"
      cell.className = "datepicker-day"
      cell.dataset.day = d
      cell.textContent = d

      const isToday = today.getDate() === d && today.getMonth() === this.monthValue && today.getFullYear() === this.yearValue
      const isSelected = this.selectedDate && this.selectedDate.getDate() === d && this.selectedDate.getMonth() === this.monthValue && this.selectedDate.getFullYear() === this.yearValue

      cell.classList.toggle("is-today", isToday)
      cell.classList.toggle("is-selected", isSelected)
      cell.setAttribute("data-action", "click->rb-datepicker#selectDate")
      this.gridTarget.appendChild(cell)
    }
  }

  formatDate(date) {
    return date.toISOString().split("T")[0]
  }

  handleOutsideClick(event) {
    if (!this.openValue) return
    if (!this.element.contains(event.target)) this.close()
  }

  handleKeydown(event) {
    if (event.key === "Escape") this.close()
  }
}
