---
layout: page
title: libbrewscheme
permalink: /help/libbrewscheme/
---

<hr>
Mata library for brewscheme
<hr>
<br>
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

<div>

<span><h2>Mata Object and Method Information</h2></span>

<div>

<span><h2>Colorblindness Type Class</h2></span>

An object type used in a way that is analogous to an interface class in Java.

<span><h3>Colorblindness Type Members</h3></span>

<strong>x</strong> a member variable used for transforming RGB values for different forms of color sight impairments.<br>
<strong>y</strong> a member variable used for transforming RGB values for different forms of color sight impairments.<br>
<strong>m</strong> a member variable containing the slope used for transforming RGB values for different forms of color sight impairments.<br>
<strong>yint</strong> a member variable containing the intercept used for transforming RGB values for different forms of color sight impairments.<br>

<span><h3>Colorblindness Type Methods</h3></span>

<em>getConfuseX()</em> method used to access/retrieve the x member variable.<br>
<em>getConfuseY()</em> method used to access/retrieve the x member variable.<br>
<em>getConfuseM()</em> method used to access/retrieve the x member variable.<br>
<em>getConfuseYint()</em> method used to access/retrieve the x member variable.<br>
<em>setConfuseX()</em> method used to set the x member variable.<br>
<em>setConfuseY()</em> method used to set the y member variable.<br>
<em>setConfuseM()</em> method used to set the slope member variable.<br>
<em>setConfuseYint()</em> method used to set the intercept member variable.<br>

</div>

<div>

<span><h2>Protanopia Class</h2></span>

An object inheriting from the cbtype class with data specific to red color blindness.

<span><h3>Protanopia Members</h3></span>

<strong>x</strong> 0.7465<br>
<strong>y</strong> 0.2535<br>
<strong>m</strong> 1.273463<br>
<strong>yint</strong> -0.073894<br>

</div>

<div>

<span><h2>Deuteranopia Class</h2></span>

An object inheriting from the cbtype class with data specific to green color blindness.

<span><h3>Deuteranopia Members</h3></span>

<strong>x</strong> 1.4<br>
<strong>y</strong> -0.4<br>
<strong>m</strong> 0.968437<br>
<strong>yint</strong> 0.003331<br>

</div>

<div>

<span><h2>Tritanopia Class</h2></span>

An object inheriting from the cbtype class with data specific to blue color blindness.

<span><h3>Tritanopia Members</h3></span>

<strong>x</strong> 0.1748<br>
<strong>y</strong> 0.0<br>
<strong>m</strong> 0.062921<br>
<strong>yint</strong> 0.292119<br>

</div>

<div>

<span><h2>Colorblindness Simulation Class</h2></span>

An object used to simulate RGB values under varying forms of color blindness.

<span><h3>Colorblindness Simulation Members - Private</h3></span>

<strong>types</strong> contains the name of the types of colorblindness.<br>
<strong>typelabs</strong> contains strings used to label the RGB values for specific forms of color blindness.<br>
<strong>inputR</strong> the red channel that will be transformed.<br>
<strong>inputG</strong> the green channel that will be transformed.<br>
<strong>inputB</strong> the blue channel that will be transformed.<br>
<strong>amount</strong> a modifier that defaults to a value of 1.<br>
<strong>gamma</strong> an adjustment for the gamma level when transforming RGB to XYZ colorspace.<br>
<strong>invgamma</strong> an adjustment for the gamma level when transforming XYZ to RGB colorspace.<br>
<strong>transformedRGB</strong> a matrix of RGB tuples containing the user.<br>
<strong>specified</strong> value and any types of transforms requested.<br>
<strong>protanope</strong> a Protanopia class object.<br>
<strong>deuteranope</strong> a Deuteranopia class object.<br>
<strong>tritanope</strong> a Tritanopia class object.<br>

<span><h3>Colorblindness Simulation Methods</h3></span>

