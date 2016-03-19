---
layout: page
title: brewviewer
permalink: /help/brewviewer/
---

<hr>
A command to preview one or more brewscheme color palettes
<hr>
<a name="top"></a>
__brewviewer__ -- A utility for brewscheme to preview color palettes available.

## Syntax

__brewviewer__ <em>palette names</em> [, <u>c</u>olors(numlist) <u>comb</u>ine <u>s</u>eq <u>im</u>paired ]

## Description

brewviewer is a utility for the brewscheme program that provides you with a way to preview different combinations of palettes and numbers of colors.  You can view examples of each of the palettes distributed with [brewscheme](https://github.com/wbuchanan/brewscheme) in the <a href="#gallery">Gallery</a> below.  The table below is provided for more immediate access to a specific color palette preview:

<table>
<th>Color Palettes</th><th>Color Palettes</th>
<tr><td><a name="accent">accent</a></td><td><a name="activitiesa">activitiesa</a></td></tr>
<tr><td><a name="activitiest">activitiest</a></td><td><a name="blues">blues</a></td></tr>
<tr><td><a name="brandsa">brandsa</a></td><td><a name="brandse">brandse</a></td></tr>
<tr><td><a name="brbg">brbg</a></td><td><a name="bugn">bugn</a></td></tr>
<tr><td><a name="bupu">bupu</a></td><td><a name="carsa">carsa</a></td></tr>
<tr><td><a name="carse">carse</a></td><td><a name="category10">category10</a></td></tr>
<tr><td><a name="category20">category20</a></td><td><a name="category20b">category20b</a></td></tr>
<tr><td><a name="category20c">category20c</a></td><td><a name="dark2">dark2</a></td></tr>
<tr><td><a name="drinksa">drinksa</a></td><td><a name="drinkse">drinkse</a></td></tr>
<tr><td><a name="featuresa">featuresa</a></td><td><a name="featurest">featurest</a></td></tr>
<tr><td><a name="fooda">fooda</a></td><td><a name="foode">foode</a></td></tr>
<tr><td><a name="fruita">fruita</a></td><td><a name="fruite">fruite</a></td></tr>
<tr><td><a name="ggplot2">ggplot2</a></td><td><a name="gnbu">gnbu</a></td></tr>
<tr><td><a name="greens">greens</a></td><td><a name="greys">greys</a></td></tr>
<tr><td><a name="mdebar">mdebar</a></td><td><a name="mdepoint">mdepoint</a></td></tr>
<tr><td><a name="oranges">oranges</a></td><td><a name="orrd">orrd</a></td></tr>
<tr><td><a name="paired">paired</a></td><td><a name="pastel1">pastel1</a></td></tr>
<tr><td><a name="pastel2">pastel2</a></td><td><a name="piyg">piyg</a></td></tr>
<tr><td><a name="prgn">prgn</a></td><td><a name="pubu">pubu</a></td></tr>
<tr><td><a name="pubugn">pubugn</a></td><td><a name="puor">puor</a></td></tr>
<tr><td><a name="purd">purd</a></td><td><a name="purples">purples</a></td></tr>
<tr><td><a name="rdbu">rdbu</a></td><td><a name="rdgy">rdgy</a></td></tr>
<tr><td><a name="rdpu">rdpu</a></td><td><a name="rdylbu">rdylbu</a></td></tr>
<tr><td><a name="rdylgn">rdylgn</a></td><td><a name="reds">reds</a></td></tr>
<tr><td><a name="set1">set1</a></td><td><a name="set2">set2</a></td></tr>
<tr><td><a name="set3">set3</a></td><td><a name="spectral">spectral</a></td></tr>
<tr><td><a name="tableau">tableau</a></td><td><a name="veggiesa">veggiesa</a></td></tr>
<tr><td><a name="veggiese">veggiese</a></td><td><a name="ylgn">ylgn</a></td></tr>
<tr><td><a name="ylgnbu">ylgnbu</a></td><td><a name="ylorbr">ylorbr</a></td></tr>
<tr><td><a name="ylorrd">ylorrd</a></td><td></td></tr>

</table>

For additional information about the palettes and/or transformations, <a href="#references">see the references listed below</a>.

## Options

<u>c</u>olors is a required argument and is used to specify the number of colors to preview.  If a single argument is passed it is used for all palettes.  If the number of color values passed is the same as the number of palettes the program will treat the values as being specific to the corresponding palette specified.  If there are fewer colors than palettes, the maximum value of the colors parameter will be used for the graphs if the seq option is passed, else the same colors are recycled for each of the graphs.  Lastly, if the number of colors passed is greater than the number of palettes, it will override the seq option and treat each of the numbers as discrete for all palettes.

<u>comb</u>ine is an optional argument used to generate a single combined graph with each of the graphs combined in a single image.

<u>s</u>eq is an optional argument used to tell the program that you want to treat the number of colors as the maximum number of sequences to graph.  For example, if a value of 5 is passed to colors and seq is selected, the resulting graph will contain columns showing colors 1-3, 1-4, and 1-5.  If this option is not selected, it will only show a single column of colors from 1-5.

<u>im</u>paired is an optional argument to display the palette(s) along with color sight impaired transformations of the colors.

## Examples

### Ex 1.
Show the [D3js category10](https://github.com/mbostock/d3/wiki/Ordinal-Scales#categorical-colors) palette with up to 6 colors with color sight impaired transformed colors

```
brewviewer category10, im seq c(6)
```
![brewviewerEx1](../../img/brewviewerEx1.png)

### Ex 2.
Display colors from multiple palettes with varying numbers of colors for each palette.

```
brewviewer category10 category20 category20b category20c, c(5 8 10 12)  comb seq
```
![brewviewerEx2](../../img/brewviewerEx2.png)

### Ex 3.
Preview sequences for color palettes with 3-5 colors for multiple palettes simultaneously and combine in a single image.

```
brewviewer dark2 mdebar accent pastel2 set1 tableau, c(5) seq comb
```
![brewviewerEx3](../../img/brewviewerEx3.png)

### Ex 4.
Similar to example above, but only show instances with the colors 1-5 for each of the color palettes:

``` 
brewviewer dark2 mdebar accent pastel2 set1 tableau, c(5) comb
```
![brewviewerEx4](../../img/brewviewerEx4.png)

## Acknowledgements

This subroutine for brewscheme was inspired and influenced by [Mattieu Gomez's](https://github.com/matthieugomez) program [stata-colorscheme](https://github.com/matthieugomez/stata-colorscheme).

<a name="gallery"></a>

## Gallery 
The full set of palettes (based on the maximum number of colors available in the palette), displayed with the sequential option and impaired options is available below.  

### accent
<a name="accent"></a>
![galleryEx4.](../../img/accent_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### activitiesa
<a name="activitiesa"></a>
![galleryEx1](../../img/activitiesa_5.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### activitiest
<a name="activitiest"></a>
![galleryEx2](../../img/activitiest_5.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### blues
<a name="blues"></a>
![galleryEx3](../../img/blues_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### brandsa
<a name="brnadsa"></a>
![galleryEx4](../../img/brandsa_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### brandse
<a name="brandse"></a>
![galleryEx5](../../img/brandse_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### brbg
<a name="brbg"></a>
![galleryEx6](../../img/brbg_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### bugn
<a name="bugn"></a>
![galleryEx7](../../img/bugn_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### bupu
<a name="bupu"></a>
![galleryEx8](../../img/bupu_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### carsa
<a name="carsa"></a>
![galleryEx9](../../img/carsa_6.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### carse
<a name="carse"></a>
![galleryEx10](../../img/carse_6.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### category10
<a name="category10"></a>
![galleryEx11](../../img/category10_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### category20
<a name="category20"></a>
![galleryEx12](../../img/category20_20.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### category20b
<a name="category20b"></a>
![galleryEx13](../../img/category20b_20.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### category20c
<a name="category20c"></a>
![galleryEx14](../../img/category20c_20.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### dark2
<a name="dark2"></a>
![galleryEx15](../../img/dark2_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### drinksa
<a name="drinksa"></a>
![galleryEx16](../../img/drinksa_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### drinkse
<a name="drinkse"></a>
![galleryEx17](../../img/drinkse_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### featuresa
<a name="featuresa"></a>
![galleryEx18](../../img/featuresa_5.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### featurest
<a name="featurest"></a>
![galleryEx19](../../img/featurest_5.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### fooda
<a name="fooda"></a>
![galleryEx20](../../img/fooda_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### foode
<a name="foode"></a>
![galleryEx21](../../img/foode_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### fruita
<a name="fruita"></a>
![galleryEx22](../../img/fruita_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### fruite
<a name="fruite"></a>
![galleryEx23](../../img/fruite_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### ggplot2
<a name="ggplot2"></a>
![galleryEx24](../../img/ggplot2_24.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### gnbu
<a name="gnbu"></a>
![galleryEx25](../../img/gnbu_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### greens
<a name="greens"></a>
![galleryEx26](../../img/greens_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### greys
<a name="greys"></a>
![galleryEx27](../../img/greys_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### mdebar
<a name="mdebar"></a>
![galleryEx28](../../img/mdebar_5.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### mdepoint
<a name="mdepoint"></a>
![galleryEx29](../../img/mdepoint_3.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### oranges
<a name="oranges"></a>
![galleryEx30](../../img/oranges_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### orrd
<a name="orrd"></a>
![galleryEx31](../../img/orrd_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### paired
<a name="paired"></a>
![galleryEx32](../../img/paired_12.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### pastel1
<a name="pastel1"></a>
![galleryEx33](../../img/pastel1_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### pastel2
<a name="pastel2"></a>
![galleryEx34](../../img/pastel2_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### piyg
<a name="piyg"></a>
![galleryEx35](../../img/piyg_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### prgn
<a name="prgn"></a>
![galleryEx36](../../img/prgn_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### pubu
<a name="pubu"></a>
![galleryEx37](../../img/pubu_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### pubugn
<a name="pubugn"></a>
![galleryEx38](../../img/pubugn_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### puor
<a name="puor"></a>
![galleryEx39](../../img/puor_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### purd
<a name="purd"></a>
![galleryEx40](../../img/purd_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### purples
<a name="purples"></a>
![galleryEx41](../../img/purples_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### rdbu
<a name="rdbu"></a>
![galleryEx42](../../img/rdbu_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### rdgy
<a name="rdgy"></a>
![galleryEx43](../../img/rdgy_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### rdpu
<a name="rdpu"></a>
![galleryEx44](../../img/rdpu_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### rdylbu
<a name="rdylbu"></a>
![galleryEx45](../../img/rdylbu_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### rdylgn
<a name="rdylgn"></a>
![galleryEx46](../../img/rdylgn_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### reds
<a name="reds"></a>
![galleryEx47](../../img/reds_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### set1
<a name="set1"></a>
![galleryEx48](../../img/set1_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### set2
<a name="set2"></a>
![galleryEx49](../../img/set2_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### set3
<a name="set3"></a>
![galleryEx50](../../img/set3_12.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### spectral
<a name="spectral"></a>
![galleryEx51](../../img/spectral_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### tableau
<a name="tableau"></a>
![galleryEx52](../../img/tableau_20.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### veggiesa
<a name="veggiesa"></a>
![galleryEx53](../../img/veggiesa_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### veggiese
<a name="veggiese"></a>
![galleryEx54](../../img/veggiese_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### ylgn
<a name="ylgn"></a>
![galleryEx55](../../img/ylgn_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### ylgnbu
<a name="ylgnbu"></a>
![galleryEx56](../../img/ylgnbu_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### ylorbr
<a name="ylorbr"></a>
![galleryEx57](../../img/ylorbr_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

### ylorrd
<a name="ylorrd"></a>
![galleryEx58](../../img/ylorrd_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="references"></a>
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
<a href="#top">back to the top</a>

