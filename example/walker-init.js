/* 
-------------------------------------------------------------  
EXAMPLE walker.js TRACKING IMPLEMENTATION FOR SERVER-SIDE GTM  
-------------------------------------------------------------  
*/

//send as image in case of CORS issues
window._walkerSettings = {}
window._walkerSettings.sendAsImage = document.currentScript.getAttribute('data-sendimg') != "false";
window._walkerSettings.sendBase64 = document.currentScript.getAttribute('data-base64') != "false";
window._walkerSettings.version = document.currentScript.getAttribute('data-version');
//ssGTM endpoint
window._walkerSettings.endpointUrl = document.currentScript.getAttribute('data-endpoint') || "/elbwalker";
//load walker.js from custom path
window._walkerSettings.walkerpath = document.currentScript.getAttribute('data-walkerpath');

//TO DO: "fake" consent - just to remind you that there should be consent or you can not handle user and session state
window._walkerSettings.doAnalytics = window.location.href.indexOf('noconsent') < 0;

/*************** END SETUP *****************/

//simple session and client handling - switch to cookies or move server-side if you like
function getSessionData() {
  if (window._walkerSettings.doAnalytics != true) return;
  var sts = window.sessionStorage.getItem("lg_sts");
  var sid = window.sessionStorage.getItem("lg_sid");
  var sct = window.localStorage.getItem("lg_sct") || 0;
  var cid = window.localStorage.getItem("lg_cid");

  var sStart = false;

  if (!sts) {
    //new session
    sStart = true;
    sts = Math.round(Date.now() / 1000);
    sid = Math.round(Math.random() * 10000000000);
    window.sessionStorage.setItem("lg_sts", sts);
    window.sessionStorage.setItem("lg_sid", sid);
    sct++;
    window.localStorage.setItem("lg_sct", sct);
  }

  //simple user management via localStorage as well - switch to cookies or set
  //server-side id cookie for a more robust identification of returning visitors 
  if (!cid) {
    //just paste random session id and timestamp for a new persistent client id
    cid = sts+"."+sid;
    window.localStorage.setItem("lg_cid", cid);
  }

  return {
    sessionId: sid, 
    sessionNumber: sct, 
    sessionStartTimestamp: sts, 
    clientId: cid, 
    sessionStart: sStart
  };
}

//function to push data to queue
function elb() {
  (window.elbLayer = window.elbLayer || []).push(arguments);
}

(function(w,a,l,k,e,r){
  w = window; 
  a = document.referrer;
  l = document.location.href;
  k = document.title;
  r = w._walkerSettings.endpointUrl;

  //load walker.js?
  var wp = w._walkerSettings.walkerpath;
  if (wp) {
    var wsc = document.createElement("script");
    wsc.type = "text/javascript"; 
    wsc.className = "elbwalker"
    wsc.dataset.version = w._walkerSettings.version||"1"
    wsc.async = true; 
    wsc.defer = true; 
    wsc.src = wp; 
    document.head.appendChild(wsc);
  }

  //minimal bot detection, "stolen" from Trackboxx (https://cdn.trackboxx.info/p/tracker.js)
  if (/bot|google|baidu|bing|msn|duckduckbot|teoma|slurp|yandex/i.test(navigator.userAgent)) return false;

  const addGlobal = function(cnt){
    var sp = document.createElement("span");
    sp.dataset.elbglobals = cnt;
    document.body.appendChild(sp);
  };
  
  //add some "globals" to DOM as elements
  //TO DO: add other elements here, if needed in every event
  if ((w._walkerSettings.sendBase64 != true) && 
      (w._walkerSettings.sendAsImage === true)) {
      l = l.split("#")[0];
  } 
  
  //globals for standard GA4 event parameters
  addGlobal("page_location:'"+l+"'");
  addGlobal("page_title:'"+k+"'");
  if (a) addGlobal("page_referrer:'"+a+"'");

  //send consent with every event: can be used in ssGTM to trigger specific tags. 
  //Adjust to match your needs and send a list of allowed services or set of markers
  //like this one: 
  addGlobal("analytics_consent:'"+w._walkerSettings.doAnalytics+"'");

  //call session handling and set user attributes + elements for session id and number 
  var sD = getSessionData();
  if (sD) {
  elb("walker user", {hash: sD.sessionId, device: sD.clientId});
  //add global session parameters for GA4 processing in ssGTM
  addGlobal("session_started:'"+sD.sessionStartTimestamp+"'");
  addGlobal("session_number:'"+sD.sessionNumber+"'");
  //session start marker for GA4
  if (sD.sessionStart === true)
      addGlobal("session_start:true");
  }

  //send hit as image request to avoid CORS problems, beacon and AJAX are (better) options in any other case
  elb("walker destination", { push: 
    function (event) {
      if (event.data && event.data.hash && 
      (w._walkerSettings.sendBase64 != true) && 
      (w._walkerSettings.sendAsImage === true)) {
      event.data.hash = event.data.hash.replace("#", "");
      } 
      var obs = JSON.stringify(event);
      //base64 coding for serialized object    
      if (obs === "{}") 
      obs = ""; 
      else if (w._walkerSettings.sendBase64 === true) 
      obs = btoa(unescape(encodeURIComponent(obs)));
      var params = (obs != "") ? "?o=" + encodeURI(obs) : "";
      if (w.XMLHttpRequest) e = new XMLHttpRequest();
      if ((e != null) && (w._walkerSettings.sendAsImage != true)) {
        e.open("POST", r, true);
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
      } else  
        (new Image).src = r + params;
      //log event to console for debugging purposes 
      console.log(event);
    }
  }); 
  //start the magic!
  elb("walker run");
})();