---
layout: page
title: brewcbsim
permalink: /brewcbsim/
---

# Updates
The functionality previously mentioned on this page has been implemented.  Below are a couple of examples (based on the previous examples) that show how the program handles multiple color - and color type - arguments now.  

## Ex 1. An XKCD named color style, with green, blue, and red dominant colors, and a StataCorp named colorstyle

```   
brewcbsim xkcd119 "63 210 142" "8 151 233" "182 33 43" bluishgray8
```   

![brewcbsim Example 1](../img/brewcbsimex4.png)


## Ex 2. Colors that are typically associated with sensitivity to color perception

```   
brewcbsim red green blue yellow
```   

![brewcbsim Example 2](../img/brewcbsimex5.png)



# Deprecated info

This program is analogous to [brewviewer](https://wbuchanan.github.io/brewscheme/brewviewer) but with a focus on illustrating the way color may be perceived by individuals with various types of color sightedness impairments.  The current iteration of the program only shows a single color at a time, but future versions will expand on this capability.  The use of the program is fairly simple:

## Ex 3. Green channel dominant color

```   
brewcbsim 63 210 142
```   

![brewcbsim Example 3](../img/brewcbsimex1.png)


## Ex 4. Blue channel dominant color

```   
brewcbsim 8 151 233
```   

![brewcbsim Example 4](../img/brewcbsimex2.png)


## Ex 5. Red channel dominant color

```   
brewcbsim 182 33 43
```   

![brewcbsim Example 5](../img/brewcbsimex3.png)

## References
[Lindbloom, B. (2001).  RGB working space information. Retrieved from: http://www.brucelindbloom.com/WorkingSpaceInfo.html.  Retrieved on 24nov2015.](http://www.brucelindbloom.com/WorkingSpaceInfo.html)

[Meyer, G. W., & Greenberg, D. P. (1988). Color-Defective Vision and Computer Graphics Displays. *Computer Graphics and Applications, IEEE 8(5),* pp. 28-40.](http://www-users.cs.umn.edu/~meyer/papers/meyer-greenberg-cga-1988.pdf)

[Smith, V. C., & Pokorny, J. (2005).  Spectral sensitivity of the foveal cone photopigments between 400 and 500nm.  *Journal of the Optical Society of America A, 22(10),* pp. 2060-2071.](http://macboy.uchicago.edu/~eye1/PDF%20files/Smith%20Pokorny%2075.pdf)

[Wickline, M. (2014).  Color.Vision.Simulate, Version 0.1.  Retrieved from: http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js.  Retrieved on: 24nov2015](http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js)

