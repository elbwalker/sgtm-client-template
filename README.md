# ssGTM Client Template for elbwalker (elbwalker-ssgtm-client)
Custom client template (beta) for server-side Google Tag Manager. Receives walker.js events and optionally serves walker.js script. Optimized for use as gtag.js replacement for GA4.

## Client Configuration
After installing the template, a new client can be created in ssGTM. The client has several groups of settings. 

### walker.js
You can use a local copy of walker.js in the browser in order to create and send events to ssGTM. If you decide to use your ssGTM endpoint to serve a first party copy of walker.js, check the option and define a maximum cache age (the client uses ssGTM template storage to cache the script) in milliseconds and a path, if you want to use a different file name. 

The client can either serve the latest version (loaded from cdn.jsdelivr.net) or a secific one. The latter is highly recommended in order to insure a robust client side setup. 

### Session & Client IDs
Depending on your usage and client-side utilization of walker events and user / session handling, there are several ways of extracting a session id, number (mainly for the use with GA4) and a client id. 

The minimal needed identifier would be a session id that can be used in order to have a common id for every hit that belongs to the same session / browser / visit. If there is no client id, the session id will serve as fallback. 

Choose between cookies, walker event data or a custom definition for getting session and client data. In every case you can define how incoming events should be handled when setting:

- session id
- session number
- client id

### Event Name Processing
walker.js events usually have a different format than the tags used in ssGTM expect. As most tags expect an incoming GA4 stream, you can use different methods for adjusting event names. The easy way is to replace all whitepaces with an "_" and lowercase the event name. This would make a "page view" from elwalker to appear as "page_view" in the ssGTM event model. 

Alternatively you can translate every incoming event name to a new one in order to match your expectations. 

### Advanced Settings
The advanced section allows to define different parameters that control what happens with inoming requests. It is possible to include a fully nested copy of the walker.js event in the event model. This might be useful if you want to forward all event data directly into a first party database like a BigQuery table. Or in case that specific data should be extracted from the event and used to provide values for an advanced tag configuration.

Adding information from the "context" and "globals" section of incoming events can be used to create a "flat" event model that might fit your needs in a better way than the client template automatically maps some of the (expected) event properties (for a page_location, page_title, page_referrer and others for example). 

#### GA4 Specific Settings
The client expects a **marker for detecting a new session** somewhere in the incoming event data. The default path can be changed to sync the client with your implementation. Any "truthy" value in this parameter will trigger a new session and the client sets a session_start marker (and a first_visit marker as well if the session number equals "1") so GA4 can create the according events needed for attribution and populating source and medium dimensions in GA4.   

walker.js has a "nested" object that can contain e-commerce items. If you plan to **process e-commerce events** and forward them to GA4, check the option to convert "nested" information to "items" and pick a nested object type.

gtag.js usually knows, what events are conversions and sends this information as a marker to GA4 (or a custom endpoint like ssGTM). When using this client to feed GA4, you will have to let ssGTM know what events to handle as a conversion by **defining conversion event names**. Use the list in the client setup to add event names (obe per row) in the same format that the client will generate (after all changes defined in "Event Name Processing" options.)  

## Why Beta?
There are still some things that have to be manually added in any existing implementation in order to fit the client`s expectations about what information gets sent in which section of incoming events. See help for every configurartion field in this client for more information. 

walker.js will be enhanced with some changes that will make the use of this client smoother. If you run into any problems or have ideas how to enhance this client, feel free to contribute or open an issue!

## Contact
Contact [elbwalker](https://www.elbwalker.com/) for anything about walker.js implementation or reach out to [Markus Baersch](https://github.com/mbaersch) or [Justus Blümer](https://github.com/justusbluemer) about anything regarding this client template. 

**Happy Tagging!**