## Quick Demo Setup Info
The "examples" folder contains a demo implementation that can be used to send test events to your own endpoint. It is not a "production ready" init script but you can build your own implementation and walker destination setup in a similar way to make sure that the client template gets all data needed to be processed by GA4- 

- create a new client template in ssGTM and import tpl file
- upload demo page and init script to a web server (or test locally) and adjust the endpoint URL in the demo page (use `data-endpoint` attribute) to match your ssGTM
- open page in a web browser and see events occur in the console and get sent to ssGTM
- debug ssGTM in preview to see events and event data

## Transport Options
The init script can be configured to use POST instead of GET requests when sending events to the ssGTM destination by adding `data-sendimg="false"`. You can also switch off base64 coding by adding  a `data-base64="false"` attribute. 

See source code for more information about how to use the ssGTM client template and sample init script to load and configure walker.js for sending events to ssGTM.  

## Sending Events Suitable For GA4
In this example you will find a few elements and event parameters that are neccessary to feed GA4 with enough information to process every event like it was sent by gtag.js. 

### Globals
`init-walker.js` adds some (span) elements to the DOM to set sole global values that will travel with avery event in the `globals` section. They are there to make sure that every event (not just a *page view*) includes the basic attributes that evey event should have. Those are:

- page_location
- page_title 
- page_referrer

Since `walker.js` will add some changes that will make setting those attributes easier, the current setup of the init script is some kind of workaround for GA4. 

Additionaly there is a key called `analytics_consent` that serves as a replacement for a real implementation of a field that allows to know and respect what can be done with every event ehen it hits se server-side GTM container.  

### Session Handling
Whatever tags are used to process the walker-js events on the server, most of them will need a session id and / or a client id in oder to work. For GA4, events must contain two additional attributes: 

- a marker that indicates whenever a new session starts in the browser
- a session number that increases for every user with every new session

gtag.js takes care of those things when used to create tracking requests for Google Analytics or a server-side GTM. Every implementation of walker.js as a replacement for gtag.js will have to add those attributes as well. This exaple uses the following fields, so that the ssGTM client can create data in the event model that is suitable for GA4: 

- session_started
- session_number
- session_start

where `session_started` is a timestamp that is used as first choice for a sesion id (not user.hash which is only a fallback value). This is done to primarily send a timestamp as session id to GA4. If GA4 is not your target, you can omit all those parameters and still get everything you probably need to run server-side tags. 

See the [README file](https://github.com/elbwalker/sgtm-client-template#readme) for the client template for more about what values are expected in which keys for a robust GA4 data flow from walker.js to your analytics reports.  