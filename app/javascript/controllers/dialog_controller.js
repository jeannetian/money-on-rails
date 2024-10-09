import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    open: { type: Boolean, default: false }
  }

  connect() {
    if (this.openValue) {
      this.element.showModal()
    }
  }

  close() {
    this.element.close()
  }
}
