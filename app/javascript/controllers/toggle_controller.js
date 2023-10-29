import {Controller} from "@hotwired/stimulus";
import {enter, leave, toggle} from "el-transition";

// let menuOpen = false;

export default class extends Controller {
  static targets = ["title", "submenu", "svgplus"];

  connect() {
    document.addEventListener("keydown", this.closeHandler.bind(this));
  }

  disconnect() {
    document.removeEventListener("keydown", this.closeHandler.bind(this));
  }

  // 按esc就是全關
  closeHandler(event) {
    if (event.keyCode === 27) {
      leave(this.submenuTarget);
      this.titleTarget.classList.remove("submenu__opened");
      this.svgplusTarget.classList.remove("text-white");
    }
  }

  // 這邊是點擊的時候 左側的選單列顯示/隱藏
  toggleMenu() {
    toggle(this.submenuTarget).then(() => {
      if (this.submenuTarget.classList.contains("hidden")) {
        this.removeDecorateTitle();
      } else {
        this.decorateTitle();
      }
    });
  }

  decorateTitle() {
    this.titleTarget.classList.add("submenu__opened");
    this.svgplusTarget.classList.add("text-white");
  }

  removeDecorateTitle() {
    this.titleTarget.classList.remove("submenu__opened");
    this.svgplusTarget.classList.remove("text-white");
  }
}
