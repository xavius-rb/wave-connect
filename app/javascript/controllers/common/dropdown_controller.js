import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.boundCloseMenu = this.closeMenuIfClickedOutside.bind(this)
    document.addEventListener('click', this.boundCloseMenu)
  }

  toggleMenu(event) {
    event.stopPropagation() // Prevent click from bubbling up
    this.menuTarget.classList.toggle('hidden')
  }

  closeMenuIfClickedOutside(event) {
    if (!this.element.contains(event.target) && !this.menuTarget.classList.contains('hidden')) {
      this.menuTarget.classList.add('hidden')
    }
  }

  disconnect() {
    document.removeEventListener('click', this.boundCloseMenu)
  }
}
