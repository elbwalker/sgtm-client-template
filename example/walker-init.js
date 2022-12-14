/*
  -------------------------------------------------------------
  EXAMPLE walker.js TRACKING IMPLEMENTATION FOR SERVER-SIDE GTM
  -------------------------------------------------------------
*/

(function () {

  // *************** SETUP ***************************

  // @TODO change this or use data-endpoint when loading (see examlpe HTML file)
  setup_endpointUrl = document.currentScript.getAttribute('data-endpoint') || "https://httpbin.org/anything"; 

  //send as image in case of CORS issues
  setup_sendAsImage = false;
  setup_sendBase64 = false;

// *************** END SETUP ***********************

  // Ignore Bot-traffic
  if (isBot(navigator.userAgent)) return;

  // General walker configuration
  elb("walker config", {
    // Empty initial consent state
    consent: {},
    // Add common event parameters to each event
    globals: { page_title: document.title },
    // Current version of the tracking setup
    version: 1,
  });


  // DEMO Destination to log events to console
  elb("walker destination", {
    // optionally use a custom consent to activate this via elb("walker consent", {demo: true}) in the console
    // config: { consent: { demo: true } },
    push: function (event) {
      console.log("DEMO", event);
    },
  });

  // SGTM Destination to send to server-side GTM-Client
  elb("walker destination", {
    config: {
      consent: { functional: true },
      custom: {
        sendBase64: setup_sendBase64,
        sendAsImage: setup_sendAsImage,
        endpointUrl: setup_endpointUrl,
        globals: {},
      },
    },
    init: function (config) {
      var globals = config.custom.globals;

      var sessionStartTimestamp = window.sessionStorage.getItem("lg_sts");
      // var sid = window.sessionStorage.getItem('lg_sid');
      var sessionNumber = window.localStorage.getItem("lg_sct") || 0;
      // var cid = window.localStorage.getItem('lg_cid');
      var sessionStart = false;

      // No active session yet
      if (!sessionStartTimestamp) {
        // New session
        sessionStart = true;
        sessionStartTimestamp = Math.round(Date.now() / 1000);
        window.sessionStorage.setItem("lg_sts", sessionStartTimestamp);
        sessionNumber++;
        window.localStorage.setItem("lg_sct", sessionNumber);
      }

      // Add global session parameters for GA4 processing in sGTM
      globals.session_started = sessionStartTimestamp;
      globals.session_number = sessionNumber;

      // Session start marker for GA4
      if (sessionStart === true) globals.session_start = true;

      // successfull init
      return true;
    },
    push: function (event, config) {
      // Add the destination's globals to the event
      event.globals = Object.assign(config.custom.globals, event.globals);

      sendToApi(event, config.custom);

      // Only push session_start once
      if (event.globals.session_start) delete event.globals.session_start;

      console.log("SGTM", event);
    },
  });

  // MARKETING Destination to send events to an example marketing tool
  elb("walker destination", {
    // Require marketing consent to use this destination
    config: { consent: { marketing: true } },
    init: function () {
      // Load the 3rd party script and setup
      return true;
    },
    push: function (event) {
      // Do something ...
      console.log("MARKETING", event);
    },
  });

  // Start the magic!
  elb("walker run");
})();

function elb() {
  (window.elbLayer = window.elbLayer || []).push(arguments);
}

// Code snippets for consent choice
// Simulate the CMPs functionality

function consentAccept() {
  window.localStorage.setItem("consentState", "accepted");
  consentRefresh();

  // see walker-init.js
  consentGranted();
}
function consentDeny() {
  window.localStorage.setItem("consentState", "denied");
  consentRefresh();

  // see walker-init.js
  consentDenied();
}
function consentReset() {
  window.localStorage.removeItem("consentState");
  consentRefresh();
}
function consentRefresh() {
  var consentStateElem = document.getElementById("consent_state");
  var consentState = window.localStorage.getItem("consentState") || "unknown";

  if (consentState == "accepted") consentGranted();
  if (consentState == "denied") consentDenied();

  consentStateElem.innerText = consentState;
}

consentRefresh();

function consentGranted() {
  // Set session and device ids
  elb("walker user", getUser());

  // Allow sending events to functional and marketing destinations
  elb("walker consent", { functional: true, marketing: true });
}

function consentDenied() {
  // Check for strict opt-out settings
  if (window.location.href.indexOf("noconsent") < 0) {
    const user = getUser();

    // Only set a random session id, but no persistant device id
    elb("walker user", { session: user.session, id: "anonymous" });
    // Alternatively: Use campaign information (e.g. utm_campaign) as sessionId to further depersonalize

    // Actively forbit sending data in general (e.g. by opt-out) by setting functional=false
  }

  // Allow sending events to functional destinations at most
  elb("walker consent", { functional: true, marketing: false });
}

// General walker.js user identification
function getUser() {
  const sessionKey = "elb_user_sessionId";
  const deviceKey = "elb_user_deviceId";
  var session = window.sessionStorage.getItem(sessionKey);
  var device = window.localStorage.getItem(deviceKey);

  if (!session) {
    session = Math.round(Math.random() * 10000000000);
    window.sessionStorage.setItem(sessionKey, session);
  }

  if (!device) {
    device = Math.round(Math.random() * 10000000000);
    window.localStorage.setItem(deviceKey, device);
  }

  return {
    session,
    device,
  };
}

function isBot(s) {
  // Minimal bot detection, "stolen" from Trackboxx (https://cdn.trackboxx.info/p/tracker.js)
  return /bot|google|baidu|bing|msn|duckduckbot|teoma|slurp|yandex/i.test(s);
}

// Sending data to an API endpoint
function sendToApi(event, config) {
  if (
    event.data &&
    event.data.hash &&
    config.sendBase64 !== true &&
    config.sendAsImage === true
  ) {
    event.data.hash = event.data.hash.replace("#", "");
  }
  var obs = JSON.stringify(event);
  //base64 coding for serialized object
  if (obs === "{}") obs = "";
  else if (config.sendBase64 === true)
    obs = btoa(unescape(encodeURIComponent(obs)));
  var params = obs !== "" ? "?o=" + encodeURI(obs) : "";
  var e;
  if (window.XMLHttpRequest) e = new XMLHttpRequest();
  if (e && config.sendAsImage !== true) {
    e.open("POST", config.endpointUrl, true);
    //you might have to change this to "application/json" depending
    //on your endpoint
    e.setRequestHeader("Content-Type", "text/plain");
    e.send(obs);
    //alternative method: use fetch() - okay for almost every browser
    /*
      fetch(r, {method: "POST", cache: "no-cache",
        headers: {
          "X-Gtm-Server-Preview":"xxxx",
          "Content-Type": "application/json"
        }, body: obs}
      );
      */
  } else {
    new Image().src = config.endpointUrl + params;
  }
}
