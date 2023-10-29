import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
  static values = {url: String};
  static targets = ["label"];

  connect() {
    // this.element.textContent = "Hello World!";
    // this.labelTargets.forEach((el, i) => {
    //   console.log(el.value);
    // });
  }

  initialize() {
  }

  deactive() {
    this.labelTargets.forEach((el, i) => {
      el.classList.remove(
        "ring-2",
        "ring-offset-2",
        "ring-indigo-500",
        "bg-indigo-600",
        "border-transparent",
        "text-white",
        "hover:bg-indigo-700"
      );
    });
  }

  changeOption(ev) {
    this.deactive();
    // console.log(ev.target.value);
    // console.log(ev.params);

    if (ev.target.parentElement) {
      ev.target.parentElement.classList.add(
        "ring-2",
        "ring-offset-2",
        "ring-indigo-500",
        "bg-indigo-600",
        "border-transparent",
        "text-white",
        "hover:bg-indigo-700"
      );
    }
  }
}
