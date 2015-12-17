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


## Gallery
The full set of palettes (based on the maximum number of colors available in the palette), displayed with the sequential option and impaired options is available below.  

### accent

![brewviewer Example 4.](../img/accent_7.png)

### activitiesa

![brewviewer Example 5.](../img/activitiesa_5.png)

### activitiest

![brewviewer Example 6.](../img/activitiest_5.png)

### blues

![brewviewer Example 7.](../img/blues_8.png)

### brandsa

![brewviewer Example 8.](../img/brandsa_7.png)

### brandse

![brewviewer Example 9.](../img/brandse_7.png)

### brbg

![brewviewer Example 10.](../img/brbg_10.png)

### bugn

![brewviewer Example 11.](../img/bugn_8.png)

### bupu

![brewviewer Example 12.](../img/bupu_8.png)

### carsa

![brewviewer Example 13.](../img/carsa_6.png)

### carse

![brewviewer Example 14.](../img/carse_6.png)

### category10

![brewviewer Example 15.](../img/category10_10.png)

### category20

![brewviewer Example 16.](../img/category20_20.png)

### category20b

![brewviewer Example 17.](../img/category20b_20.png)

### category20c

![brewviewer Example 18.](../img/category20c_20.png)

### dark2

![brewviewer Example 19.](../img/dark2_7.png)

### drinksa

![brewviewer Example 20.](../img/drinksa_7.png)

### drinkse

![brewviewer Example 21.](../img/drinkse_7.png)

### featuresa

![brewviewer Example 22.](../img/featuresa_5.png)

### featurest

![brewviewer Example 23.](../img/featurest_5.png)

### fooda

![brewviewer Example 24.](../img/fooda_7.png)

### foode

![brewviewer Example 25.](../img/foode_7.png)

### fruita

![brewviewer Example 26.](../img/fruita_7.png)

### fruite

![brewviewer Example 27.](../img/fruite_7.png)

### ggplot2

![brewviewer Example 28.](../img/ggplot2_24.png)

### gnbu

![brewviewer Example 29.](../img/gnbu_8.png)

### greens

![brewviewer Example 30.](../img/greens_8.png)

### greys

![brewviewer Example 31.](../img/greys_8.png)

### mdebar

![brewviewer Example 32.](../img/mdebar_5.png)

### mdepoint

![brewviewer Example 33.](../img/mdepoint_3.png)

### oranges

![brewviewer Example 34.](../img/oranges_8.png)

### orrd

![brewviewer Example 35.](../img/orrd_8.png)

### paired

![brewviewer Example 36.](../img/paired_12.png)

### pastel1

![brewviewer Example 37.](../img/pastel1_8.png)

### pastel2

![brewviewer Example 38.](../img/pastel2_7.png)

### piyg

![brewviewer Example 39.](../img/piyg_10.png)

### prgn

![brewviewer Example 40.](../img/prgn_10.png)

### pubu

![brewviewer Example 41.](../img/pubu_8.png)

### pubugn

![brewviewer Example 42.](../img/pubugn_8.png)

### puor

![brewviewer Example 43.](../img/puor_10.png)

### purd

![brewviewer Example 44.](../img/purd_8.png)

### purples

![brewviewer Example 45.](../img/purples_8.png)

### rdbu

![brewviewer Example 46.](../img/rdbu_10.png)

### rdgy

![brewviewer Example 47.](../img/rdgy_10.png)

### rdpu

![brewviewer Example 48.](../img/rdpu_8.png)

### rdylbu

![brewviewer Example 49.](../img/rdylbu_10.png)

### rdylgn

![brewviewer Example 50.](../img/rdylgn_10.png)

### reds

![brewviewer Example 51.](../img/reds_8.png)

### set1

![brewviewer Example 52.](../img/set1_8.png)

### set2

![brewviewer Example 53.](../img/set2_7.png)

### set3

![brewviewer Example 54.](../img/set3_12.png)

### spectral

![brewviewer Example 55.](../img/spectral_10.png)

### tableau

![brewviewer Example 56.](../img/tableau_20.png)

### veggiesa

![brewviewer Example 57.](../img/veggiesa_7.png)

### veggiese

![brewviewer Example 58.](../img/veggiese_7.png)

### ylgn

![brewviewer Example 59.](../img/ylgn_8.png)

### ylgnbu

![brewviewer Example 60.](../img/ylgnbu_8.png)

### ylorbr

![brewviewer Example 61.](../img/ylorbr_8.png)

### ylorrd

![brewviewer Example 62.](../img/ylorrd_8.png)



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
