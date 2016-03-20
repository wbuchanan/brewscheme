---
layout: page
title: brewmeta
permalink: /help/brewmeta/
---


<hr>
Command to look up meta characteristics for colors/palettes available to brewscheme
<hr>

<br> 
__brewmeta__ -- A Stata interface to color property palettes developed by Cynthia Brewer (Color Brewer).
 
## Syntax
 
brewmeta palette name, colorid(integer) [ colors(integer) <u>prop</u>erties("", "all",
 "colorblind", "lcd", "print", "photocopy", "meta") ]
 
## Description
 
brewmeta is used to look-up the available meta data on the "friendliness" properties of the various color palettes and includes an option to look up those meta data on the fly.
 
## Options
 
colorid is a required argument indicating the number of the colors within the palette for which you would like to know about the meta data properties. For additional control, users may specify a specific number of colors within a palette to look up these values.
 
colors is an optional argument indicating the maximum number of colors from the specified palette from which to look up the properties of the color identified by colorid. If no value is passed to this argument, the maximum number of colors available in the palette are assumed. Note: this is particularly important for divergent color palettes where colors may be added/subtracted from the palette in order to preserve balance across the palette.
 
<u>prop</u>erties is an optional arguement used to look up a specific property for the color palette.  If nothing is specified, the program will assume you would like to see the results for all of the properties. The table below illustrates the types of results that can be expected to be retrieved from this functionality:
 
<table style="width:100%">
<th style="border-top: 1px solid black; border-bottom: 1px solid black">Argument</th><th style="border-top: 1px solid black; border-bottom: 1px solid black">Resulting Output</th>
<tr><td>all*</td><td>Displays all information below</td></tr>
<tr><td>colorblind*</td><td>Colorblind friendliness indicator</td></tr>
<tr><td>lcd*</td><td>LCD friendliness indicator</td></tr>
<tr><td>print*</td><td>Print friendliness indicator</td></tr>
<tr><td>photocopy*</td><td>Photocopier friendliness indicator</td></tr>
<tr><td style="border-bottom: 1px solid black">meta*</td><td style="border-bottom: 1px solid black">Additional information about colors/palette</td></tr>
</table>
<em>* Information is displayed if available for the given color/palette</em>
 
## Examples

### Ex 1. 
Determine if a color palette with 9 colors (of a potential 12 total) from the paired ColorBrewer palette is colorblind, lcd, print, or photocopy friendly and also identify the type of scale the palette is used for:

```Stata 
. brewmeta "paired", colorid(9) colors(12)
The color 9 of palette paired with 12 colors is Not color blind friendly
The color 9 of palette paired with 12 colors is LCD friendly
The color 9 of palette paired with 12 colors is Missing Data on Photocopier Friendliness
The color 9 of palette paired with 12 colors is Possibly print friendly
The color 9 of palette paired with 12 colors is Qualitative
```

### Ex 2.
Get the color blind attribute for the pastel2 palette with 7 colors for color number 5.

```Stata
. brewmeta pastel2, colorid(5) colors(7) prop(colorblind)
The color 5 of palette pastel2 with 7 colors is Not color blind friendly
```

### Ex 3.
Get the meta attribute for the dark2 palette with maximum number of colors for the third color.

```Stata
. brewmeta dark2, colorid(3) prop(meta)
The color 3 of palette dark2 with 7 colors is Qualitative
```


### Ex 4.
Get all of the attributes for the puor palette with the maximum number of colors for the 6th color.

```Stata
. brewmeta puor, colorid(6)
The color 6 of palette puor with 10 colors is Missing Data on Colorblind Friendliness
The color 6 of palette puor with 10 colors is LCD friendly
The color 6 of palette puor with 10 colors is Not photocopy friendly
The color 6 of palette puor with 10 colors is Possibly print friendly
The color 6 of palette puor with 10 colors is Divergent
```

### Ex 5.
Try with a color palette that does not have the available metadata.

```Stata
. brewmeta tableau, colorid(12)
The color 12 of palette tableau with 20 colors is 
The color 12 of palette tableau with 20 colors is 
The color 12 of palette tableau with 20 colors is 
The color 12 of palette tableau with 20 colors is 
The color 12 of palette tableau with 20 colors is 
```

This returns no information other than the tag that opens each result line, but does not provide any indication as to whether or not a specific property exists or what the value may or may not be.  This was done to provide users with some way to confirm that the program did successfully execute and also provide a reminder that for this instance, no meta properties were available.


## Additional information 

Using a 15" early 2013 MacBook Pro w/Retina with a 2.8 GHz Intel Core i7 chipset, 16 GB 1600 MHz DDR3, and Intel HD Graphics 4000 1024 MB graphics card running Stata MP8, the command will typically take < 5 seconds with a decent Wi-Fi connection.  The first time the look up table is built and when the refresh option are used, you should expect to see the performance dip slightly.  Look ups take < 1 second on my system and will likely take a similar amount of time on others as well.
 
## References
[Bostock, M., Ogievetsky, V., & Heer, J. (2011).  D3: data driven documents. *IEEE Transactions on Visualization & Computer Graphics. 17(12)* pp 2301 - 2309. Retrieved from http://vis.stanford.edu/papers/d3](http://vis.stanford.edu/papers/d3)  

[Brewer, C. A. (2002). Color Brewer 2. [Computer Software]. State College, PA: Cynthia Brewer, Mark Harrower, and The Pennsylvania State University](http://www.ColorBrewer2.org)

[Lin, S., Fortuna, J., Kulkarni, C., Stone, M., {c 38} Heer, J. (2013). Selecting Semantically-Resonant Colors for Data Visualization. *Computer Graphics Forum 32(3)* pp. 401-410.  Retrieved from http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf](http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf)
 
## License
Please view  section 4 of the ColorBrewer copyright notice for additional information pertaining to the licensing and redistribution of ColorBrew intellectual property.
 
