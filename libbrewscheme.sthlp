{smcl}
{* *! version 1.0.0 21MAR2016}{...}

{hline}
Mata library for {help brewscheme}
{hline}

{title:help for libbrewscheme}

{p 4 4 4}{hi:libbrewscheme {hline 2}} compiles the libbrewscheme Mata library and displays this help file.{p_end}

{title:Syntax}

{p 4 4 4}{cmd:libbrewscheme} [, {cmdab:dis:play} {cmdab:rep:lace} {cmdab:si:ze(}{it:integer}{opt )} ]{break}

{title:Description}

{p 4 4 4}{cmd:libbrewscheme} wrapper used to compile libbrewscheme.mlib locally.  
This help file defines the objects and methods defined in the library.{p_end}

{title:Options}

{p 4 4 8}{cmdab:dis:play} is an optional argument to display this help file after compiling the Mata library.{p_end}

{p 4 4 8}{cmdab:rep:lace} is an optional argument used to overwrite an existing copy of the library. {p_end}

{p 4 4 8}{cmdab:si:ze} is an optional argument passed to {help mata_mlib:mata mlib create} to set the maximum number of members of the library. {p_end}

{marker cbtype}{dlgtab 4 8:Colorblindness Type Class}{break}
{p 4 4 8}An object type used in a way that is analogous to an interface class in Java.{p_end}

{marker cbmembers}{dlgtab 8 8:Colorblindness Type Members}{break}
{p 14 14 14}{hi:x} a member variable used for transforming RGB values for different forms of color sight impairments.{p_end}
{p 14 14 14}{hi:y} a member variable used for transforming RGB values for different forms of color sight impairments.{p_end}
{p 14 14 14}{hi:m} a member variable containing the slope used for transforming RGB values for different forms of color sight impairments.{p_end}
{p 14 14 14}{hi:yint} a member variable containing the intercept used for transforming RGB values for different forms of color sight impairments.{p_end}

{marker cbmethods}{dlgtab 8 8:Colorblindness Type Methods}{break}
{p 14 14 14}{hi:getConfuseX()} method used to access/retrieve the x member variable{p_end}
{p 14 14 14}{hi:getConfuseY()} method used to access/retrieve the x member variable{p_end}
{p 14 14 14}{hi:getConfuseM()} method used to access/retrieve the x member variable{p_end}
{p 14 14 14}{hi:getConfuseYint()} method used to access/retrieve the x member variable{p_end}
{p 14 14 14}{hi:setConfuseX()} method used to set the x member variable{p_end}
{p 14 14 14}{hi:setConfuseY()} method used to set the y member variable{p_end}
{p 14 14 14}{hi:setConfuseM()} method used to set the slope member variable{p_end}
{p 14 14 14}{hi:setConfuseYint()} method used to set the intercept member variable{p_end}

