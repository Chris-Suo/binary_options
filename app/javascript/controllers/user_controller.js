import {Controller} from "@hotwired/stimulus";
import consumer from "channels/consumer";

export default class extends Controller {

  static values = {
    id: String
  }
  static targets = ['quota'];

  connect() {
    console.log("connecting channel: " + `UserChannel_${this.idValue}`)

    let channelName = `UserChannel`;
    this.subscription = consumer.subscriptions.create(
      {
        channel: channelName,
        id: this.idValue,
      },
      {
        connected: this._connected.bind(this),
        disconnected: this._disconnected.bind(this),
        received: this._received.bind(this),
      }
    );
  }

  _connected() {
    console.log("connected.")
  }

  _disconnected() {
  }

  _received(data) {
    this.quotaTarget.innerHTML = data.quota;
  }
}