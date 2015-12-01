---
layout: page
title: brewviewer
permalink: /brewviewer/
---

Preview sequences of 3-5, 3-8, 3-10, and 3-12 color palettes for the [D3js](http://www.d3js.org) ordinal scales [d3.scale.category10()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category10), [d3.scale.category20()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20), [d3.scale.category20b()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20b), and [d3.scale.category20c()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20c) respectively.

# Beta feature
A new feature recently added to this program is an option to show palettes under differing conditions of colorblindness.  There is still a decent amount of testing/checking to be done, but here is an early preview of what the feature does:

```
brewviewer category10, im seq c(6)
```
![brewviewer Example 4beta](../img/brewviewerex4.png)

The feature is enabled by specifying the `IMpaired` option (abbreviated as `im` above).


```
brewviewer category10 category20 category20b category20c, c(5 8 10 12)  comb seq
```
![brewviewer Example 1](../img/brewviewerex1.png)


Preview sequences for color palettes with 3-5 colors for multiple palettes simultaneously and combine in a single image.
```
brewviewer dark2 mdebar accent pastel2 set1 tableau, c(5) seq comb
```
![brewviewer Example 2](../img/brewviewerex2.png)

Similar to example above, but only show instances with the colors 1-5 for each of the color palettes:
``` 
brewviewer dark2 mdebar accent pastel2 set1 tableau, c(5) comb
```
![brewviewer Example 3](../img/brewviewerex3.png)


## References
[Bostock, M., Ogievetsky, V., & Heer, J. (2011).  D3: data driven documents. *IEEE Transactions on Visualization & Computer Graphics. 17(12)* pp 2301 - 2309. Retrieved from http://vis.stanford.edu/papers/d3](http://vis.stanford.edu/papers/d3)  

[Brewer, C. A. (2002). Color Brewer 2. [Computer Software]. State College, PA: Cynthia Brewer, Mark Harrower, and The Pennsylvania State University](http://www.ColorBrewer2.org)

[Krzywinski, M. (2015). *Color palettes for color blindness*.  Retrieved on: 22nov2015.  Retrieved from: http://mkweb.bcgsc.ca/colorblind/](http://mkweb.bcgsc.ca/colorblind/)

[Lin, S., Fortuna, J., Kulkarni, C., Stone, M., {c 38} Heer, J. (2013). Selecting Semantically-Resonant Colors for Data Visualization. *Computer Graphics Forum 32(3)* pp. 401-410.  Retrieved from http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf](http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf)

[Lindbloom, B. (2001).  RGB working space information. Retrieved from: http://www.brucelindbloom.com/WorkingSpaceInfo.html.  Retrieved on 24nov2015.](http://www.brucelindbloom.com/WorkingSpaceInfo.html)

[Meyer, G. W., & Greenberg, D. P. (1988). Color-Defective Vision and Computer Graphics Displays. *Computer Graphics and Applications, IEEE 8(5),* pp. 28-40.](http://www-users.cs.umn.edu/~meyer/papers/meyer-greenberg-cga-1988.pdf)

[Smith, V. C., & Pokorny, J. (2005).  Spectral sensitivity of the foveal cone photopigments between 400 and 500nm.  *Journal of the Optical Society of America A, 22(10),* pp. 2060-2071.](http://macboy.uchicago.edu/~eye1/PDF%20files/Smith%20Pokorny%2075.pdf)

[Wickham, H. (2009).  *ggplot2: Elegant Graphics for Data Analysis*.  New York City, NY: Springer Science+Business Media LLC.](http://www.amazon.com/ggplot2-Elegant-Graphics-Data-Analysis/dp/0387981403)

[Wickline, M. (2014).  Color.Vision.Simulate, Version 0.1.  Retrieved from: http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js.  Retrieved on: 24nov2015](http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js)
