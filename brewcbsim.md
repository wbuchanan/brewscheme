---
layout: page
title: brewcbsim
permalink: /help/brewcbsim/
---

<hr>
Simulating color sight impairments on one or more colors
<hr>
  
__brewcbsim__ -- a program to simulate how a given color would be perceived by individuals with achromatopsia, protanopia, deuteranopia, or tritanopia.
 
## Syntax
 
brewcbsim red green blue | named color style
 
## Description
 
brewcbsim is used to simulate how a given color (specified as an RGB tuple in [0,255]) would be perceived by individuals with color sight impairments.
 
## Examples
 
### Ex 1.
Green channel dominant color.

```Stata 
brewcbsim 63 210 142
```

![brewcbsimEx1](../../img/brewcbsimex1.png)

### Ex 2.
Blue channel dominant color.

```Stata 
brewcbsim 8 151 233
```

![brewcbsimEx2](../../img/brewcbsimex2.png)

### Ex 3. 
Red channel dominant color

```Stata 
brewcbsim 182 33 43
```   

![brewcbsimEx3](../../img/brewcbsimex3.png)

### Ex 4. 
An XKCD named color style, with green, blue, and red dominant colors, and a StataCorp named colorstyle

```Stata
brewcbsim xkcd119 "63 210 142" "8 151 233" "182 33 43" bluishgray8
```   

![brewcbsimEx4](../../img/brewcbsimex4.png)

### Ex 5.
Colors that are typically associated with sensitivity to color perception

```Stata
brewcbsim red green blue yellow
```

![brewcbsimEx5](../../img/brewcbsimex5.png)

## Returned Values

<table>
<th>Macro Name</th><th>Value</th> 
<tr><td>r(original#)</td><td>The RGB value for the nth color passed to the command</td></tr>
<tr><td>r(achromatopsic#)</td><td>Transformed RGB value for the nth color (Complete Color Vision Loss)</td></tr>
<tr><td>r(protanopic#)</td><td>Transformed RGB value for the nth color (Red Color Impairment)</td></tr>
<tr><td>r(deuteranopic#)</td><td>Transformed RGB value for the nth color (Green Color Impairment)</td></tr>
<tr><td>r(tritanopic#)</td><td>Transformed RGB value for the nth color (Blue Color Impairment)</td></tr>
</table>
 
## References
[Lindbloom, B. (2001).  RGB working space information. Retrieved from: http://www.brucelindbloom.com/WorkingSpaceInfo.html.  Retrieved on 24nov2015.](http://www.brucelindbloom.com/WorkingSpaceInfo.html)

[Meyer, G. W., & Greenberg, D. P. (1988). Color-Defective Vision and Computer Graphics Displays. *Computer Graphics and Applications, IEEE 8(5),* pp. 28-40.](http://www-users.cs.umn.edu/~meyer/papers/meyer-greenberg-cga-1988.pdf)

[Smith, V. C., & Pokorny, J. (2005).  Spectral sensitivity of the foveal cone photopigments between 400 and 500nm.  *Journal of the Optical Society of America A, 22(10),* pp. 2060-2071.](http://macboy.uchicago.edu/~eye1/PDF%20files/Smith%20Pokorny%2075.pdf)

[Wickline, M. (2014).  Color.Vision.Simulate, Version 0.1.  Retrieved from: http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js.  Retrieved on: 24nov2015](http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js)

