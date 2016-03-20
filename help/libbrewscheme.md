---
layout: page
title: libbrewscheme
permalink: /help/libbrewscheme/
---

<hr>
Mata library for brewscheme
<hr>

<br>
<strong>libbrewscheme</strong> -- compiles the libbrewscheme Mata library and displays this help file.

## Syntax

<strong>libbrewscheme</strong> [, <u>dis</u>play <u>rep</u>lace <u>si</u>ze(integer) ]

## Description

libbrewscheme wrapper used to compile libbrewscheme.mlib locally.  This help file defines the objects and methods defined in the library.

## Options

<u>dis</u>play is an optional argument to display this help file after compiling the Mata library.

<u>rep</u>lace is an optional argument used to overwrite an existing copy of the library.

<u>si</u>ze is an optional argument passed to mata mlib create to set the maximum number of members of the library.




<h2>Mata Object and Method Information</h2>




<h2>Colorblindness Type Class</h2>

An object type used in a way that is analogous to an interface class in Java.


<h3>Colorblindness Type Members</h3>

<strong>x</strong> a member variable used for transforming RGB values for different forms of color sight impairments.
<strong>y</strong> a member variable used for transforming RGB values for different forms of color sight impairments.
<strong>m</strong> a member variable containing the slope used for transforming RGB values for different forms of color sight impairments.
<strong>yint</strong> a member variable containing the intercept used for transforming RGB values for different forms of color sight impairments.


<h3>Colorblindness Type Methods</h3>

<em>getConfuseX()</em> method used to access/retrieve the x member variable.
<em>getConfuseY()</em> method used to access/retrieve the x member variable.
<em>getConfuseM()</em> method used to access/retrieve the x member variable.
<em>getConfuseYint()</em> method used to access/retrieve the x member variable.
<em>setConfuseX()</em> method used to set the x member variable.
<em>setConfuseY()</em> method used to set the y member variable.
<em>setConfuseM()</em> method used to set the slope member variable.
<em>setConfuseYint()</em> method used to set the intercept member variable.



<h2>Protanopia Class</h2>

An object inheriting from the cbtype class with data specific to red color blindness.


<h3>Protanopia Members</h3>

<strong>x</strong> 0.7465
<strong>y</strong> 0.2535
<strong>m</strong> 1.273463
<strong>yint</strong> -0.073894



<h2>Deuteranopia Class</h2>

An object inheriting from the cbtype class with data specific to green color blindness.


<h3>Deuteranopia Members</h3>

<strong>x</strong> 1.4
<strong>y</strong> -0.4
<strong>m</strong> 0.968437
<strong>yint</strong> 0.003331






<h2>Tritanopia Class</h2>

An object inheriting from the cbtype class with data specific to blue color blindness.


<h3>Tritanopia Members</h3>

<strong>x</strong> 0.1748
<strong>y</strong> 0.0
<strong>m</strong> 0.062921
<strong>yint</strong> 0.292119


<h2>Colorblindness Simulation Class</h2>

An object used to simulate RGB values under varying forms of color blindness.


<h3>Colorblindness Simulation Members - Private</h3>

<strong>types</strong> contains the name of the types of colorblindness.
<strong>typelabs</strong> contains strings used to label the RGB values for specific forms of color blindness.
<strong>inputR</strong> the red channel that will be transformed.
<strong>inputG</strong> the green channel that will be transformed.
<strong>inputB</strong> the blue channel that will be transformed.
<strong>amount</strong> a modifier that defaults to a value of 1.
<strong>gamma</strong> an adjustment for the gamma level when transforming RGB to XYZ colorspace.
<strong>invgamma</strong> an adjustment for the gamma level when transforming XYZ to RGB colorspace.
<strong>transformedRGB</strong> a matrix of RGB tuples containing the user.
<strong>specified</strong> value and any types of transforms requested.
<strong>protanope</strong> a Protanopia class object.
<strong>deuteranope</strong> a Deuteranopia class object.
<strong>tritanope</strong> a Tritanopia class object.


<h3>Colorblindness Simulation Methods</h3>

