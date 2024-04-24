<p align="left">
  <a href="https://elbwalker.com">
    <img title="elbwalker" src='https://www.elbwalker.com/elbwalker.png' width="300px"/>
  </a>
</p>

# elbwalker Server Side Google Tag Manager Custom Client Template
Custom client template for Server Side Google Tag Manager (SGTM).  
Receives walker.js events and optionally serves walker.js script. Optimized for use as gtag.js replacement for GA4.  

Features:

* Serving your walker.js script through SGTM
* Automatic Session and Client ID handling
* Event name processing
* Advanced settings for custom event model mapping
* GA4 specific settings

[![Beta Status](https://img.shields.io/badge/Status-Beta-yellow.svg)](https://shields.io/)

## Installation

<details>
<summary>Show installation instructions</summary>
This template is not yet available in SGTM's Community Gallery due to currently long review times. Instead, you can install it manually by following these steps:

1. Download this repository by clicking the green "Code" button and selecting "Download ZIP".  
    <a href="https://user-images.githubusercontent.com/6085647/206726857-7cbcce43-6ebc-4249-a593-14e87e044a72.png">
        <img title="elbwalker" src='https://user-images.githubusercontent.com/6085647/206726857-7cbcce43-6ebc-4249-a593-14e87e044a72.png' width="300px"/>
    </a>
2. Unzip the downloaded file.
3. In the SGTM UI, click the *Templates* menu item and in the *Client Templates* section click *New*.
4. Click the "Import" button in the context menu and select the `template.tpl` file from the unzipped folder.
    <a href="https://user-images.githubusercontent.com/6085647/206726854-62f5f083-fb3d-4b4c-9fec-29d0cbc11e0f.png">
        <img title="elbwalker" src='https://user-images.githubusercontent.com/6085647/206726854-62f5f083-fb3d-4b4c-9fec-29d0cbc11e0f.png' width="300px"/>
    </a>
</details>

## Client Configuration
After installing the template, a new client can be created in SGTM. The client has several groups of settings.

### walker.js Proxy & 1st party serving
[walker.js](https://github.com/elbwalker/walker.js) is the script that you'll need to load to collect data in the browser and send it to SGTM.  

If you don't want to host a copy of walker.js on your own, the SGTM client will load the specified version from JSDELIVR's CDN and proxy it through your SGTM. This makes walker.js available in a first party context, if your SGTM runs on a first party domain.  
You can define the behavior of the proxy in the client configuration:

* **Maximum Cache Age**:  
The client uses SGTM template storage to cache the script. This setting defines the maximum age of the cached script in milliseconds.
* **Path**:  
Allows you to choose a custom filename, if you don't want to use `/walker.js`.
* **Version**:  
The version of walker.js to load from CDN. Only select "latest" during development and testing. In production, always use a specific version number to avoid unexpected breaking changes.

### Session & Client IDs
Depending on your usage and client-side utilization of walker events and user / session handling, there are several ways of extracting a session id, number (mainly for the use with GA4) and a client id. 

The minimal needed identifier would be a session id that can be used in order to have a common id for every hit that belongs to the same session / browser / visit. If there is no client id, the session id will serve as fallback. 

Choose between cookies, walker event data or a custom definition for getting session and client data. In every case you can define how incoming events should be handled when setting:

- session id
- session number
- client id

### Event Name Processing
walker.js events usually have a different format than the tags in SGTM expect.  
As most tags expect an incoming GA4 stream, you can use different methods for adjusting event names. The easy way is to replace all whitepaces with an "_" and lowercase the event name. This would make a "page view" from elwalker to appear as "page_view" in the SGTM event model. 

Alternatively you can translate every incoming event name to a new one in order to match your requirements. 

### Advanced Settings
The advanced section allows to define different parameters that control what happens with incoming requests. It is possible to include a fully nested copy of the walker.js event in the event model. This might be useful if you want to forward all event data directly into a first party database like Google BigQuery. Or in case that specific data should be extracted from the event and used to provide values for an advanced tag configuration.

Adding information from the "context" and "globals" section of incoming events can be used to create a "flat" event model that might fit your needs in a better way than the client template automatically maps some of the (expected) event properties (for a page_location, page_title, page_referrer and others for example).

#### GA4 Specific Settings
The client expects a **marker for detecting a new session** somewhere in the incoming event data. The default path can be changed to sync the client with your implementation. Any "truthy" value in this parameter will trigger a new session and the client sets a session_start marker (and a first_visit marker as well if the session number equals "1") so GA4 can create the according events needed for attribution and populating source and medium dimensions in GA4.   

walker.js has a "nested" object that can contain e-commerce items. If you plan to **process e-commerce events** and forward them to GA4, check the option to convert "nested" information to "items" and pick a nested object type.

gtag.js usually knows, what events are conversions and sends this information as a marker to GA4 (or a custom endpoint like SGTM). When using this client to feed GA4, you will have to let SGTM know what events to handle as a conversion by **defining conversion event names**. Use the list in the client setup to add event names (obe per row) in the same format that the client will generate (after all changes defined in "Event Name Processing" options.)  

## Why Beta?
There are still some things that have to be manually added in any existing implementation in order to fit the client`s expectations about what information gets sent in which section of incoming events. See help for every configuration field in this client for more information. 

walker.js will make the use of this client as easy as possible. Still, using walker.js for GA4 needs some additional information (see example). If you run into any problems or have ideas how to enhance this client, feel free to contribute or [open an issue](https://github.com/elbwalker/sgtm-client-template/issues/new)!

## Release Notes
*2024-01-23*
- changed default walker.js version to 2.0.0
- adjustments for receiving and setting version information to fit 2.x (still compatible with older versions)
- processing options for `custom` object from walker.js 2.x

*2024-04-24*
- **IMPORTANT**: changed method for defining sources for session ID, session number, client ID & session starts
- no Universal Analytics event parameters `action`, `category`, `label`  
- fixed error when getting session number from cookie

## Contact
Contact [elbwalker](https://www.elbwalker.com/) for anything about walker.js implementation or reach out to [Markus Baersch](https://github.com/mbaersch) or [Justus Blümer](https://github.com/justusbluemer) about anything regarding this client template. 

**Happy Tagging!**
