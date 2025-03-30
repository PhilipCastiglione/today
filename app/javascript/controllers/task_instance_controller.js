import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "scheduleActions" ]

  toggle() {
    const scheduleActions = this.scheduleActionsTarget
    scheduleActions.classList.toggle('hidden')
  }
}
