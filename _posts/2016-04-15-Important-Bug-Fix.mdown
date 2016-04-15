---
layout: post
title:  "Important Bug Fix"
date:   2016-04-15 04:15:00
categories: news
---

In the past few weeks a few small bugs have been found and eliminated.  There are four minor fixes that will likely not affect most users.  

1. These fixes force `brewcolordb` to create the PERSONAL directory on the ADOPATH if it does not exist before trying to build out the color dataset (see [issue #45](https://github.com/wbuchanan/brewscheme/issues/45) and [issue #46](https://github.com/wbuchanan/brewscheme/issues/46) for additional information).  

2. The `brewcolors` command was not correctly parsing/naming user defined colors that did not include a name (see [issue #44](https://github.com/wbuchanan/brewscheme/issues/44))

3. Network installations to other directories on the ADOPATH caused `brewlibcheck` to fail to find the libbrewscheme Mata library (see [issue #43](https://github.com/wbuchanan/brewscheme/issues/4))

4. If the system was set up with the `set varabbrev off` preference the `brewscheme` command would fail when calling `brewtheme` due to the newlines variable being referenced as 'newline' one one of the lines of code in the .do file (see [issue #43](https://github.com/wbuchanan/brewscheme/issues/4))

A more important bug that affects how `brewscheme` generates the scheme files was also identified and any/all users should plan to update their installations ASAP.

While the bug was identified in relation to the [D3js](https://www.d3js.org) category10 palette, the issue is likely to have impacted other palettes as well (see [issue #42](https://github.com/wbuchanan/brewscheme/issues/42)).  In short, `brewscheme` relied on the `levelsof` command internally to access the RGB values for a given palette, which automatically sorted the returned values.  This caused palettes like category10 to display the colors incorrectly.  The reliance on `levelsof` has been removed and a new method has been added to the `brewcolors` class to handle accessing the palettes in the correct order.  

```Stata
net inst brewscheme, from("https://wbuchanan.github.io/brewscheme/") replace
```

