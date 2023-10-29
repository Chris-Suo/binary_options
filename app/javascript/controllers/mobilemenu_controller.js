import {Controller} from "@hotwired/stimulus";
import {enter, leave, toggle} from "el-transition";
import {useClickOutside} from "stimulus-use";

let menuOpen = false;

export default class extends Controller {
  static targets = [
    "menudiv",
    "backdrop",
    "backdropz",
    "closeButton",
    "openButton",
  ];

  connect() {
    document.addEventListener("keydown", this.closeHandler.bind(this));
  }

  disconnect() {
    document.removeEventListener("keydown", this.closeHandler.bind(this));
  }

  // 按esc就是全關
  closeHandler(event) {
    if (event.keyCode === 27) {
      leave(this.menudivTarget);
      leave(this.backdropTarget);
      leave(this.backdropzTarget);
      leave(this.closeButtonTarget);
      menuOpen = false;
    }
  }

  showMenu() {
    enter(this.menudivTarget);
    enter(this.backdropTarget);
    enter(this.backdropzTarget);
    enter(this.closeButtonTarget);
    menuOpen = true;
  }

  closeMenu() {
    leave(this.menudivTarget);
    leave(this.backdropTarget);
    leave(this.backdropzTarget);
    leave(this.closeButtonTarget);
    menuOpen = false;
  }

  toggleMenu() {
    toggle(this.menudivTarget);
    toggle(this.backdropTarget);
    toggle(this.backdropzTarget);
    toggle(this.closeButtonTarget);
    menuOpen = !menuOpen;
  }
}
