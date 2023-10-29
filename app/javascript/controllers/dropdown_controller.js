import {Controller} from "@hotwired/stimulus";
import {enter, leave, toggle} from "el-transition";

let optionsOpen = false;

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["label", "button", "options"];

  connect() {
    document.addEventListener("keydown", this.closeHandler.bind(this));
  }

  disconnect() {
    document.removeEventListener("keydown", this.closeHandler.bind(this));
  }

  // 按esc就是全關
  closeHandler(event) {
    if (event.keyCode === 27) {
      leave(this.optionsTarget);
    }
  }

  toggleOptions() {
    toggle(this.optionsTarget);
    optionsOpen = !optionsOpen;
  }

  clickLabel(event) {
    this.buttonTarget.focus();
    this.toggleOptions();
  }

  clickButton(event) {
    this.buttonTarget.focus();
    this.toggleOptions();
  }
}