<em>new()</em> constructor method (cannot be called directly).<br>
<em>achromatopsia()</em> a method to transform the user RGB members to simulate the color perceived by individuals with achromatopsia.<br>
<em>setR()</em> method used to set the red channel parameter.<br>
<em>setG()</em> method used to set the green channel parameter.<br>
<em>setB()</em> method used to set the blue channel parameter.<br>
<em>setRGB()</em> method used to set the red, green, and blue channel parameters simultaneously.<br>
<em>setAmount()</em> method used to specify non-default ajustment amount parameter.<br>
<em>simulate()</em> method used to transform user specified RGB values to simulate perception with varying forms of color blindness.<br>
<em>getR()</em> method used to access the user specified value for the red channel.<br>
<em>getG()</em> method used to access the user specified value for the green channel.<br>
<em>getB()</em> method used to access the user specified value for the blue channel.<br>
<em>getGamma()</em> method used to access the gamma correction value.<br>
<em>getInvGamma()</em> method used to access the inverse-gamma correction value.<br>
<em>getConfuseX()</em> method used to access the x member of cbtype class object.<br>
<em>getConfuseY()</em> method used to access the y member of cbtype class object.<br>
<em>getConfuseM()</em> method used to access the slope member of cbtype class object.<br>
<em>getConfuseYint()</em> method used to access the intercept member of cbtype class object.<br>
<em>getAmount()</em> method used to retrieve the adjustment amount parameter value.<br>
<em>condMax()</em> method used to for scaling transformed RGB values from XYZ back to RGB colorspace.<br>
<em>getTypes()</em> method used to retrieve list of color blindness type strings.<br>
<em>getTypeLabs()</em> method used to retrieve list of color blindness type label strings.<br>
<em>getType()</em> method used to retrieve a color blindness type string.<br>
<em>getTypeLab()</em> method used to retrieve a color blindness type label string.<br>
<em>getTransformedRgbs()</em> method used to retrieve all transformed RGB values.<br>
<em>getTransformedRgb()</em> method used to retrieve a single transformed RGB value.<br>
<em>checkRange()</em> method used to enforce RGB values stay in [0, 255].<br>
<em>getRgbString()</em> method used to return a single transformed RGB string to Stata as a local macro.<br>
<em>getRgbStrings()</em> method used to return all transformed RGB strings to Stata in local macros.<br>

</div>

<div>

<span><h3>Wrappers</h3></span>

<em>translateColor()</em> a wrapper around the colorblind object that simulates the RGB arguments under all conditions of color sightedness impairment.<br>

<span><h2>brewcolor class</h2></span>

This class loads the meta and colordb files to enable faster searching of local databases for specified RGB values and existing transformed values. The intended use here is in the internals of brewscheme and brewtheme to provide a consistent format for scheme files generated by these programs.  Additionally, it also facilitates the automation of scheme files with simulated values for different forms of color sight impairment using the same stub name with an additional identifier in the file name for the type of color sight impairment.

<span><h3>brewcolor members</h3></span>

<strong>color</strong> A private string matrix containing the required data from the database created by brewcolordb.<br>
<strong>meta</strong> A private string matrix containing the required data from the database created by brewdb and brewextra.<br>

<span><h3>brewcolor methods</h3></span>

<em>brewNameSearch()</em> a method used to search for colorblind transformed RGB values given the color's name or meta property. This method searches the palette and meta variables in the color member of the brewcolor class.<br>
<em>brewColorSearch()</em> a method used to search for colorblind transformed RGB values given an RGB string. This method searches the rgb variable in the color and meta members of the brewcolor class.<br>
<em>getNames()</em> a method used to retrieve the full list of all values in the palette or meta variables of the color and meta databases.<br>

</div>

</div>

## References
[Bostock, M., Ogievetsky, V., & Heer, J. (2011).  D3: data driven documents. *IEEE Transactions on Visualization & Computer Graphics. 17(12)* pp 2301 - 2309. Retrieved from http://vis.stanford.edu/papers/d3](http://vis.stanford.edu/papers/d3)  

[Brewer, C. A. (2002). Color Brewer 2. [Computer Software]. State College, PA: Cynthia Brewer, Mark Harrower, and The Pennsylvania State University](http://www.ColorBrewer2.org)

[Krzywinski, M. (2015). *Color palettes for color blindness*.  Retrieved on: 22nov2015.  Retrieved from: http://mkweb.bcgsc.ca/colorblind/](http://mkweb.bcgsc.ca/colorblind/)

[Lin, S., Fortuna, J., Kulkarni, C., Stone, M., {c 38} Heer, J. (2013). Selecting Semantically-Resonant Colors for Data Visualization. *Computer Graphics Forum 32(3)* pp. 401-410.  Retrieved from http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf](http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf)

[Wickham, H. (2009).  *ggplot2: Elegant Graphics for Data Analysis*.  New York City, NY: Springer Science+Business Media LLC.](http://www.amazon.com/ggplot2-Elegant-Graphics-Data-Analysis/dp/0387981403)

