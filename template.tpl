___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "CLIENT",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "elbwalker",
  "categories": [
    "UTILITY"
  ],
  "brand": {
    "id": "mbaersch",
    "displayName": "mbaersch",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAYCAYAAACbU/80AAAABmJLR0QAvgD/ALe9KR/IAAAACXBIWXMAAC4jAAAuIwF4pT92AAAAB3RJTUUH5gseEAEKLjc4rQAAABl0RVh0Q29tbWVudABDcmVhdGVkIHdpdGggR0lNUFeBDhcAAAMSSURBVEjH1VZLSJRRFP7O/f9hMoqMYoasGBOpaFNhSIvohSA12juSorIHahKJLaRVm6BAKiQj8gGJEC6KQJ0BLUjalIsgadVLZ4wk/ikpSR0dnXtaKGYzZ/75d9Fdnu+e8333nHPPvcA/XuR0o6cztJiUug6iEgDL5wDm3Zbf12Pn6w2GNwFUB6KtANyzfl8sv2+16ZA8gwyjB0DeXwBzH0fHXtiSB0K7QKobgCsBqgUA5ShNhnEliXxm1UeObNApyTsHCKSaBfIx1vFWRwI87Z8WADgnQF/1RLTNXjkdAFFOkp25IVKcM+JIAJmukwBWCkFavh1eH7V1VkaVYNUA189tcVCBMsE2zvH4bdvadwxsBrBDEN5u+bPDjgR4g4MFINoiBHkU2Zfz3Va2YVSnQG7+laQ0p5dTyFyX5totBdFRQfhby+976UiANziYC6K9AvTcKsruSyO8BsACwX4jqU1sglSKuNZ37O992AVSZ5IRHgbwxJEAbyCcCaJyAfrAU7FAmtOfBeAV0l9n+X2xRLOZ4v6eBrBQCHI/cnAte4Ph7QBVAygEeDYz3GUVrzkEpS4IESdBqsHRW+Bp7zfJND+DaEUC+y+enMwil+swlNEiiPOD9RSU8VTAmiy/r0wcFcmDx9yTTA6A0QTTZUIZ9QJBSP8Y7oJSVWJGmRtTzirBdlUKAa1vk1IXASwW8FtqydJcgAoF12dWUfZrRwK8gXBeisHTbhWvGQLhvEAwDq0fQqlLYk9pvms7rROa73KKFNZ6AqHjAPmE3NxjsALRCcHvnR4dCTgS4OnozwLRMSHIG6so+xUp44xYGuYHZJinAGQK+L1vJRu1nQDzz5tvVgIwhD213s7QZgAFgrguAJ/A3A1KulDfOTbxIN1LZwKA58n7DBBVCARDHI8/JtNoTFGaOyAqBtEqAWuNHFw36kgAud2lAJYJeDmIMgHxYWnjWKyb3O5ewe8jT09dc/LbmukBUhUJwXvBeqfl9wVJqUoAi+ahEbCu4eh4Kbnd+SDKn/9PAHMzpqe3Rfbn/sT/sH4DfEUaJgR8khoAAAAASUVORK5CYII\u003d"
  },
  "description": "Client for receiving walker.js events (with optional session data \u0026 conversion handling for GA4)",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "walkerJs",
    "displayName": "walker.js",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "serveWalkerJs",
        "checkboxText": "Serve walker.js through SGTM",
        "simpleValueType": true,
        "alwaysInSummary": true,
        "defaultValue": false
      },
      {
        "type": "TEXT",
        "name": "walkerJsMaxAgeInMilliseconds",
        "displayName": "Cache Max Age (Milliseconds)",
        "simpleValueType": true,
        "defaultValue": 60000,
        "valueValidators": [
          {
            "type": "POSITIVE_NUMBER"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "serveWalkerJs",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "walkerJsPath",
        "displayName": "walker.js URL path",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "serveWalkerJs",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "help": "The URL path under which the walker.js is served. Defaults to /walker.js if empty.",
        "valueValidators": [
          {
            "type": "REGEX",
            "args": [
              "^\\/.*"
            ],
            "errorMessage": "Enter your URL path with a leading slash, e. g. /my-awesome-path.js"
          }
        ],
        "alwaysInSummary": true,
        "defaultValue": "/walker.js"
      },
      {
        "type": "RADIO",
        "name": "walkerJsVersionUseVersion",
        "displayName": "walker.js Version",
        "radioItems": [
          {
            "value": "specific",
            "displayValue": "Specific Version"
          },
          {
            "value": "latest",
            "displayValue": "Always Use Latest Version"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "specific",
        "enablingConditions": [
          {
            "paramName": "serveWalkerJs",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "walkerJsVersion",
        "displayName": "walker.js Version",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "walkerJsVersionUseVersion",
            "paramValue": "specific",
            "type": "EQUALS"
          }
        ],
        "help": "Enter the walker.js version you\u0027d like to use. Use the X.X.X format as specified on the walker.js Github repo, e. g. 2.0.0",
        "defaultValue": "2.0.0"
      },
      {
        "type": "LABEL",
        "name": "walkerJsLatestVersionWarning",
        "displayName": "WARNING! Do not use the this setting in production. Whenever a new version of walker.js is released, it will automatically be served on your site. If this version introduces any breaking changes, your data collection might not work as expected.",
        "enablingConditions": [
          {
            "paramName": "walkerJsVersionUseVersion",
            "paramValue": "latest",
            "type": "EQUALS"
          }
        ]
      }
    ],
    "groupStyle": "NO_ZIPPY"
  },
  {
    "type": "GROUP",
    "name": "sessionData",
    "displayName": "Session \u0026 Client IDs",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "LABEL",
        "name": "infoSessionNumber",
        "displayName": "Most analytics tags (not only GA4) need at least a session id in order to know how to bundle events to a session. A separate client id is needed to recognize visitors beyond single sessions. If you want to use a GA4 tag, a session number is also mandatory. Leave fields blank to use fallback or default values."
      },
      {
        "type": "SELECT",
        "name": "sessionDataSource",
        "displayName": "Source",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "request",
            "displayValue": "Event Data"
          },
          {
            "value": "user",
            "displayValue": "User-Defined"
          },
          {
            "value": "cookie",
            "displayValue": "Cookies"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "request"
      },
      {
        "type": "TEXT",
        "name": "sessionIdValue",
        "displayName": "Session ID",
        "simpleValueType": true,
        "help": "enter constant or define variable to populate the session id. If none is present, a random number will be used inste",
        "enablingConditions": [
          {
            "paramName": "sessionDataSource",
            "paramValue": "user",
            "type": "EQUALS"
          }
        ],
        "valueValidators": []
      },
      {
        "type": "TEXT",
        "name": "sessionNumberValue",
        "displayName": "Session Number",
        "simpleValueType": true,
        "help": "enter constant or define variable to populate the session number (fallback will be \"1\")",
        "enablingConditions": [
          {
            "paramName": "sessionDataSource",
            "paramValue": "user",
            "type": "EQUALS"
          }
        ],
        "valueValidators": []
      },
      {
        "type": "TEXT",
        "name": "clientIdValue",
        "displayName": "Client ID",
        "simpleValueType": true,
        "help": "enter constant or define variable to populate the client id (fallback will be session id)",
        "enablingConditions": [
          {
            "paramName": "sessionDataSource",
            "paramValue": "user",
            "type": "EQUALS"
          }
        ],
        "valueValidators": []
      },
      {
        "type": "TEXT",
        "name": "sessionIdSource",
        "displayName": "Session ID Source Path",
        "simpleValueType": true,
        "defaultValue": "user.session",
        "help": "enter additional lookup path to session id information in incoming events (default: user.session), if not sent as \"globals.session_started\". Will be a changing timestamp if no value is present anywhere",
        "enablingConditions": [
          {
            "paramName": "sessionDataSource",
            "paramValue": "request",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "sessionNumberSource",
        "displayName": "Session Number Source Path",
        "simpleValueType": true,
        "defaultValue": "globals.session_number",
        "help": "enter lookup path to session number information in incoming events (default: globals.session_number). Will be \"1\" if not available in request",
        "enablingConditions": [
          {
            "paramName": "sessionDataSource",
            "paramValue": "request",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "clientIdSource",
        "displayName": "Client ID Source Path",
        "simpleValueType": true,
        "defaultValue": "user.device",
        "help": "enter lookup path to client id in incoming events (default: user.device). Will be set to session id if not available in request as \"user.device\" or \"user.session\".",
        "enablingConditions": [
          {
            "paramName": "sessionDataSource",
            "paramValue": "request",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "sessionCookieName",
        "displayName": "Session ID Cookie-Name",
        "simpleValueType": true,
        "alwaysInSummary": false,
        "enablingConditions": [
          {
            "paramName": "sessionDataSource",
            "paramValue": "cookie",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "sessionNumberName",
        "displayName": "Session Number Cookie-Name",
        "simpleValueType": true,
        "alwaysInSummary": false,
        "enablingConditions": [
          {
            "paramName": "sessionDataSource",
            "paramValue": "cookie",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "clientCookieName",
        "displayName": "Client ID Cookie-Name",
        "simpleValueType": true,
        "alwaysInSummary": false,
        "enablingConditions": [
          {
            "paramName": "sessionDataSource",
            "paramValue": "cookie",
            "type": "EQUALS"
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "eventData",
    "displayName": "Event Name Processing",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "LABEL",
        "name": "InfoEventNames",
        "displayName": "If you send standard event names from walker.js without a specific client-side mapping, you can optionally adjust event names to match what your tags expect."
      },
      {
        "type": "SELECT",
        "name": "eventNameHandling",
        "displayName": "Adjust Event Names",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "none",
            "displayValue": "No Changes"
          },
          {
            "value": "normalize",
            "displayValue": "Lowercase + Whitespace -\u003e Underscore"
          },
          {
            "value": "map",
            "displayValue": "Define Mapping Table"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "normalize"
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "eventMapping",
        "displayName": "Change Event Names",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Incoming Event Name",
            "name": "walkerName",
            "type": "TEXT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "New Event Name",
            "name": "newName",
            "type": "TEXT",
            "isUnique": true,
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ],
        "enablingConditions": [
          {
            "paramName": "eventNameHandling",
            "paramValue": "map",
            "type": "EQUALS"
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "advancedSettings",
    "displayName": "Advanced Settings",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "GROUP",
        "name": "endpointSettings",
        "displayName": "Endpoint Settings",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "TEXT",
            "name": "endpointPath",
            "displayName": "Endpoint Path",
            "simpleValueType": true,
            "help": "Enter a path where this client should listen for incoming events",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ],
            "defaultValue": "/elbwalker"
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "eventSettings",
        "displayName": "Event Model Options",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "LABEL",
            "name": "labelEventSettings",
            "displayName": "Define if and how the walker.js event structure should be part of the event model - additionally to all standard parameters that get populated by this client."
          },
          {
            "type": "CHECKBOX",
            "name": "includeWalkerEvent",
            "checkboxText": "Include walker.js Event",
            "simpleValueType": true,
            "help": "check to add the complete received event as \"x-elb-event\"",
            "defaultValue": true
          },
          {
            "type": "CHECKBOX",
            "name": "consentAsParams",
            "checkboxText": "Add \"consent\" As Event Parameters",
            "simpleValueType": true,
            "defaultValue": true
          },
          {
            "type": "CHECKBOX",
            "name": "dataAsParams",
            "checkboxText": "Add \"data\" As Event Parameters",
            "simpleValueType": true,
            "defaultValue": true
          },
          {
            "type": "CHECKBOX",
            "name": "contextAsParams",
            "checkboxText": "Add \"context\" As Event Parameters",
            "simpleValueType": true,
            "defaultValue": true
          },
          {
            "type": "CHECKBOX",
            "name": "globalsAsParams",
            "checkboxText": "Add \"globals\" As Event Parameters",
            "simpleValueType": true,
            "defaultValue": true
          },
          {
            "type": "CHECKBOX",
            "name": "customAsParams",
            "checkboxText": "Add \"custom\" As Event Parameters",
            "simpleValueType": true,
            "defaultValue": true
          },
          {
            "type": "LABEL",
            "name": "labelObjInfo",
            "displayName": "Note: When adding parameters from globals, context or data, keys with the same name will always contain the more specific value."
          },
          {
            "type": "SIMPLE_TABLE",
            "name": "addEventParameters",
            "displayName": "Add / Edit Parameters",
            "simpleTableColumns": [
              {
                "defaultValue": "",
                "displayName": "Parameter Name",
                "name": "paramName",
                "type": "TEXT",
                "valueValidators": [
                  {
                    "type": "NON_EMPTY"
                  }
                ]
              },
              {
                "defaultValue": "",
                "displayName": "Parameter Value",
                "name": "paramValue",
                "type": "TEXT"
              }
            ]
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "ga4Settings",
        "displayName": "GA4 Specific Settings",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "LABEL",
            "name": "ga4Info",
            "displayName": "All settings in this section are only relevant if you want to send walker.js events to GA4."
          },
          {
            "type": "TEXT",
            "name": "sessionStartPath",
            "displayName": "GA4 Session Start Marker Path",
            "simpleValueType": true,
            "defaultValue": "globals.session_start",
            "help": "if you want to send data to GA4, a value must be present in a certain key (default: globals.session_start). Define a fallback path here. Any \"truthy\" value will trigger a \"session_start\" marker in incoming events if the event counter (\"count\") indicates the first event after loading. An additional \"first_visit\" marker is added in case the session number equals \"1\".",
            "enablingConditions": []
          },
          {
            "type": "CHECKBOX",
            "name": "nestedToItems",
            "checkboxText": "Convert \"nested\" To \"items\"",
            "simpleValueType": true,
            "defaultValue": true,
            "help": "optionally convert nested data to e-commerce items for GA4"
          },
          {
            "type": "TEXT",
            "name": "nestedType",
            "displayName": "Type Name",
            "simpleValueType": true,
            "help": "define item type (e. g. \"product\") to convert to event items. NOTE: The item properties for this type have to match the expected structure for GA4 e-commerce events",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ],
            "enablingConditions": [
              {
                "paramName": "nestedToItems",
                "paramValue": true,
                "type": "EQUALS"
              }
            ],
            "defaultValue": "product"
          },
          {
            "type": "TEXT",
            "name": "conversionNames",
            "displayName": "Conversion Event Names",
            "simpleValueType": true,
            "lineCount": 10,
            "textAsList": true,
            "help": "enter one event name (after changes defined in this client) per line to be marked as GA4 conversion",
            "defaultValue": "purchase"
          },
          {
            "type": "CHECKBOX",
            "name": "sendAsDebug",
            "checkboxText": "Send GA4 Debug Flag",
            "simpleValueType": true,
            "help": "activate for enabling GA4 DebugView"
          }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

/**
 * @description Custom Google Tag Manager Client Template for walker.js
 * @version 0.2.1
 * @see {@link https://github.com/elbwalker|elbwalker on GitHub} for more about walker.js
 */
const getType = require('getType');
const claimRequest = require('claimRequest');
const returnResponse = require('returnResponse');
const runContainer = require('runContainer');
const decodeUriComponent = require('decodeUriComponent');
const setPixelResponse = require('setPixelResponse');
const setResponseHeader = require('setResponseHeader');
const setResponseStatus = require("setResponseStatus");
const setResponseBody = require("setResponseBody");
const getRequestHeader = require('getRequestHeader');
const getRequestBody = require('getRequestBody');
const getRequestQueryParameter = require('getRequestQueryParameter');
const getRequestPath = require('getRequestPath');
const getCookie = require('getCookieValues');
const JSON = require('JSON');
const getRemoteAddress = require('getRemoteAddress');
const fromBase64 = require('fromBase64');
const makeNumber = require('makeNumber');
const sendHttpGet = require("sendHttpGet");
const getTimestampMillis = require("getTimestampMillis");
const templateDataStorage = require('templateDataStorage');
const Object = require('Object');

//helper

/**
 * creates an event parameter if value is set.
 * @param {Object} event - event object to handle.
 * @param {string} fieldName - name for key / parameter to add.
 * @param {*} val - parameter value object.
 */
const createField = (event, fieldName, val) => {
  if (val) event[fieldName] = val;
};    

/**
 * reads nested object properties.
 * @param {Object} ob - object to get value from.
 * @param {string} path - (user defined) path to value using regular JS / "dot" notation.
 */
const valueByPath = (ob, path) => {
  //if there is no valid path, return the path name / object
  if (getType(path) !== "string") return path; 
  return path.split('.').reduce(function(o, k) {
    var ind = k.indexOf('[');
    var ind2 = k.indexOf(']');
    if (ind >=0 && ind2 > ind) {
      var kOrg = k;
      k = kOrg.substring(0,ind);
      var key = kOrg.substring(ind+1, ind2);
      if (k != "")
        return o && o[k][key];
      else 
        return o && o[key];
    } else return o && o[k];
    }, ob);
};  

/**
 * responds with cached or fresh version of walker.js script as client result.
 * @param {string} scriptBody - script content to include in response.
 * @param {boolean} isCached - flag for script origin - used to send a custom [debug] header.
 */
const returnWalkerJs = function(scriptBody, isCached) {
  setResponseStatus(200);
  setResponseBody(scriptBody);
  setResponseHeader("Content-Type", "text/javascript");
  if (isCached) {
    setResponseHeader("x-sgtm-templatestorage-cached", "true");
  }
  returnResponse();
};    
 
/**
 * adds array data from walker.js script as event parameters. 
 * Object has no "assign" method in this sandbox :(
 * @param {object} event - object to add parameters.
 * @param {object} dims - object to add.
 */
const addParamsFromArray = function(event, dims) {
  if (dims && typeof(dims === "object")) {
    for (var key in dims) {
      event[key] = dims[key];
    }  
  }
};

/******************************************************************/

const requestPath = getRequestPath();

//claim elbwalker requests
if (requestPath === (data.endpointPath || '/elbwalker')) {

  claimRequest();
  setResponseHeader("Access-Control-Allow-Origin", "*");
  setResponseHeader("Access-Control-Allow-Credentials", "true");
  setResponseHeader("Access-Control-Allow-Headers", "*");  
  
  const ip = getRemoteAddress();
  const ua = getRequestHeader('user-agent');
  
  const ref = getRequestHeader('Referer');
  const lng = getRequestHeader('Accept-Language') || "";
  
  var objs =  getRequestBody();

  //use GET Parameter as fallback 
  if (!objs) objs = getRequestQueryParameter('o');
  
  var evtData; 
  if (objs && objs != "") {
    if (objs.substring(0,1) == "{") evtData = JSON.parse(objs);
    else {
      //if data is base64 coded, decode and re-parse
      if (!evtData) evtData = JSON.parse(fromBase64(objs));
    }
  }  
  evtData = evtData||{};
  
  const fallbackSession = getTimestampMillis();

  //session id or client id can be included in request or user as defined fields   
  if (data.sessionDataSource === "user") {
    
    var sid = data.sessionIdValue || fallbackSession;
    var snum = data.sessionNumberValue || "1";
    var cid = data.clientIdValue || sid;
    
  } else if (data.sessionDataSource === "cookie") {
    
    var sid = getCookie(data.sessionCookieName)[0] || fallbackSession;
    var snum = getCookie(data.sessionNumberCookieName)[0] || "1";
    var cid = getCookie(data.clientCookieName)[0] || fallbackSession;
    
  } else {

    var cid = valueByPath(evtData, "user.device") || 
              valueByPath(evtData, "user.session") || valueByPath(evtData, "user.hash") || 
              valueByPath(evtData, data.clientIdSource) || fallbackSession;
    var snum = valueByPath(evtData, data.sessionNumberSource || "globals.session_number") || "1";
    var sid = valueByPath(evtData, "globals.session_started") || 
              valueByPath(evtData, data.sessionIdSource) || fallbackSession;
  }
  
  var evName = evtData.event || "elb_event";
  if (data.eventNameHandling === "normalize") 
    evName = evName.toLowerCase().replace(" ", "_");
  else if ((data.eventNameHandling === "map") && 
           data.eventMapping && (data.eventMapping.length > 0)) {
    for (var i=0;i<data.eventMapping.length;i++) 
      if (evName === data.eventMapping[i].walkerName) {
        evName = data.eventMapping[i].newName;
        break;
      }
  }
  
  var loc = (evtData.source||{}).id || ref;
  var event = { anonymize_ip: true,
                event_name: evName,
                client_id : cid,
                ip_override : ip,
                user_agent : ua,
                page_location : loc
              };
  
  if (evtData.data)  {
    createField(event, "page_hostname", evtData.data.domain);
    createField(event, "page_path", evtData.data.id);
    createField(event, "page_title", evtData.data.title);
  }
  
  if (evtData.user && evtData.user.id)  
    createField(event, "user_id", evtData.user.id);
 
  createField(event, "page_referrer", (evtData.source||{}).previous_id);
  createField(event, "client_timestamp", evtData.timestamp);
  createField(event, "event_category", evtData.entity);
  createField(event, "event_action", evtData.action||evName);
  createField(event, "event_id", evtData.id);
  
  var version = (evtData.version||{});

  //add some walker.js properties
  createField(event, "x-elb-config-version", version.config||version.tagging||0);
  createField(event, "x-elb-walker-version", version.walker||version.client||0);
  createField(event, "x-elb-event", evtData);

  //add proprietary Google Analytics properties
  event['x-ga-js_client_id'] = cid;
  event['x-ga-page_id'] = evtData.group;
  event['x-ga-request_count'] = evtData.count;
  event.ga_session_number = snum;
  event.ga_session_id = sid;

  //use consent as event parameters
  if (data.consentAsParams === true) 
    addParamsFromArray(event, evtData.consent);
  
  //use globals as event parameters
  if (data.globalsAsParams === true) 
    addParamsFromArray(event, evtData.globals);
  
  //use context data as event parameters
  if (data.contextAsParams === true) 
    addParamsFromArray(event, evtData.context);

  //use data as event parameters
  if (data.dataAsParams === true) 
    addParamsFromArray(event, evtData.data);

  //use custom as event parameters
  if (data.customAsParams === true) {
    addParamsFromArray(event, evtData.custom);
  }
  
  if (data.nestedToItems === true) {
    var items = [];
    (evtData.nested||{}).filter(
      x => x.type==data.nestedType
    ).forEach(
      x => items.push(x.data)
    );
    if (items.length > 0) event.items = items;
  }

  //add / edit event parameters
  if (data.addEventParameters) 
    data.addEventParameters.forEach((v, i) => {
      event[v.paramName] = v.paramValue;
    });     
  
  //GA4 system properties
  var sprops = {};
  var isStart = valueByPath(evtData, 
      data.sessionStartPath || "globals.session_start") ? true : false;
  isStart = isStart && (makeNumber(evtData.count) === 1);
  if (isStart) sprops.ss = "1";
  if (isStart && (makeNumber(snum) === 1)) sprops.fv = "1";
  //use final event_name value
  if (data.conversionNames.indexOf(event.event_name) >= 0) sprops.c = "1";
  if (data.sendAsDebug === true) sprops.dbg = "1";
  if (sprops.ss || sprops.fv || sprops.dbg || sprops.c) 
    event["x-ga-system_properties"] = sprops;

  //everything except session start will be "engaged"
  event['x-ga-mp2-seg'] = isStart == true ? "0" : "1"; 
  
  /*2DO: 
  ------------------------------------------------------------------------
  - no hit contains engagement time. If you need engagement metrics, 
    a client side timer will be needed and engagement time must be sent as
    parameter or set as field in this client manually 
    (using the advanced settings)
  - how to handle "data" beyond page view events?   
  */
    
  runContainer(event, () => {  
    setPixelResponse();
    returnResponse();    
  });
  
} else if ((data.serveWalkerJs === true) && (requestPath === (data.walkerJsPath || "/walker.js"))) {
  
  //walker.js Proxy - by Justus ;) 
  claimRequest();

  //walker.js is cached in the container to avoid hitting the CDN for every request
  //and to speed up delivery to the browser
  const walkerJsMaxAgeInMilliseconds = data.walkerJsMaxAgeInMilliseconds || 60000;
  const walkerJsCached = templateDataStorage.getItemCopy("walkerJs");
  const walkerJsLastModified = makeNumber(templateDataStorage.getItemCopy("walkerJsLastModified"));
  //if the cached walker.js is still fresh, return it
  if (walkerJsCached && walkerJsCached.indexOf("elbwalker") > -1 &&
      getTimestampMillis() - walkerJsLastModified < walkerJsMaxAgeInMilliseconds) {
    if (walkerJsLastModified && getTimestampMillis() - 
        walkerJsLastModified < walkerJsMaxAgeInMilliseconds) {
      returnWalkerJs(walkerJsCached, true);
    }
  } else {

    var version = "latest";
    if (data.walkerJsVersionUseVersion === "specific") 
      version = data.walkerJsVersion;

    sendHttpGet("https://cdn.jsdelivr.net/npm/@elbwalker/walker.js@" + version + "/dist/walker.js")
      .then((result) => {
      //make extra-sure that the script actually looks reasonable before
      //caching it in the container
      if (result.statusCode === 200 && result.body.indexOf("elbwalker") > -1) {
        templateDataStorage.setItemCopy("walkerJs", result.body);
        templateDataStorage.setItemCopy("walkerJsLastModified", getTimestampMillis());
      }
      returnWalkerJs(result.body);
    }, () => {
      setResponseStatus(500);
      returnResponse();
    });
  }
}


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "return_response",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "run_container",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_response",
        "versionId": "1"
      },
      "param": [
        {
          "key": "writeResponseAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "writeHeaderAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_template_storage",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://cdn.jsdelivr.net/npm/@elbwalker/walker.js*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 20.12.2020, 02:26:15


