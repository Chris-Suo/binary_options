import { Application } from "@hotwired/stimulus";
// import gtag from "src/analytics";
const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
