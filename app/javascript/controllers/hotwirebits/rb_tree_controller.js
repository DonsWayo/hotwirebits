import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["node", "content", "toggle"]
  static values = { expanded: { type: Array, default: [] } }

  toggle(event) {
    event.preventDefault()
    const id = event.currentTarget.dataset.id || event.currentTarget.closest("[data-id]").dataset.id
    if (this.expandedValue.includes(id)) {
      this.expandedValue = this.expandedValue.filter((v) => v !== id)
    } else {
      this.expandedValue = [...this.expandedValue, id]
    }
    this.render()
    this.dispatch("toggle", { detail: { id, expanded: this.expandedValue.includes(id) } })
  }

  render() {
    this.nodeTargets.forEach((node) => {
      const id = node.dataset.id
      const isExpanded = this.expandedValue.includes(id)
      const content = node.querySelector("[data-hw-tree-target='content']")
      const toggle = node.querySelector("[data-hw-tree-target='toggle']")
      if (content) {
        content.classList.toggle("hidden", !isExpanded)
        content.setAttribute("aria-hidden", (!isExpanded).toString())
      }
      if (toggle) {
        toggle.setAttribute("aria-expanded", isExpanded.toString())
        toggle.classList.toggle("expanded", isExpanded)
      }
    })
  }

  expandAll() {
    this.expandedValue = this.nodeTargets.map((n) => n.dataset.id)
    this.render()
  }

  collapseAll() {
    this.expandedValue = []
    this.render()
  }

  handleKeydown(event) {
    const node = event.target.closest("[data-hw-tree-target='node']")
    if (!node) return
    if (event.key === "ArrowRight") {
      event.preventDefault()
      if (!this.expandedValue.includes(node.dataset.id)) this.toggle(event)
    }
    if (event.key === "ArrowLeft") {
      event.preventDefault()
      if (this.expandedValue.includes(node.dataset.id)) this.toggle(event)
    }
  }
}
