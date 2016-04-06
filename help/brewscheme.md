---
layout: page
title: brewscheme
permalink: /help/brewscheme/
---


<hr>
Command to generate customized scheme files.
<hr>
<br>
__brewscheme__ -- A program for easy generation of customized graph scheme files.

## Syntax

<table style="width:100%">
<tr><td>brewscheme , <u>scheme</u>name(scheme name) </td><td colspan="3">[ <u>rep</u>lace</td></tr> 
<tr><td> </td><td><u>allsty</u>le(string)</td><td><u>allc</u>olors(real 3)</td><td><u>allsat</u>uration(real 100)</td></tr>
<tr><td> </td><td><u>somesty</u>le(string)</td><td><u>somec</u>olors(real 3)</td><td><u>somesat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#bar"><u>barsty</u>le(string)</a></td><td><u>barc</u>olors(real 3)</td><td><u>barsat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#scatter"><u>scatsty</u>le(string)</a></td><td><u>scatc</u>olors(real 3)</td><td><u>scatsat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#area"><u>areasty</u>le(string)</a></td><td><u>areac</u>olors(real 3)</td><td><u>areasat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#line"><u>linesty</u>le(string)</a></td><td><u>linec</u>olors(real 3)</td><td><u>linesat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#box"><u>boxsty</u>le(string)</a></td><td><u>boxc</u>olors(real 3)</td><td><u>boxsat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#dot"><u>dotsty</u>le(string)</a></td><td><u>dotc</u>olors(real 3)</td><td><u>dotsat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#pie"><u>piesty</u>le(string)</a></td><td><u>piec</u>olors(real 3)</td><td><u>piesat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#sun"><u>sunsty</u>le(string)</a></td><td><u>sunc</u>olors(real 4)</td><td><u>sunsat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#histo"><u>histsty</u>le(string)</a></td><td><u>histc</u>olors(real 3)</td><td><u>histsat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#ci"><u>cisty</u>le(string)</a></td><td><u>cic</u>olors(real 3)</td><td><u>cisat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#splom"><u>matsty</u>le(string)</a></td><td><u>matc</u>olors(real 3)</td><td><u>matsat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#refline"><u>reflsty</u>le(string)</a></td><td><u>reflc</u>olors(real 3)</td><td><u>reflsat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#refmark"><u>refmsty</u>le(string)</a></td><td><u>refmc</u>olors(real 3)</td><td><u>refmsat</u>uration(real 100)</td></tr>
<tr><td> </td><td><a href="#contour"><u>const</u>art(string)</a></td><td><u>cone</u>nd(string)</td><td><u>consat</u>uration(real 100)</td></tr>
<tr><td> </td><td><u>themef</u>ile(string)</td><td colspan="2"><u>symb</u>ols(string)</td>]</tr>
</table>
 
## Description
 
