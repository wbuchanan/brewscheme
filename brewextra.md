---
layout: page
title: brewextra
permalink: /help/brewextra/
---


<hr>
Command used to build data set containing additional color palettes used by brewscheme.
<hr>
 
__brewextra__ -- A utility for brewscheme that allows users to add data to their local brewscheme database for use creating new scheme files.
 
## Syntax
 
__brewextra__ [, files(string) <u>rep</u>lace ]
 
## Description
 
__brewextra__ is used to build a look-up table of RGB values for palettes as part of the Color Brewer research.  Additionally, the program also parses the available meta data on the "friendliness" properties of the various color palettes and includes an option to look up those meta data on the fly.  Additionally, the program will automatically call the brewextra program to add the other available research-based color palettes to the file when constructed.
 
## Options
 
files is an optional argument used to pass filenames to the program to be added to the local brewscheme data base.  The program also includes some simple validation to hopefully prevent breaking the functionality of `brewscheme`.  Below is the file specification that should guide your construction of files to add to the brewscheme database.
 
<table> 
<th>variable</th><th>storage</th><th>display</th><th>value</th><th></th>
<th>name</th><th>type</th><th>format</th><th>label</th><th>variable label</th> 
<tr><td>palette</td><td>str11</td><td>%11s</td><td></td><td>Name of Color Palette</td></tr>
<tr><td>colorblind</td><td>byte</td><td>%10.0g</td><td>colorblind</td><td>Colorblind Indicator</td></tr>
<tr><td>print</td><td>byte</td><td>%10.0g</td><td>print</td><td>Print Indicator</td></tr>
<tr><td>photocopy</td><td>byte</td><td>%10.0g</td><td>photocopy</td><td>Photocopy Indicator</td></tr>
<tr><td>lcd</td><td>byte</td><td>%10.0g</td><td>lcd</td><td>LCD/Laptop Indicator</td></tr>
<tr><td>colorid</td><td>byte</td><td>%10.0g</td><td></td><td>Within pcolor ID for individual color look ups</td></tr>
<tr><td>pcolor</td><td>byte</td><td>%10.0g</td><td></td><td>Palette by Colors Selected ID</td></tr>
<tr><td>rgb</td><td>str11</td><td>%11s</td><td></td><td>Red-Green-Blue Values to Build Scheme Files</td></tr>
<tr><td>maxcolors</td><td>byte</td><td>%10.0g</td><td></td><td>Maximum number of colors allowed for the palette</td></tr>
<tr><td>seqid</td><td>str13</td><td>%13s</td><td></td><td>Sequential ID for property lookups</td></tr>
<tr><td>meta</td><td>str13</td><td>%13s</td><td></td><td>Meta-Data Palette Characteristics</td></tr>
</table> 
 
<u>rep</u>lace is an optional argument used to rebuild and overwrite the brewextras.dta file containing the additional palettes used by `brewscheme`.
 
## Examples
 
### Ex 1.
Rebuild the additional palettes included in brewscheme
 
```Stata
brewextra, rep
``` 
 
