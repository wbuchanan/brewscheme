---
layout: page
title: brewsearch
permalink: /help/brewsearch/
---


<hr>
Query color sight impairment values that were previously computed and return in macros.
<hr>
  
__brewsearch__ -- is a program used to query brewscheme data sources to retrieve RGB values and/or simulated RGB values for different forms of color sight impairment.
 
## Syntax
 
brewsearch RGB_varname
 
## Description
 
__brewsearch__ is a simple program used to search for a color by RGB value or the name of the color and will return the local macros: rgb, achromatopsia, protanopia, deuteranopia, and tritanopia.

## Returned Values

<table>
<th>Macro Name</th><th>Value</th>
<tr><td>r(rgb)</td><td>RGB value looked up by command</td></tr>
<tr><td>r(achromatopsia)</td><td>Achromatopsia simulated RGB value</td></tr>
<tr><td>r(protanopia)</td><td>Protanopia simulated RGB value</td></tr>
<tr><td>r(deuteranopia)</td><td>Deuteranopia simulated RGB value</td></tr>
<tr><td>r(tritanopia)</td><td>Tritanopia simulated RGB value</td></tr>
</table>
 

## Examples

### Ex 1.
Search for a color using RGB values

```Stata
// Search an RGB color string
brewsearch "255 127 14"

// Display the returned values
ret li

macros:
         r(tritanopia) : "255 117 126"
       r(deuteranopia) : "206 153 0"
         r(protanopia) : "183 162 25"
      r(achromatopsia) : "146 146 146"
                r(rgb) : "255 127 14"
```


### Ex 2. 
Example of how errors (e.g., unfound colors) are handled

```Stata
// Search a named color style that does not exist on the system
brewsearch "xkcd7327"

// Display the returned values
ret li

macros:
         r(tritanopia) : "xkcd7327"
       r(deuteranopia) : "xkcd7327"
         r(protanopia) : "xkcd7327"
      r(achromatopsia) : "xkcd7327"
                r(rgb) : "xkcd7327"
```                

### Ex 3.
Search for an xkcd named color style

```Stata 
// Search a named color style that does exist if the user installed the XKCD colors
brewsearch "xkcd327"

// Display the returned values
ret li

macros:
         r(tritanopia) : "198 236 255"
       r(deuteranopia) : "255 218 50"
         r(protanopia) : "255 231 0"
      r(achromatopsia) : "218 218 218"
                r(rgb) : "168 255 4"
```

### Ex 4.
Search for a Stata named color style

```Stata
// Display a known color style
brewsearch "ltbluishgray"

// Display the returned values
ret li

macros:
         r(tritanopia) : "236 239 255"
       r(deuteranopia) : "255 232 245"
         r(protanopia) : "244 239 241"
      r(achromatopsia) : "240 240 240"
                r(rgb) : "234 242 243"
```
 
