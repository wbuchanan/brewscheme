---
layout: post
title:  "Bug fixes and minor feature additions prior to version 1.0"
date:   2015-12-11 06:10:00
categories: update
---

# Using symbol types
As a way to remind myself to get around to adding this, I submitted a [feature/enhancement request](https://github.com/wbuchanan/brewscheme/issues/18) for handling symbol types in scheme files.  There is now a fix for this on the [symbols branch](https://github.com/wbuchanan/brewscheme/tree/symbols) in brewscheme.ado.  There is an example of how the feature can be used on the [brewtheme](http://wbuchanan.github.io/brewscheme/brewtheme/) page and with a few more tests I anticipate this making it into the release.  

## Other Updates
A few users have had issues with the installation process.  I've tried adding a fix to for this particular issue (caused when there is no personal subdirectory on the ADOPATH) in the [personaldirectory branch](https://github.com/wbuchanan/brewscheme/tree/personaldirectory).  If you have issues getting things installed please submit an issue using these instructions:

```
// Start logging all the output
log using brewschemeIssueLog.txt, text replace

// Print information about your system/Stata
about

// Print the operating system
di `"`c(os)'"'

// Print the system directories
sysdir

// Get the package ID for any existing installations of brewscheme
ado, find(brewscheme)

// Remove any installations that currently exist
// In the syntax below the [] is required and the # should be the number displayed 
// from the command above
ado uninstall [#]

// You may need to repeat the second step a few times.  If there are different installations on your machine
// Once the package has been completely uninstalled:

// Install the current version
net inst brewscheme, from("http://wbuchanan.github.io/brewscheme") rep

// Set the preference for the traceback depth to decend three levels into the program call
set tracedepth 3

// Turn on tracing
set trace on

// Compile the mata libraries
libbrewscheme

// Build out the color database
brewcolordb, ref

// try your commands here


// Close the log file 
log c _all
```

That should provide a fair amount of information that I can use to trace issues and replicate problems that you may have.  In some cases, I may not have access to the operating system you use, but there generally shouldn't be too many issues caused by the OS at this point.



