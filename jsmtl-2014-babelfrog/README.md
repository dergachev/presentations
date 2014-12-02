<div style="position: absolute; height: 97%; width: 90%;">
<h2 style="margin:30px auto 100px auto; font-size:2.2em; font-weight:bold; float:right;">
  BabelFrog, and Writing Chrome Extensions
</h2>
  <code style="float:right; font-size:0.7em; clear:both; text-align: right;">
    <div style="font-size:1.2em; font-weight:bold;">Alex Dergachev</div>
    <div> alex@evolvingweb.ca </div>
    <div> <a href="https://github.com/dergachev">github.com/dergachev</a> </div>
    <div> <a href="https://twitter.com/dergachev">twitter.com/dergachev</a> </div>
    <div> Co-founder at <a href="http://evolvingweb.ca">Evolving Web</a> </div>
  </code>
<img src="resources/img/ew-good.png" style="height:130px; margin: 10px 0 0 0; position: absolute; bottom: 0;">
</div>

--end--

## About BabelFrog 

- Demo
- Why I wrote it
- What it does
- How it works

--end--

## BabelFrog Demo

BabelFrog is a light-weight Chrome extension that helps you read foreign websites by translating the text you select, not the whole page.

![](http://babelfrog.com/img/babelfrog-demo-4.gif)

--end--

## BabelFrog Demo

It's super-simple. Here are all the options.

![](http://babelfrog.com/img/babelfrog-settings.png)

BabelFrog supports translating to-and-from any of the 348 languages supported by [Google Translate](http://translate.google.ca/about/intl/en_ALL/#supportedLangs).

--end--

## Installing BabelFrog

- Visit [babelfrog.com](http://babelfrog.com), one-click install.
- Source code: [https://github.com/dergachev/babelfrog](https://github.com/dergachev/babelfrog)
- Try it out:
  - [/r/quebec](http://reddit.com/r/quebec)
  - [Le Navet](http://lenavet.ca/4365/le-peage-du-pont-maurice-richard-sera-gratuit-lorsque-le-canadien-marquera-cinq-buts-ou-plus/)

--end--

## Why I Wrote It

- planned my wedding using Google Translate built-in to Chrome, but found limitations
- help my dad read English webpages
- help me read French webpages
- most other similar tools had bad UX, including the [official Google Translate chrome extension](https://chrome.google.com/webstore/detail/google-translate/aapbdbdomjkkjkaonfhkkikfgjllcleb?hl=en)

--end--

## What It Does

- Install, then pick language TO and FROM
- To activate on given page 
  - click on icon, or
  - right-click for context menu, or 
  - CMD-E keyboard shortcut
- Select text to translate (double clicking on a word selects it)
- Optionally, reads selected text aloud (in the original language)
- Nothing else. KISS

--end--

## How It Works

- Uses the (currently publicly open and free) ajax endpoint for translate.google.com webpage.
  - I prototyped it using the Google Translate API (paid: ~100 words for 1 cent)
  - I also made bing version, free but awkward signup for each user.
  - In the end, free and simple is better
- Cross-domain ajax request (only Chrome extensions can do that, see permissions)
- Uses their text-to-speech API to read selected text aloud, for better recall.

--end--

## BabelFrog as a business

- No plans to monetize, this is an experiment
- Possible to get a few hundred thousand users, exciting as marketing experiment
- Who knows what I can pivot this into (integration with other lookup services?)

--end--

## BabelFrog - Future Features

- auto-detect language
- sentence parsing (in English only?)
- persistent activation
- social features?
- support for CJK langs
- other translation/lookup engines (Genius.com?)

--end--

## About Chrome Extensions

- Use cases / examples
- What they can do
- How they work
- How to install / manage
-- "Load unpacked extension"

--end--

## Use cases / Examples

Here are some extensions I use, let's see what they do:

- AdBlock
- OneTab
- LastPass
- Google Hangouts
- Reddit Enhancement Suite
- Pinterest

--end--

## What Extensions Can Do

- inject CSS/JS into any page
- mangle every request in chrome
- make cross-domain ajax (requires asking for permissions)
- manipulate chrome tabs (open, close, rearrange)
- store user data persistently (settings, localStorage, etc)

--end--

## How Extensions Work

- UI
  - browser action, page action, search bar, keyboard shortcuts, desktop navigations, options page
  - inject UI into active page
- pass messages
- shadow DOM
- permissions
- auto-update

--end--

## Before writing an extension

- bookmarklet
- tampermonkey
- http://extensionizr.com/
- https://developer.chrome.com/extensions/getstarted

--end--

## Writing your own chrome extension

- [Link To Element](https://github.com/dergachev/link-to-element) extension
- manifest.json, permissions
- background.js
- chrome.* APIs
- debugging

--end--

## **manifest.json**

- metadata (name, icons, version)
- permissions
- injected scripts

--end--

## **background.js**

- runs in the background (like a hidden iframe / tab)
- can access chrome APIs (trusted)
- can pass messages to specially-crafted "content scripts"

--end--

## **link-to-element.js**

- injected into the page
- listens to messages
- shadow DOM

--end--

## Debugging

- console
- background console
- refreshing code
- not work on chrome:// or chrome web store
- shadow DOM


--end--

## Best practices

- security
- performance
- updates / Chrome Web Store
- keyboard shortcuts
- marketing / Chrome Web Store

--end--

## Publishing

- Chrome Web Store
  - extensions vs apps
- [BabelFrog DEVNOTES](https://github.com/dergachev/babelfrog/blob/master/DEVNOTES.md)

--end--

## Thank you!!

- Any questions?
- **Now go write a Chrome extension!!!**

--end--
