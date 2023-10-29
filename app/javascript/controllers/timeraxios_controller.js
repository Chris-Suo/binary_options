import {Controller} from "@hotwired/stimulus";
import axios from "src/axios";

let dateString = null;
let date = null;
let isSyncd = false;
let isCounting = false;
let timeoutId;

export default class extends Controller {
  static targets = ["input", "timer", "progress", "submit"];

  static values = {
    slug: String
  }


  async sync(event) {
    event.preventDefault();
    if (!isSyncd) {
      this.progressTarget.classList.remove("hidden");
      let url = "/sync_machine/" + this.slugValue;
      axios
        .get(url, {withCredentials: true})
        .then((resp) => {
          dateString = resp.data.time;
          date = new Date(dateString);

          // 移除前一個timer不然時間會跳很快
          if (timeoutId != null) {
            clearTimeout(timeoutId);
          }

          if (!isCounting) {
            this.counting();
            isCounting = true;
          }

          isSyncd = true;
        })
        .catch((error) => {
          console.error("Error:", error);
          isSyncd = false;
        });
    }
  }

  showTime() {
    if (isSyncd && dateString !== null) {
      let s = date.getSeconds(); // 0 - 59

      if (56 < s && s < 60) {
        this.timerTarget.classList.add("text-red-600");
        this.submitTarget.setAttribute('disabled', true);
      } else {
        this.timerTarget.classList.remove("text-red-600");
        this.submitTarget.removeAttribute("disabled");
      }

      let time = date.toLocaleTimeString();
      this.timerTarget.innerText = time;
      this.timerTarget.textContent = time;
      this.inputTarget.value = date.toISOString();
      this.progressTarget.classList.add("hidden");
    }
  }

  counting() {
    timeoutId = setTimeout(() => {
      if (dateString !== null) {
        this.showTime();
        date.setSeconds(date.getSeconds() + 1);
      }
      this.counting();
    }, 1000);
  }

  reset() {
    dateString = null;
    date = null;
    isSyncd = false;
    isCounting = false;
    this.timerTarget.classList.remove("text-red-600");
    this.submitTarget.removeAttribute("disabled");
    this.progressTarget.classList.add("hidden");
  }
}
