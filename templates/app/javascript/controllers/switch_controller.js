import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="switch"
export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.updateAriaState()
  }

  toggle() {
    this.updateAriaState()
  }

  updateAriaState() {
    if (this.hasInputTarget) {
      this.inputTarget.setAttribute("aria-checked", this.inputTarget.checked.toString())
    }
  }
}
