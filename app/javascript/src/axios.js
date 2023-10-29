import axios from "axios";

const instance = axios.create({
  // baseURL: "http://localhost:3000",
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
  },
  xsrfCookieName: "CSRF-TOKEN",
  xsrfHeaderName: "X-CSRF-Token",
  withCredentials: true,
});

instance.interceptors.request.use(
  function (config) {
    config.headers["X-CSRF-Token"] = document.getElementsByName("csrf-token")[0].content;
    return config;
  },
  function (error) {
    // Do something with request error
    return Promise.reject(error);
  }
);

export default instance;
