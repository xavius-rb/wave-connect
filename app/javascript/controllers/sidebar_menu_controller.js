import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menuButton", "sidebar"]

  toggleSidebar() {
    this.sidebarTarget.classList.toggle("hidden")
  }
}
