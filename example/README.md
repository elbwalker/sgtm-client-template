## Quick Demo Setup Info
The "examples" folder contains a demo implementation that can be used to send test events to your own endpoint. It is no "production ready" init script but you can build your own implementation and walker destination setup in a similar way to make sure that the client template gets all data needed to be processed by GA4- 

- create a new client template in ssGTM and import tpl file
- upload demo page and init script to a web server (or test locally) and adjust the endpoint URL in the demo page (use `data-endpoint` attribute) to match your ssGTM
- open page in a web browser and see events occur in the console and get sent to ssGTM
- debug ssGTM in preview to see events and event data

## Transport Options
The init script can be configured to use POST instead of GET requests when sending events to the ssGTM destination by adding `data-sendimg="false"` . You can also switch off base64 coding by adding  a `data-base64="false"` attribute. 

See source code for more information about how to use the ssGTM client template and sample init script to load and configure walker.js for sending events to ssGTM.  
