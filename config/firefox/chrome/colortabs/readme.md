# Color-tag-tabs (CTT)

## Description

CTT is by itself completely useless extension for Firefox. CTT registers a content_script to be run on every web-page which does these three things:

* Extract color information from either page meta tags, or favicon.
* Sets prefix for window title describing that color **invisible characters**
* overwrite document.title setter and getter to make it so the prefix is not modified and is "invisible" for page scripts.

## Make it usable!

To make this actually doo something you would apply the CSS from [colorize_tab_from_prefix.css](./css/colorize_tab_from_prefix.css) by using userChrome.css

After restarting Firefox the tabs should get colorized by some color that the extension extracted from the page. That extracted color may or may not be what you expected though - this is just a proof-of-concept and heuristics are super simple.
