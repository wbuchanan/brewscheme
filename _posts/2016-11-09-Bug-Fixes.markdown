---
layout: post
title:  "Bug Fixes"
date:   2016-11-09 06:15:00
categories: news
---

# Updates
Just pushed changes to a related utility project called [dirfile](https://github.com/wbuchanan/dirfile).  The command now uses a recursive descent pattern to traverse the file system from a given root node and provides options that allow the end-user to select which files in the directory tree are retained/deleted when specifying the rebuild option.  This also meant updating the API for the command, hence the changes to `brewscheme`.  

These changes are primarily intended to help fix some of the outstanding bugs identified in [issue #53](https://github.com/wbuchanan/brewscheme/issues/53) and [issue #52](https://github.com/wbuchanan/brewscheme/issues/52).  This update can be considered a test and there may be new bugs related to the calls to dirfile used internally in the commands included with `brewscheme`.  All of the calls were updated/modified, but any end-users that can assist in testing this on their systems would be greatly appreciated (particularly users working on Windows platforms since this seems to be the root cause for many of the issues related to the bug reported in [issue #53](https://github.com/wbuchanan/brewscheme/issues/53)).


```Stata
net inst brewscheme, from("https://wbuchanan.github.io/brewscheme/") replace
```