__brewscheme__ is a command to help Stata users developing graph schemes using research-based color palettes.  Unlike other uses of the color palettes developed by Brewer (<a href="#references">see References below</a>), this program allows users to specify the number of colors from any of the __59__ color palettes they would like to use and allows users to mix/combine different palettes for the various graph types available in Stata.  Since starting the program, it has grown to include color resources from: [d3.scale.category10()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category10), [d3.scale.category20()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20), [d3.scale.category20b()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20b), and [d3.scale.category20c()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20c) from the [D3js](http://www.d3js.org) library; default colors used by [ggplot2](https://github.com/hadley/ggplot2) for 2-24 colors; semantic color mappings studied by [Lin, Fortuna, Kulkarni, Stone, & Heer (2013)](http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf); and additional colors are in the process of being added.

 
### Available Palettes
To view information about the available palettes as well as to view previews of each of the palettes, please see <a href="../brewviewer/">the brewviewer</a> documentation.
 
## Options
 
<u>scheme</u>name is used to name the scheme that will be created by the program. Unless absolutely necessary, I highly recommend avoiding embedded spaces in these file names.
 
<u>rep</u>lace if the source dataset containing the color palettes is not found or the user specifies the refresh option, colorbrewscheme will rebuild the source data set to generate the scheme files.

<u>symb</u>ols is an optional argument used to define the type of marks to use - and the order in which to use them - for graphs that include individual points.  For a quick list of available options use `graph query symbolstyle`.
 
<h3>Single Color Palettes and Default Color Palettes</h3>

<u>allsty</u>le The lower-cased name of a color palette to be used for all graph types.
 
<u>allcol</u>ors The maximum number of colors to use from the palette specifed by the allstyle option.
 
<u>allsat</u>uration Used to set the color intensity for all graph types.
 
<u>somesty</u>le The lower-cased name of a color palette to be used for graph types without specified color palettes.
 
<u>somecol</u>ors The maximum number of colors to use from the palette specifed by the somestyle option.

<u>somesat</u>uration Used to set the color intensity for graph types without specified color palettes.
 
<u>themef</u>ile Is an optional argument used to supply brewscheme with a theme file created by brewtheme.  Theme files are used to control global aesthetic properties (e.g., background/foreground colors, text sizes, symbol sizes, etc...) that are typically independent of the data being visualized. See <a href="../brewtheme/">brewtheme</a> for additional information.

<h3>Individual Graph Types</h3>

<a name="bar"></a>
<h4>Bar Graphs</h4>
 
<u>barsty</u>le The lower-cased name of a color palette that will be used to define colors for bar graphs.
 
<u>barcol</u>ors The maximum number of colors to use from the palette specifed by the barstyle option.
 
<u>barsat</u>uration Used to set the color intensity for bar graphs.
 
<a name="scatter"></a>
<h4>Scatterplots</h4>
 
<u>scatsty</u>le The lower-cased name of a color palette that will be used for scatter plots.
 
<u>scatcol</u>ors The maximum number of colors to use from the palette specifed by the scatstyle option.
 
<u>scatsat</u>uration Used to set the color intensity for scatterplots.
 
<a name="area"></a>
<h4>Area Graphs</h4>
 
<u>areasty</u>le The lower-cased name of a color palette to be used for area graphs
 
<u>areacol</u>ors The maximum number of colors to use from the palette specifed by the areastyle option.
 
<u>areasat</u>uration Used to set the color intensity for area graphs.
 
<a name="line"></a>
<h4>Line Graphs</h4>
 
<u>linesty</u>le The lower-cased name of a color palette to be used for line graphs.
 
<u>linecol</u>ors The maximum number of colors to use from the palette specifed by the linestyle option.
 
<u>linesat</u>uration Used to set the color intensity for line graphs.
 
<a name="box"></a>
<h4>Box Plots</h4>
 
<u>boxsty</u>le The lower-cased name of a color palette to be used for box plots.
 
<u>boxcol</u>ors The maximum number of colors to use from the palette specifed by the allstyle option.
 
<u>boxsat</u>uration Used to set the color intensity for box plots.
 
<a name="dot"></a>
<h4>Dot Plots</h4>
 
<u>dotsty</u>le The lower-cased name of a color palette to be used for dot plots.
 
<u>dotcol</u>ors The maximum number of colors to use from the palette specifed by the dotstyle option.
 
<u>dotsat</u>uration Used to set the color intensity for dot plots.
 
<a name="pie"></a>
<h4>Pie Graphs</h4>
 
<u>piesty</u>le The lower-cased name of a color palette to be used for pie graphs.
 
<u>piecol</u>ors The maximum number of colors to use from the palette specifed by the piestyle option.
 
<u>piesat</u>uration Used to set the color intensity for pie graphs.
 
<a name="sun"></a>
<h4>Sunflower Plots</h4>
 
<u>sunsty</u>le The lower-cased name of a color palette to be used for sunflower plots.  Note, only the first four colors will be used.
 
<u>suncol</u>ors The maximum number of colors to use from the palette specifed by the sunstyle option.
 
<u>sunsat</u>uration Used to set the color intensity for sunflower plots.
 
<a name="histo"></a>
<h4>Histograms</h4>
 
<u>histsty</u>le The lower-cased name of a color palette to be used for histograms.
 
<u>histcol</u>ors The maximum number of colors to use from the palette specifed by the histstyle option.
 
<u>histsat</u>uration Used to set the color intensity for histograms.

<a name="ci"></a>
<h4>Confidence Intervals</h4>
 
<u>cisty</u>le The lower-cased name of a color palette to be used for graphs containing confidence intervals.
 
<u>cicol</u>ors The maximum number of colors to use from the palette specifed by the cistyle option.
 
<u>cisat</u>uration Used to set the color intensity for confidence intervals.
 
<a name="splom"></a>
<h4>Scatterplot Matrices</h4>
 
<u>matsty</u>le The lower-cased name of a color palette to be used for scatter plot matrices.
 
<u>matcol</u>ors The maximum number of colors to use from the palette specifed by the matstyle option.
 
<u>matsat</u>uration Used to set the color intensity for scatterplot matrices.
 
<a name="refline"></a> 
<h4>Reference Lines</h4>
 
<u>reflsty</u>le The lower-cased name of a color palette to be used for reference lines.
 
<u>reflcol</u>ors The maximum number of colors to use from the palette specifed by the reflstyle option.
 
<u>reflsat</u>uration Used to set the color intensity for reference lines.
 
<a name="refmark"></a> 
<h4>Reference Markers</h4>
 
<u>refmsty</u>le The lower-cased name of a color palette to use for reference markers.
 
<u>refmcol</u>ors The maximum number of colors to use from the palette specifed by the refmstyle option.
 
<u>refmsat</u>uration Used to set the color intensity for reference markers.
 
<a name="contour"></a> 
<h4>Contour Plots</h4>
 
<u>const</u>art Defines the starting color to be used for contour plots using standard colorstyles from Stata.
 
<u>cone</u>nd Defines the ending color to be used for contour plots using standard colorstyles from Stata.

<br>

## Examples

### Ex 1. 
Generate a graph scheme using the set1 color brewer palette for all graphs.  Use the first five colors of the palette and set the color intensity to 80 for each of the graphs.
 
```Stata
brewscheme, scheme(set1) allst(set1) allc(5) allsat(80)
```

### Ex 2. 
Generate a graph scheme using the set1 color brewer palette for scatterplots, pastel1 for bar graphs, and brown to blue-green for all other graph types.  Use the default values of colors and intensity for each.
 
```Stata
brewscheme, scheme(mixed1) scatst(set1) barst(pastel1) somest(brbg)
```

### Ex 3. 
Uses a combination of [D3js](https://www.d3js.org) palettes, combined with [ggplot2](https://github.com/hadley/ggplot2) default palettes and themefile.


```Stata
// Shows combination of D3js color palettes
brewscheme, scheme(mixed2) scatst(category10) scatc(5) barst(category20) 	///   
barc(15) boxsty(category20b) boxc(13) somesty(ggplot2) somec(7) themef(ggtheme)
```

### Ex 4. 
Distinct Color Palette for Each Graph Type.


```Stata
// Create a graph scheme with a distinct color palette for each graph type
brewscheme, scheme(myriadColorPalettes) barst(paired) barc(12) dotst(prgn)  ///   
dotc(7) scatstyle(set1) scatc(9) linest(pastel2) linec(8) boxstyle(accent)  ///   
boxc(8) areast(dark2) areac(8) piest(mdepoint) sunst(greys)                 ///   
histst(veggiese) cist(activitiesa) matst(spectral) reflst(purd)             ///   
refmst(set3) const(ylgn) cone(puor)
```


Note, this program only creates the scheme file.  To achieve the intended effect, you must use the scheme file in your subsequent graph commands:

```Stata 
sysuse auto.dta, clear
gr box mpg, over(rep78) scheme(mixed1)
```

### Ex 5.
Create a mono color scheme with three colors; this will cause all layers beyond the third to not be drawn (e.g., there won't be colors defined for Stata to use to assign colors to points/lines, etc...).

```Stata
brewscheme, scheme(onecolorex1) allsty(ggplot2)
```

_Graph created with the scheme defined above.  Code for graph production is available in Example 11._
![brewschemeEx1](../../img/brewscheme_onecolorex1.png)


### Ex 6.
Use the ggplot2 color palette with s2color theme settings; this uses 4 colors to help highlight how these cases are handled by Stata

```Stata
brewscheme, scheme(onecolorex2) allsty(ggplot2) allc(4) themef(s2theme)
```

_Graph created with the scheme defined above.  Code for graph production is available in Example 11._
![brewschemeEx2](../../img/brewscheme_onecolorex2.png)

### Ex 7.
Now five colors from same palette using the ggplot2 inspired theme

```Stata
brewscheme, scheme(ggplot2ex1) allsty(ggplot2) allc(5) themef(ggtheme)
```

_Graph created with the scheme defined above.  Code for graph production is available in Example 11._
![brewschemeEx3](../../img/brewscheme_ggplot2ex1.png)

### Ex 8.
An Example showing the use of the some parameters

```Stata
brewscheme, scheme(somecolorex1) somest(ggplot2) somec(7) linest(dark2)     ///   
linec(3) cist(pastel2) cic(6) scatsty(category10) scatc(10)
```

_Graph created with the scheme defined above.  Code for graph production is available in Example 11._
![brewschemeEx4](../../img/brewscheme_somecolorex1.png)

### Ex 9.
An example showing a different color palette/number of colors for each graph type

```Stata
brewscheme, scheme(manycolorex1) barst(paired) barc(12) dotst(prgn) dotc(7) ///   
scatstyle(set1) scatc(8) linest(pastel2) linec(7) boxstyle(accent) boxc(4)  ///
areast(dark2) areac(5) piest(mdepoint) sunst(greys) histst(veggiese)        ///   
cist(activitiesa) matst(spectral) reflst(purd) refmst(set3) const(ylgn)     ///   
cone(puor) 
```

_Graph created with the scheme defined above.  Code for graph production is available in Example 11._
![brewschemeEx5](../../img/brewscheme_manycolorex1.png)

### Ex 10.
Using different numbers of colors from the same scheme to highlight differences and showing the use of the symbols parameter

```Stata
brewscheme, scheme(ggplot2ex2) const(orange) cone(blue) consat(20)          ///   
scatst(ggplot2) scatc(5) piest(ggplot2) piec(6) barst(ggplot2) barc(2)      ///   
linest(ggplot2) linec(2) areast(ggplot2) areac(5) somest(ggplot2) somec(15) ///   
cist(ggplot2) cic(3) themef(ggtheme) symbols(diamond triangle square)
```

_Graph created with the scheme defined above.  Code for graph production is available in Example 11._
![brewschemeEx6](../../img/brewscheme_ggplot2ex2.png)

### Ex 11.
Show output of the same graph with different schemes created by `brewscheme` and `brewtheme`.

```Stata
// Load the auto.dta dataset
sysuse auto.dta, clear

// Loop over the schemes
foreach scheme in onecolorex1 onecolorex2 ggplot2ex1 somecolorex1           ///   
manycolorex1 ggplot2ex2 { 

  // Create the same graph with each of the different schemes
  tw  fpfitci mpg weight ||                                                 ///   
    scatter mpg weight if rep78 == 1 ||                                     ///   
    scatter mpg weight if rep78 == 2 ||                                     ///    
    scatter mpg weight if rep78 == 3 ||                                     ///    
    scatter mpg weight if rep78 == 4 ||                                     ///    
    scatter mpg weight if rep78 == 5,  scheme(`scheme')                     ///   
    legend(order(1 "Frac Poly" 2 "Frac Poly" 3 "1" 4 "2"                    ///   
    5 "3" 6 "4" 7 "5")) name(`scheme', replace)
    
}  // End of Loop over scheme files
```

<a name="references"></a>
## References
[Bostock, M., Ogievetsky, V., & Heer, J. (2011).  D3: data driven documents. *IEEE Transactions on Visualization & Computer Graphics. 17(12)* pp 2301 - 2309. Retrieved from http://vis.stanford.edu/papers/d3](http://vis.stanford.edu/papers/d3)  

[Brewer, C. A. (2002). Color Brewer 2. [Computer Software]. State College, PA: Cynthia Brewer, Mark Harrower, and The Pennsylvania State University](http://www.ColorBrewer2.org)

[Krzywinski, M. (2015). *Color palettes for color blindness*.  Retrieved on: 22nov2015.  Retrieved from: http://mkweb.bcgsc.ca/colorblind/](http://mkweb.bcgsc.ca/colorblind/)

[Lin, S., Fortuna, J., Kulkarni, C., Stone, M., {c 38} Heer, J. (2013). Selecting Semantically-Resonant Colors for Data Visualization. *Computer Graphics Forum 32(3)* pp. 401-410.  Retrieved from http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf](http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf)

[Wickham, H. (2009).  *ggplot2: Elegant Graphics for Data Analysis*.  New York City, NY: Springer Science+Business Media LLC.](http://www.amazon.com/ggplot2-Elegant-Graphics-Data-Analysis/dp/0387981403)
 
## License
Please view  section 4 of the ColorBrewer copyright notice for additional information pertaining to the licensing and redistribution of ColorBrew intellectual property.
 
 
## Acknowledgements
Development of this program began while I was a Strategic Data Fellow at the Mississippi Department of Education.
 
 
