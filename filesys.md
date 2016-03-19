---
layout: page
title: filesys
permalink: /help/filesys/
---

<hr>
# help for filesys
<hr>
 
__filesys__ -- a Java plugin to access filesystem properties of files.
 
## Syntax
 
__filesys__ <em>filename</em>, [ <u>attr</u>ibutes <u>dis</u>play <u>glo</u>bal <u>r</u>eadable(string) <u>w</u>ritable(string)
<u>x</u>ecutable(string) <u>reado</u>nly ]
 
## Description
 
filesys is designed to provide access to basic file system properties.  In addition, it provides some basic functionality to allow setting properties on files without having to write OS specific code to do the same from the shell.  See return values for additional information regarding the attributes that are exposed from this program.
 
## Options
 
<u>attr</u>ibutes this option is used to retrieve the properties of a file and does not make any modifications to the file system properties for the file.
 
<u>dis</u>play prints a table showing the file system properties to the Results window.
 
<u>glo</u>bal is an option used in conjunction with readable, writable, or xecutable to set the property on/off for all users.
 
<u>r</u>eadable(on|off) is an option used to set the readable property for the file on or off.  If the global option is not specified it will set this property for the current user only.
 
<u>w</u>ritable(on|off) is an option used to set the readable property for the file on or off.  If the global option is not specified it will set this property for the current user only.
 
<u>x</u>ecutable(on|off) is an option used to set the executable property for the file on or off.  (Note: the misspelling here is intended to reflect the way the properties are declared in *nix based systems).  If the global option is not specified it will set this property for the current user only.
 
<u>reado</u>nly is an option used to set the file to readonly mode. There is no option to apply this globally vs locally.
 
## Examples
 
### Ex 1.
View the properties of the auto.dta dataset

```
. filesys `c(sysdir_base)'a/auto.dta, attr dis

------------------------------------
Attribute                File Attribute Value
------------------------------------
Created Date             20nov2015 05:44:54
Modified Date            20nov2015 05:44:54
Last Accessed Date       11dec2015 05:52:23
Absolute File Path       /Applications/Stata/ado/base/a/auto.dta
Canonical File Path      /Applications/Stata/ado/base/a/auto.dta
Parent Path              /Applications/Stata/ado/base/a
File Name                auto.dta
Is Symbolic Link         false
Is Regular File          true
Is Executable            false
Is Hidden                false
Is Readable              true
Is Writable              true
------------------------------------
```

### Ex 2. 
Make the file globally executable

```
. filesys `c(sysdir_base)'a/auto.dta, glo x(on) dis

------------------------------------
Attribute                File Attribute Value
------------------------------------
Created Date             20nov2015 05:44:54
Modified Date            20nov2015 05:44:54
Last Accessed Date       11dec2015 05:52:23
Absolute File Path       /Applications/Stata/ado/base/a/auto.dta
Canonical File Path      /Applications/Stata/ado/base/a/auto.dta
Parent Path              /Applications/Stata/ado/base/a
File Name                auto.dta
Is Symbolic Link         false
Is Regular File          true
Is Executable            true
Is Hidden                false
Is Readable              true
Is Writable              true
------------------------------------
```

### Ex 3. 
Turn off the executable property

```
. filesys `c(sysdir_base)'a/auto.dta, glo x(off) dis

------------------------------------
Attribute                File Attribute Value
------------------------------------
Created Date             20nov2015 05:44:54
Modified Date            20nov2015 05:44:54
Last Accessed Date       11dec2015 05:52:23
Absolute File Path       /Applications/Stata/ado/base/a/auto.dta
Canonical File Path      /Applications/Stata/ado/base/a/auto.dta
Parent Path              /Applications/Stata/ado/base/a
File Name                auto.dta
Is Symbolic Link         false
Is Regular File          true
Is Executable            false
Is Hidden                false
Is Readable              true
Is Writable              true
------------------------------------
``` 
 
### Ex 4.
A few other examples of modifying the attributes of an individual file

```
// Turn on the writable property
. filesys `c(sysdir_base)'a/auto.dta, glo w(on) 
 
// Turn off the writable property
. filesys `c(sysdir_base)'a/auto.dta, glo w(off) 
 
// Turn off the writable property for the current user only
. filesys `c(sysdir_base)'a/auto.dta, w(off) 
 
// Turn on the readable property and suppress output
. filesys `c(sysdir_base)'a/auto.dta, glo r(on)
 
// Turn off the readable property
. filesys `c(sysdir_base)'a/auto.dta, glo r(off)
```

## Returned values
 
<table>
<th>Macro Name</th><th>Value</th>
<tr><td>r(iswritable)</td><td>Boolean indicator if file is writable</td></tr>
<tr><td>r(isreadable)</td><td>Boolean indicator if file is readable</td></tr>
<tr><td>r(parentpath)</td><td>String with path to parent directory</td></tr>
<tr><td>r(ishidden)</td><td>Boolean indicator if file is hidden</td></tr>
<tr><td>r(filename)</td><td>String name of the file w/o filepath</td></tr>
<tr><td>r(isexecutable)</td><td>Boolean indicator if file is executable</td></tr>
<tr><td>r(canonicalpath)</td><td>OS specific absolute path</td></tr>
<tr><td>r(absolutepath)</td><td>Generic absolute path</td></tr>
<tr><td>r(filesize)</td><td>Size of the file in bytes</td></tr>
<tr><td>r(regularfile)</td><td>Boolean indicator if file is a regular file (not directory/symbolic link)</td></tr>
<tr><td>r(symlink)</td><td>Boolean indicator if file is a symbolic link</td></tr>
<tr><td>r(accessednum)</td><td>SIF Value of the last accessed date use %tc for the display format</td></tr>
<tr><td>r(modifiednum)</td><td>SIF Value of the modified date use %tc for the display format</td></tr>
<tr><td>r(creatednum)</td><td>SIF Value of the created date use %tc for the display format</td></tr>
<tr><td>r(accessed)</td><td>String containing the date last modified</td></tr>
<tr><td>r(modified)</td><td>String containing the modified date</td></tr>
<tr><td>r(created)</td><td>String containing the created date</td></tr>
</table>

