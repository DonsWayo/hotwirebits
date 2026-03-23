import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["column", "card"]

  connect() {
    this.draggedCard = null
    this.draggedCardGhost = null
    this.cardTargets.forEach((card) => {
      card.setAttribute("draggable", "true")
      card.addEventListener("dragstart", this.onDragStart.bind(this))
      card.addEventListener("dragend", this.onDragEnd.bind(this))
    })
    this.columnTargets.forEach((col) => {
      col.addEventListener("dragover", this.onDragOver.bind(this))
      col.addEventListener("drop", this.onDrop.bind(this))
      col.addEventListener("dragleave", this.onDragLeave.bind(this))
    })
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
      column.appendChild(this.draggedCard)
      this.dispatch("move", {
        detail: {
          cardId: this.draggedCard.dataset.id,
          fromColumn: this.draggedCard.parentElement.dataset.id,
          toColumn: column.dataset.id
        }
      })
    }
  }
}