{marker prtype}{dlgtab 4 8:Protanopia Class}{break}
{p 4 4 8}An object inheriting from the {help libbrewscheme##cbtype:cbtype} class with data specific to red color blindness.{p_end}

{marker prmembers}{dlgtab 8 8:Protanopia Members}{break}
{p 14 14 14}{hi:x} 0.7465{p_end}
{p 14 14 14}{hi:y} 0.2535{p_end}
{p 14 14 14}{hi:m} 1.273463{p_end}
{p 14 14 14}{hi:yint} -0.073894{p_end}

{marker detype}{dlgtab 4 8:Deuteranopia Class}{break}
{p 4 4 8}An object inheriting from the {help libbrewscheme##cbtype:cbtype} class with data specific to green color blindness.{p_end}

{marker demembers}{dlgtab 8 8:Deuteranopia Members}{break}
{p 14 14 14}{hi:x} 1.4{p_end}
{p 14 14 14}{hi:y} -0.4{p_end}
{p 14 14 14}{hi:m} 0.968437{p_end}
{p 14 14 14}{hi:yint} 0.003331{p_end}

{marker trtype}{dlgtab 4 8:Tritanopia Class}{break}
{p 4 4 8}An object inheriting from the {help libbrewscheme##cbtype:cbtype} class with data specific to blue color blindness.{p_end}

{marker trmembers}{dlgtab 8 8:Tritanopia Members}{break}
{p 14 14 14}{hi:x} 0.1748{p_end}
{p 14 14 14}{hi:y} 0.0{p_end}
{p 14 14 14}{hi:m} 0.062921{p_end}
{p 14 14 14}{hi:yint} 0.292119{p_end}

{marker co}{dlgtab 4 8:Colorblindness Simulation Class}{break}
{p 4 4 8}An object used to simulate RGB values under varying forms of color blindness.{p_end}

{marker comembers}{dlgtab 8 8:Colorblindness Simulation Members - Private}{break}
{p 14 14 14}{hi:types} contains the name of the types of colorblindness.{p_end}
{p 14 14 14}{hi:typelabs} contains strings used to label the RGB values for specific forms of color blindness.{p_end}
{p 14 14 14}{hi:inputR} the red channel that will be transformed.{p_end}
{p 14 14 14}{hi:inputG} the green channel that will be transformed.{p_end}
{p 14 14 14}{hi:inputB} the blue channel that will be transformed.{p_end}
{p 14 14 14}{hi:amount} a modifier that defaults to a value of 1.{p_end}
{p 14 14 14}{hi:gamma} an adjustment for the gamma level when transforming RGB to XYZ colorspace.{p_end}
{p 14 14 14}{hi:invgamma} an adjustment for the gamma level when transforming XYZ to RGB colorspace.{p_end}
{p 14 14 14}{hi:transformedRGB} a matrix of RGB tuples containing the user specified value and any types of transforms requested.{p_end}
{p 14 14 14}{hi:protanope} a Protanopia class object.{p_end}
{p 14 14 14}{hi:deuteranope} a Deuteranopia class object.{p_end}
{p 14 14 14}{hi:tritanope} a Tritanopia class object.{p_end}

{marker comethods}{dlgtab 8 8:Colorblindness Simulation Methods}{break}
{p 14 14 14}{hi:new()} constructor method (cannot be called directly).{p_end}
{p 14 14 14}{hi:achromatopsia()} a method to transform the user RGB members to simulate the color perceived by individuals with achromatopsia.{p_end}
{p 14 14 14}{hi:setR()} method used to set the red channel parameter.{p_end}
{p 14 14 14}{hi:setG()} method used to set the green channel parameter.{p_end}
{p 14 14 14}{hi:setB()} method used to set the blue channel parameter.{p_end}
{p 14 14 14}{hi:setRGB()} method used to set the red, green, and blue channel parameters simultaneously.{p_end}
{p 14 14 14}{hi:setAmount()} method used to specify non-default ajustment amount parameter.{p_end}
{p 14 14 14}{hi:simulate()} method used to transform user specified RGB values to simulate perception with varying forms of color blindness.{p_end}
{p 14 14 14}{hi:getR()} method used to access the user specified value for the red channel.{p_end}
{p 14 14 14}{hi:getG()} method used to access the user specified value for the green channel.{p_end}
{p 14 14 14}{hi:getB()} method used to access the user specified value for the blue channel.{p_end}
{p 14 14 14}{hi:getGamma()} method used to access the gamma correction value{p_end}
{p 14 14 14}{hi:getInvGamma()} method used to access the inverse-gamma correction value.{p_end}
{p 14 14 14}{hi:getConfuseX()} method used to access the x member of {help libbrewscheme##cbtype:cbtype} class object.{p_end}
{p 14 14 14}{hi:getConfuseY()} method used to access the y member of {help libbrewscheme##cbtype:cbtype} class object.{p_end}
{p 14 14 14}{hi:getConfuseM()} method used to access the slope member of {help libbrewscheme##cbtype:cbtype} class object.{p_end}
{p 14 14 14}{hi:getConfuseYint()} method used to access the intercept member of {help libbrewscheme##cbtype:cbtype} class object.{p_end}
{p 14 14 14}{hi:getAmount()} method used to retrieve the adjustment amount parameter value.{p_end}
{p 14 14 14}{hi:condMax()} method used to for scaling transformed RGB values from XYZ back to RGB colorspace.{p_end}
{p 14 14 14}{hi:getTypes()} method used to retrieve list of color blindness type strings.{p_end}
{p 14 14 14}{hi:getTypeLabs()} method used to retrieve list of color blindness type label strings.{p_end}
{p 14 14 14}{hi:getType()} method used to retrieve a color blindness type string.{p_end}
{p 14 14 14}{hi:getTypeLab()} method used to retrieve a color blindness type label string.{p_end}
{p 14 14 14}{hi:getTransformedRgbs()} method used to retrieve all transformed RGB values.{p_end}
{p 14 14 14}{hi:getTransformedRgb()} method used to retrieve a single transformed RGB value.{p_end}
{p 14 14 14}{hi:checkRange()} method used to enforce RGB values stay in [0, 255].{p_end}
{p 14 14 14}{hi:getRgbString()} method used to return a single transformed RGB string to Stata as a local macro.{p_end}
{p 14 14 14}{hi:getRgbStrings()} method used to return all transformed RGB strings to Stata in local macros.{p_end}

{marker translator}{dlgtab 8 8:Wrappers}{break}
{p 14 14 14}{hi:translateColor()} a wrapper around the {help libbrewscheme##co:colorblind} 
object that simulates the RGB arguments under all conditions of color sightedness impairment. {p_end}

{marker brewcolor}{dlgtab 4 8:brewcolor class}{break}
{p 4 4 8}This class loads the meta and colordb files to enable faster searching of 
local databases for specified RGB values and existing transformed values. The 
intended use here is in the internals of {help brewscheme} and {help brewtheme} 
to provide a consistent format for {help scheme_files:scheme files} generated by 
these programs.  Additionally, it also facilitates the automation of scheme 
files with simulated values for different forms of color sight impairment using 
the same stub name with an additional identifier in the file name for the type 
of color sight impairment. {p_end}

{marker bcmembers}{dlgtab 8 8:brewcolor members}{break}
{p 14 14 14}{hi:color} A private string matrix containing the required data from 
the database created by {help brewcolordb}.{p_end}

{p 14 14 14}{hi:meta} A private string matrix containing the required data from 
the database created by brewdb and {help brewextra}. {p_end}

{marker bcmethods}{dlgtab 8 8:brewcolor methods}{break}
{p 14 14 14}{hi:brewNameSearch()} a method used to search for {help libbrewscheme##co:colorblind} 
transformed RGB values given the color's name or meta property. This method searches the 
palette and meta variables in the color member of the brewcolor class.{p_end}

{p 14 14 14}{hi:brewColorSearch()} a method used to search for {help libbrewscheme##co:colorblind} 
transformed RGB values given an RGB string. This method searches the rgb 
variable in the color and meta members of the brewcolor class.{p_end}

{p 14 14 14}{hi:getNames()} a method used to retrieve the full list of all values 
in the palette or meta variables of the color and meta databases. {p_end}

{marker refs}{title:{ul:References}}{break}
{marker wickline}{p 4 8 8}Wickline, M. (2014). {it:Color.Vision.Simulate, Version 0.1}.  Retrieved from: 
{browse "http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js"}. 
Retrieved on: 24nov2015.{p_end} 
{marker mg}{p 4 8 8}Meyer, G. W., & Greenberg, D. P. (1988). Color-Defective Vision and Computer Graphics Displays. 
{it:Computer Graphics and Applications, IEEE 8(5)}, pp. 28-40.{p_end}

{marker sp}{p 4 8 8}Smith, V. C., & Pokorny, J. (2005).  Spectral sensitivity of the foveal cone photopigments between 400 and 500nm.  
{it:Journal of the Optical Society of America A, 22(10),} pp. 2060-2071.{p_end}

{marker lindbloom}{p 4 8 8}Lindbloom, B. (2001).  RGB working space information. Retrieved from: {browse "http://www.brucelindbloom.com/WorkingSpaceInfo.html"}.  Retrieved on 24nov2015.{p_end}

{title:Author}{break}
{p 4 4 8}William R. Buchanan, Ph.D.{p_end}
{p 4 4 8}Data Scientist{p_end}
{p 4 4 8}{browse "http://mpls.k12.mn.us":Minneapolis Public Schools}{p_end}
{p 4 4 8}William.Buchanan at mpls [dot] k12 [dot] mn [dot] us{p_end}
