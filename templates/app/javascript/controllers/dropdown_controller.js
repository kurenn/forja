import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["button", "menu"]

  connect() {
    // Handle clicks outside to close
    this.boundHandleClickOutside = this.handleClickOutside.bind(this)
    document.addEventListener("click", this.boundHandleClickOutside)

    // Handle escape key
    this.boundHandleKeydown = this.handleKeydown.bind(this)
    document.addEventListener("keydown", this.boundHandleKeydown)
  }

  disconnect() {
    document.removeEventListener("click", this.boundHandleClickOutside)
    document.removeEventListener("keydown", this.boundHandleKeydown)
  }

  toggle(event) {
    event.preventDefault()
    event.stopPropagation()

    if (this.isOpen()) {
      this.close()
    } else {
      this.open()
    }
  }

  open() {
    if (!this.hasMenuTarget) return

    this.menuTarget.classList.remove("hidden")

    if (this.hasButtonTarget) {
      this.buttonTarget.setAttribute("aria-expanded", "true")
    }

    // Focus first menu item
    requestAnimationFrame(() => {
      const firstItem = this.menuTarget.querySelector('[role="menuitem"]:not([disabled])')
      firstItem?.focus()
    })
  }

  close() {
    if (!this.hasMenuTarget) return

    this.menuTarget.classList.add("hidden")

    if (this.hasButtonTarget) {
      this.buttonTarget.setAttribute("aria-expanded", "false")
    }
  }

  closeOnSelect() {
    this.close()
  }

  isOpen() {
    return this.hasMenuTarget && !this.menuTarget.classList.contains("hidden")
  }

  handleClickOutside(event) {
    if (this.isOpen() && !this.element.contains(event.target)) {
      this.close()
    }
  }

  handleKeydown(event) {
    if (!this.isOpen()) return

    switch (event.key) {
      case "Escape":
        this.close()
        this.buttonTarget?.focus()
        break
      case "ArrowDown":
        event.preventDefault()
        this.focusNextItem()
        break
      case "ArrowUp":
        event.preventDefault()
        this.focusPreviousItem()
        break
      case "Home":
        event.preventDefault()
        this.focusFirstItem()
        break
      case "End":
        event.preventDefault()
        this.focusLastItem()
        break
    }
  }

  get menuItems() {
    if (!this.hasMenuTarget) return []
    return Array.from(this.menuTarget.querySelectorAll('[role="menuitem"]:not([disabled])'))
  }

  get currentIndex() {
    return this.menuItems.indexOf(document.activeElement)
  }

  focusNextItem() {
    const items = this.menuItems
    if (items.length === 0) return

    const nextIndex = this.currentIndex < items.length - 1 ? this.currentIndex + 1 : 0
    items[nextIndex]?.focus()
  }

  focusPreviousItem() {
    const items = this.menuItems
    if (items.length === 0) return

    const prevIndex = this.currentIndex > 0 ? this.currentIndex - 1 : items.length - 1
    items[prevIndex]?.focus()
  }

  focusFirstItem() {
    this.menuItems[0]?.focus()
  }

  focusLastItem() {
    const items = this.menuItems
    items[items.length - 1]?.focus()
  }
}
