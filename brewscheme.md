---
layout: page
title: brewscheme
permalink: /brewscheme/
---

A program to help Stata users developing graph schemes using research-based color palettes.  Unlike other uses of the color palettes developed by Brewer (see References below), this program allows users to specify the number of colors from any of the 35 color palettes they would like to use and allows users to mix/combine different palettes for the various graph types available in Stata.  Since starting the program, it has grown to include color resources from: [d3.scale.category10()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category10), [d3.scale.category20()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20), [d3.scale.category20b()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20b), and [d3.scale.category20c()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20c) from the [D3js](http://www.d3js.org) library; default colors used by [ggplot2](https://github.com/hadley/ggplot2) for 2-24 colors; semantic color mappings studied by [Lin, Fortuna, Kulkarni, Stone, & Heer (2013)](http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf); and additional colors are in the process of being added.

## Examples

### Ex 1. Single color palette for all graphs
Generate a graph scheme using the set1 color brewer palette for all graphs.  Use the first five colors of the palette and set the color intensity to 80 for each of the graphs.

```
brewscheme, scheme(set1) allst(set1) allc(5) allsat(80)
```

### Ex 2. Distinct Color Palette for Bar Graphs and Scatter Plots with Default Color Palette for All Other Graphs
Generate a graph scheme using the set1 color brewer palette for scatterplots, pastel1 for bar graphs, and brown to blue-green for all other graph types.  Use the default values of colors and intensity for each.

```
brewscheme, scheme(mixed1) scatst(set1) barst(pastel1) somest(brbg)
```

### Ex 3. Distinct Color Palette for Each Graph Type.
Create a graph scheme with a distinct color palette for each graph type:

```
brewscheme, scheme(myriadColorPalettes) barst(paired) barc(12) dotst(prgn) dotc(7) ///   
scatstyle(set1) scatc(9) linest(pastel2) linec(8) boxstyle(accent) boxc(8)         ///   
areast(dark2) areac(8) piest(mdepoint) sunst(greys) histst(veggiese)               ///   
cist(activitiesa) matst(spectral) reflst(purd) refmst(set3) const(ylgn)            ///   
cone(puor)
```

# References
[Bostock, M., Ogievetsky, V., & Heer, J. (2011).  D3: data driven documents. *IEEE Transactions on Visualization & Computer Graphics. 17(12)* pp 2301 - 2309. Retrieved from http://vis.stanford.edu/papers/d3](http://vis.stanford.edu/papers/d3)  

[Brewer, C. A. (2002). Color Brewer 2. [Computer Software]. State College, PA: Cynthia Brewer, Mark Harrower, and The Pennsylvania State University](http://www.ColorBrewer2.org)

[Krzywinski, M. (2015). *Color palettes for color blindness*.  Retrieved on: 22nov2015.  Retrieved from: http://mkweb.bcgsc.ca/colorblind/](http://mkweb.bcgsc.ca/colorblind/)

[Lin, S., Fortuna, J., Kulkarni, C., Stone, M., {c 38} Heer, J. (2013). Selecting Semantically-Resonant Colors for Data Visualization. *Computer Graphics Forum 32(3)* pp. 401-410.  Retrieved from http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf](http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf)

[Wickham, H. (2009).  *ggplot2: Elegant Graphics for Data Analysis*.  New York City, NY: Springer Science+Business Media LLC.](http://www.amazon.com/ggplot2-Elegant-Graphics-Data-Analysis/dp/0387981403)
