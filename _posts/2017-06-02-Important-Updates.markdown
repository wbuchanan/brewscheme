---
layout: post
title:  "Important Update"
date:   2017-06-02 14:30:00
categories: news
---

# Updates
A [StataList](http://www.statalist.org) user recently alerted me to a problem with a [different program](https://wbuchanan.github.io/StataJSON) that ended up being related to [brewscheme](https://wbuchanan.github.io/brewscheme).  I will be working to package up an update to submit to the SSC archives, but recommend all users to update/upgrade their copy of brewscheme to avoid any potential issues if you use other programs that rely on the Java API that I've developed.


```Stata
net inst brewscheme, from("https://wbuchanan.github.io/brewscheme/") replace
```