<em>new()</em> constructor method (cannot be called directly).
<em>achromatopsia()</em> a method to transform the user RGB members to simulate the color perceived by individuals with achromatopsia.
<em>setR()</em> method used to set the red channel parameter.
<em>setG()</em> method used to set the green channel parameter.
<em>setB()</em> method used to set the blue channel parameter.
<em>setRGB()</em> method used to set the red, green, and blue channel parameters simultaneously.
<em>setAmount()</em> method used to specify non-default ajustment amount parameter.
<em>simulate()</em> method used to transform user specified RGB values to simulate perception with varying forms of color blindness.
<em>getR()</em> method used to access the user specified value for the red channel.
<em>getG()</em> method used to access the user specified value for the green channel.
<em>getB()</em> method used to access the user specified value for the blue channel.
<em>getGamma()</em> method used to access the gamma correction value.
<em>getInvGamma()</em> method used to access the inverse-gamma correction value.
<em>getConfuseX()</em> method used to access the x member of cbtype class object.
<em>getConfuseY()</em> method used to access the y member of cbtype class object.
<em>getConfuseM()</em> method used to access the slope member of cbtype class object.
<em>getConfuseYint()</em> method used to access the intercept member of cbtype class object.
<em>getAmount()</em> method used to retrieve the adjustment amount parameter value.
<em>condMax()</em> method used to for scaling transformed RGB values from XYZ back to RGB colorspace.
<em>getTypes()</em> method used to retrieve list of color blindness type strings.
<em>getTypeLabs()</em> method used to retrieve list of color blindness type label strings.
<em>getType()</em> method used to retrieve a color blindness type string.
<em>getTypeLab()</em> method used to retrieve a color blindness type label string.
<em>getTransformedRgbs()</em> method used to retrieve all transformed RGB values.
<em>getTransformedRgb()</em> method used to retrieve a single transformed RGB value.
<em>checkRange()</em> method used to enforce RGB values stay in [0, 255].
<em>getRgbString()</em> method used to return a single transformed RGB string to Stata as a local macro.
<em>getRgbStrings()</em> method used to return all transformed RGB strings to Stata in local macros.






<h3>Wrappers</h3>

<em>translateColor()</em> a wrapper around the colorblind object that simulates the RGB arguments under all conditions of color sightedness impairment.


<h2>brewcolor class</h2>

This class loads the meta and colordb files to enable faster searching of local databases for specified RGB values and existing transformed values. The intended use here is in the internals of brewscheme and brewtheme to provide a consistent format for scheme files generated by these programs.  Additionally, it also facilitates the automation of scheme files with simulated values for different forms of color sight impairment using the same stub name with an additional identifier in the file name for the type of color sight impairment.


<h3>brewcolor members</h3>

<strong>color</strong> A private string matrix containing the required data from the database created by brewcolordb.
<strong>meta</strong> A private string matrix containing the required data from the database created by brewdb and brewextra.


<h3>brewcolor methods</h3>

<em>brewNameSearch()</em> a method used to search for colorblind transformed RGB values given the color's name or meta property. This method searches the palette and meta variables in the color member of the brewcolor class.
<em>brewColorSearch()</em> a method used to search for colorblind transformed RGB values given an RGB string. This method searches the rgb variable in the color and meta members of the brewcolor class.
<em>getNames()</em> a method used to retrieve the full list of all values in the palette or meta variables of the color and meta databases.





## References
[Bostock, M., Ogievetsky, V., & Heer, J. (2011).  D3: data driven documents. *IEEE Transactions on Visualization & Computer Graphics. 17(12)* pp 2301 - 2309. Retrieved from http://vis.stanford.edu/papers/d3](http://vis.stanford.edu/papers/d3)  

[Brewer, C. A. (2002). Color Brewer 2. [Computer Software]. State College, PA: Cynthia Brewer, Mark Harrower, and The Pennsylvania State University](http://www.ColorBrewer2.org)

[Krzywinski, M. (2015). *Color palettes for color blindness*.  Retrieved on: 22nov2015.  Retrieved from: http://mkweb.bcgsc.ca/colorblind/](http://mkweb.bcgsc.ca/colorblind/)

[Lin, S., Fortuna, J., Kulkarni, C., Stone, M., {c 38} Heer, J. (2013). Selecting Semantically-Resonant Colors for Data Visualization. *Computer Graphics Forum 32(3)* pp. 401-410.  Retrieved from http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf](http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf)

[Wickham, H. (2009).  *ggplot2: Elegant Graphics for Data Analysis*.  New York City, NY: Springer Science+Business Media LLC.](http://www.amazon.com/ggplot2-Elegant-Graphics-Data-Analysis/dp/0387981403)

