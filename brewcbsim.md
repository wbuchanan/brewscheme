---
layout: page
title: brewcbsim
permalink: /brewbcsim/
---

# BREWCBSIM
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


