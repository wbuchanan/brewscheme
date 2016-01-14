---
layout: post
title:  "Version 1.0 Release Candidate available"
date:   2015-12-18 09:00:00
categories: update
---

# NEWS
It's almost that time for a version 1 release.  There is currently no additional development planned for the current version of brewscheme.  All features that were previously posted on todo lists for the project have been implemented and the bug that have been reported have been corrected/addressed.  

The most recent release brings a few minor changes to some of the functionality of the brewcbsim program, but the remaining changes take place on the backend and/or here on the project page.  

## brewcbsim updates
`brewcbsim` now handles multiple colors and is allows users to pass either a named color style or an RGB string.  

```   
brewcbsim xkcd119 "63 210 142" "8 151 233" "182 33 43" bluishgray8
```   

![brewcbsim](../../../../img/brewcbsimex4.png)

## Other updates
The other updates that have been made are intended to make it easier for the end user to install/maintain the software.  `brewlibcheck` leverages `filesys.ado` and the associated Java plugin to test whether or not the `libbrewscheme` Mata library is up to date - and if not to compile the Mata source code into the library for you.


