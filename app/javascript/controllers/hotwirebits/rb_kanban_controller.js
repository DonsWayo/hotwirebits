import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["column", "card"]

  connect() {
    this.draggedCard = null
    this._onDragStart = this.onDragStart.bind(this)
    this._onDragEnd = this.onDragEnd.bind(this)
    this._onDragOver = this.onDragOver.bind(this)
    this._onDrop = this.onDrop.bind(this)
    this._onDragLeave = this.onDragLeave.bind(this)

    this.cardTargets.forEach((card) => {
      card.setAttribute("draggable", "true")
      card.addEventListener("dragstart", this._onDragStart)
      card.addEventListener("dragend", this._onDragEnd)
    })
    this.columnTargets.forEach((col) => {
      col.addEventListener("dragover", this._onDragOver)
      col.addEventListener("drop", this._onDrop)
      col.addEventListener("dragleave", this._onDragLeave)
    })
  }

  disconnect() {
    this.cardTargets.forEach((card) => {
      card.removeEventListener("dragstart", this._onDragStart)
      card.removeEventListener("dragend", this._onDragEnd)
    })
    this.columnTargets.forEach((col) => {
      col.removeEventListener("dragover", this._onDragOver)
      col.removeEventListener("drop", this._onDrop)
      col.removeEventListener("dragleave", this._onDragLeave)
    })
    this.draggedCard = null
  }

  onDragStart(event) {
    this.draggedCard = event.target
    event.target.classList.add("dragging")
    event.dataTransfer.effectAllowed = "move"
    event.dataTransfer.setData("text/plain", event.target.dataset.id || "")
  }

  onDragEnd(event) {
    event.target.classList.remove("dragging")
    this.columnTargets.forEach((col) => col.classList.remove("drag-over"))
    this.draggedCard = null
  }

  onDragOver(event) {
    event.preventDefault()
    event.dataTransfer.dropEffect = "move"
    event.currentTarget.classList.add("drag-over")
  }

  onDragLeave(event) {
    event.currentTarget.classList.remove("drag-over")
  }

  onDrop(event) {
    event.preventDefault()
    const column = event.currentTarget
    column.classList.remove("drag-over")
    if (this.draggedCard) {
      const fromColumn = this.draggedCard.parentElement?.dataset.id
      column.appendChild(this.draggedCard)
      this.dispatch("move", {
        detail: {
          cardId: this.draggedCard.dataset.id,
          fromColumn: fromColumn,
          toColumn: column.dataset.id
        }
      })
    }
  }
}
