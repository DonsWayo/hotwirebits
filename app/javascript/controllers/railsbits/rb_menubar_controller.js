import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item", "submenu"]
  static values = { activeIndex: { type: Number, default: -1 } }

  connect() {
    this.handleKeydown = this.handleKeydown.bind(this)
    this.element.addEventListener("keydown", this.handleKeydown)
    this.handleOutsideClick = this.handleOutsideClick.bind(this)
    document.addEventListener("click", this.handleOutsideClick)
  }

  disconnect() {
    this.element.removeEventListener("keydown", this.handleKeydown)
    document.removeEventListener("click", this.handleOutsideClick)
  }

  activate(event) {
    const index = this.itemTargets.indexOf(event.currentTarget)
    this.setActive(index)
  }

  setActive(index) {
    this.activeIndexValue = index
    this.itemTargets.forEach((item, i) => {
      item.classList.toggle("active", i === index)
      item.setAttribute("tabindex", i === index ? "0" : "-1")
    })
    if (index >= 0) this.itemTargets[index].focus()
  }

  handleKeydown(event) {
    const items = this.itemTargets
    switch (event.key) {
      case "ArrowRight":
      case "ArrowDown":
        event.preventDefault()
        this.setActive((this.activeIndexValue + 1) % items.length)
        break
      case "ArrowLeft":
      case "ArrowUp":
        event.preventDefault()
        this.setActive((this.activeIndexValue - 1 + items.length) % items.length)
        break
      case "Home":
        event.preventDefault()
        this.setActive(0)
        break
      case "End":
        event.preventDefault()
        this.setActive(items.length - 1)
        break
      case "Enter":
      case " ":
        if (this.activeIndexValue >= 0) {
          event.preventDefault()
          items[this.activeIndexValue].click()
        }
        break
      case "Escape":
        this.setActive(-1)
        this.closeAllSubmenus()
        break
    }
  }

  closeAllSubmenus() {
    this.submenuTargets.forEach((s) => s.classList.add("hidden"))
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.setActive(-1)
      this.closeAllSubmenus()
    }
  }
}
