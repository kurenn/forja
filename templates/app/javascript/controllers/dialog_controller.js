import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dialog"
export default class extends Controller {
  static targets = ["backdrop", "container", "panel"]
  static values = {
    id: String
  }

  connect() {
    // Listen for custom events to open/close this specific dialog
    this.boundOpen = this.open.bind(this)
    this.boundClose = this.close.bind(this)

    document.addEventListener(`dialog:open:${this.idValue}`, this.boundOpen)
    document.addEventListener(`dialog:close:${this.idValue}`, this.boundClose)

    // Handle escape key
    this.boundHandleKeydown = this.handleKeydown.bind(this)
    document.addEventListener("keydown", this.boundHandleKeydown)
  }

  disconnect() {
    document.removeEventListener(`dialog:open:${this.idValue}`, this.boundOpen)
    document.removeEventListener(`dialog:close:${this.idValue}`, this.boundClose)
    document.removeEventListener("keydown", this.boundHandleKeydown)
    this.enableScroll()
  }

  open(event) {
    event?.preventDefault()

    if (this.hasBackdropTarget) {
      this.backdropTarget.classList.remove("hidden", "opacity-0")
    }

    if (this.hasContainerTarget) {
      this.containerTarget.classList.remove("hidden")
    }

    this.disableScroll()

    // Focus first focusable element in panel
    requestAnimationFrame(() => {
      if (this.hasPanelTarget) {
        const focusable = this.panelTarget.querySelector(
          'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
        )
        focusable?.focus()
      }
    })
  }

  close(event) {
    event?.preventDefault()

    if (this.hasBackdropTarget) {
      this.backdropTarget.classList.add("opacity-0")
    }

    // Wait for fade out animation
    setTimeout(() => {
      if (this.hasBackdropTarget) {
        this.backdropTarget.classList.add("hidden")
      }

      if (this.hasContainerTarget) {
        this.containerTarget.classList.add("hidden")
      }

      this.enableScroll()
    }, 100)
  }

  handleKeydown(event) {
    if (event.key === "Escape" && this.isOpen()) {
      this.close()
    }
  }

  isOpen() {
    return this.hasContainerTarget && !this.containerTarget.classList.contains("hidden")
  }

  disableScroll() {
    document.body.style.overflow = "hidden"
  }

  enableScroll() {
    document.body.style.overflow = ""
  }
}
