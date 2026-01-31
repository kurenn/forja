import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar-layout"
export default class extends Controller {
  static targets = ["mobileSidebar", "panel"]

  connect() {
    // Handle escape key
    this.handleKeydown = this.handleKeydown.bind(this)
    document.addEventListener("keydown", this.handleKeydown)
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeydown)
    this.enableScroll()
  }

  open() {
    if (!this.hasMobileSidebarTarget) return

    this.mobileSidebarTarget.classList.remove("hidden")
    this.disableScroll()

    // Trigger animation after display change
    requestAnimationFrame(() => {
      if (this.hasPanelTarget) {
        this.panelTarget.classList.remove("-translate-x-full")
        this.panelTarget.classList.add("translate-x-0")
      }
    })
  }

  close() {
    if (!this.hasMobileSidebarTarget) return

    if (this.hasPanelTarget) {
      this.panelTarget.classList.remove("translate-x-0")
      this.panelTarget.classList.add("-translate-x-full")
    }

    // Wait for animation to complete before hiding
    setTimeout(() => {
      this.mobileSidebarTarget.classList.add("hidden")
      this.enableScroll()
    }, 300)
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }

  disableScroll() {
    document.body.style.overflow = "hidden"
  }

  enableScroll() {
    document.body.style.overflow = ""
  }
}
