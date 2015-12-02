---
layout: page
title: brewcbsim
permalink: /brewcbsim/
---

This program is analogous to [brewviewer](https://wbuchanan.github.io/brewscheme/brewviewer) but with a focus on illustrating the way color may be perceived by individuals with various types of color sightedness impairments.  The current iteration of the program only shows a single color at a time, but future versions will expand on this capability.  The use of the program is fairly simple:

## Ex 1. Green channel dominant color

```   
brewcbsim 63 210 142
```   

![brewcbsim Example 1](../img/brewcbsimex1.png)


## Ex 2. Blue channel dominant color

```   
brewcbsim 8 151 233
```   

![brewcbsim Example 2](../img/brewcbsimex2.png)


## Ex 3. Red channel dominant color

```   
brewcbsim 182 33 43
```   

![brewcbsim Example 3](../img/brewcbsimex3.png)


## Additional Info
The program is a wrapper around a Mata function `translateColor` that takes three arguments for the levels of the red, green, and blue color channels.  The function itself is a wrapper around the `colorblind` class Mata object and associated methods.  For additional information, see the source code in colorblind.mata.


## References
[Lindbloom, B. (2001).  RGB working space information. Retrieved from: http://www.brucelindbloom.com/WorkingSpaceInfo.html.  Retrieved on 24nov2015.](http://www.brucelindbloom.com/WorkingSpaceInfo.html)

[Meyer, G. W., & Greenberg, D. P. (1988). Color-Defective Vision and Computer Graphics Displays. *Computer Graphics and Applications, IEEE 8(5),* pp. 28-40.](http://www-users.cs.umn.edu/~meyer/papers/meyer-greenberg-cga-1988.pdf)

[Smith, V. C., & Pokorny, J. (2005).  Spectral sensitivity of the foveal cone photopigments between 400 and 500nm.  *Journal of the Optical Society of America A, 22(10),* pp. 2060-2071.](http://macboy.uchicago.edu/~eye1/PDF%20files/Smith%20Pokorny%2075.pdf)

[Wickline, M. (2014).  Color.Vision.Simulate, Version 0.1.  Retrieved from: http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js.  Retrieved on: 24nov2015](http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js)

