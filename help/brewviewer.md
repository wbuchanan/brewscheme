---
layout: page
title: brewviewer
permalink: /help/brewviewer/
---

<hr>
A command to preview one or more brewscheme color palettes
<hr>

<br>
<a name="top"></a>
__brewviewer__ -- A utility for brewscheme to preview color palettes available.

## Syntax

__brewviewer__ <em>palette names</em> [, <u>c</u>olors(numlist) <u>comb</u>ine <u>s</u>eq <u>im</u>paired ]

## Description

brewviewer is a utility for the brewscheme program that provides you with a way to preview different combinations of palettes and numbers of colors.  You can view examples of each of the palettes distributed with [brewscheme](https://github.com/wbuchanan/brewscheme) in the <a href="#gallery">Gallery</a> below.  The table below is provided for more immediate access to a specific color palette preview:

<table style="width:100%">
<th style="border-top: 1px solid black; border-bottom: 1px solid black">Color</th><th style="border-top: 1px solid black; border-bottom: 1px solid black">Palette</th><th style="border-top: 1px solid black; border-bottom: 1px solid black">Names</th>
<tr><td><a href="#accent">accent</a></td><td><a href="#activitiesa">activitiesa</a></td><td><a href="#activitiest">activitiest</a></td></tr>
<tr><td><a href="#blues">blues</a></td><td><a href="#brandsa">brandsa</a></td><td><a href="#brandse">brandse</a></td></tr>
<tr><td><a href="#brbg">brbg</a></td><td><a href="#bugn">bugn</a></td><td><a href="#bupu">bupu</a></td></tr>
<tr><td><a href="#carsa">carsa</a></td><td><a href="#carse">carse</a></td><td><a href="#category10">category10</a></td></tr>
<tr><td><a href="#category20">category20</a></td><td><a href="#category20b">category20b</a></td><td><a href="#category20c">category20c</a></td></tr>
<tr><td><a href="#dark2">dark2</a></td><td><a href="#drinksa">drinksa</a></td><td><a href="#drinkse">drinkse</a></td></tr>
<tr><td><a href="#featuresa">featuresa</a></td><td><a href="#featurest">featurest</a></td><td><a href="#fooda">fooda</a></td></tr>
<tr><td><a href="#foode">foode</a></td><td><a href="#fruita">fruita</a></td><td><a href="#fruite">fruite</a></td></tr>
<tr><td><a href="#ggplot2">ggplot2</a></td><td><a href="#gnbu">gnbu</a></td><td><a href="#greens">greens</a></td></tr>
<tr><td><a href="#greys">greys</a></td><td><a href="#mdebar">mdebar</a></td><td><a href="#mdepoint">mdepoint</a></td></tr>
<tr><td><a href="#oranges">oranges</a></td><td><a href="#orrd">orrd</a></td><td><a href="#paired">paired</a></td></tr>
<tr><td><a href="#pastel1">pastel1</a></td><td><a href="#pastel2">pastel2</a></td><td><a href="#piyg">piyg</a></td></tr>
<tr><td><a href="#prgn">prgn</a></td><td><a href="#pubu">pubu</a></td><td><a href="#pubugn">pubugn</a></td></tr>
<tr><td><a href="#puor">puor</a></td><td><a href="#purd">purd</a></td><td><a href="#purples">purples</a></td></tr>
<tr><td><a href="#rdbu">rdbu</a></td><td><a href="#rdgy">rdgy</a></td><td><a href="#rdpu">rdpu</a></td></tr>
<tr><td><a href="#rdylbu">rdylbu</a></td><td><a href="#rdylgn">rdylgn</a></td><td><a href="#reds">reds</a></td></tr>
<tr><td><a href="#set1">set1</a></td><td><a href="#set2">set2</a></td><td><a href="#set3">set3</a></td></tr>
<tr><td><a href="#spectral">spectral</a></td><td><a href="#tableau">tableau</a></td><td><a href="#veggiesa">veggiesa</a></td></tr>
<tr><td><a href="#veggiese">veggiese</a></td><td><a href="#ylgn">ylgn</a></td><td><a href="#ylgnbu">ylgnbu</a></td></tr>
<tr><td style="border-bottom: 1px solid black"><a href="#ylorbr">ylorbr</a></td><td style="border-bottom: 1px solid black"><a href="#ylorrd">ylorrd</a></td><td style="border-bottom: 1px solid black"></td></tr>
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

<a name="accent"></a>

### accent

![galleryEx4.](../../img/accent_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="activitiesa"></a>

### activitiesa

![galleryEx1](../../img/activitiesa_5.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="activitiest"></a>

### activitiest

![galleryEx2](../../img/activitiest_5.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="blues"></a>

### blues

![galleryEx3](../../img/blues_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="brnadsa"></a>

### brandsa

![galleryEx4](../../img/brandsa_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="brandse"></a>

### brandse

![galleryEx5](../../img/brandse_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="brbg"></a>

### brbg

![galleryEx6](../../img/brbg_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="bugn"></a>

### bugn

![galleryEx7](../../img/bugn_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="bupu"></a>

### bupu

![galleryEx8](../../img/bupu_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="carsa"></a>

### carsa

![galleryEx9](../../img/carsa_6.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="carse"></a>

### carse

![galleryEx10](../../img/carse_6.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="category10"></a>

### category10

![galleryEx11](../../img/category10_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="category20"></a>

### category20

![galleryEx12](../../img/category20_20.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="category20b"></a>

### category20b

![galleryEx13](../../img/category20b_20.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="category20c"></a>

### category20c

![galleryEx14](../../img/category20c_20.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="dark2"></a>

### dark2

![galleryEx15](../../img/dark2_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="drinksa"></a>

### drinksa

![galleryEx16](../../img/drinksa_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="drinkse"></a>

### drinkse

![galleryEx17](../../img/drinkse_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="featuresa"></a>

### featuresa

![galleryEx18](../../img/featuresa_5.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="featurest"></a>

### featurest

![galleryEx19](../../img/featurest_5.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="fooda"></a>

### fooda

![galleryEx20](../../img/fooda_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="foode"></a>

### foode

![galleryEx21](../../img/foode_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="fruita"></a>

### fruita

![galleryEx22](../../img/fruita_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="fruite"></a>

### fruite

![galleryEx23](../../img/fruite_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="ggplot2"></a>

### ggplot2

![galleryEx24](../../img/ggplot2_24.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="gnbu"></a>

### gnbu

![galleryEx25](../../img/gnbu_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="greens"></a>

### greens

![galleryEx26](../../img/greens_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="greys"></a>

### greys

![galleryEx27](../../img/greys_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="mdebar"></a>

### mdebar

![galleryEx28](../../img/mdebar_5.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="mdepoint"></a>

### mdepoint

![galleryEx29](../../img/mdepoint_3.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="oranges"></a>

### oranges

![galleryEx30](../../img/oranges_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="orrd"></a>

### orrd

![galleryEx31](../../img/orrd_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="paired"></a>

### paired

![galleryEx32](../../img/paired_12.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="pastel1"></a>

### pastel1

![galleryEx33](../../img/pastel1_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="pastel2"></a>

### pastel2

![galleryEx34](../../img/pastel2_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="piyg"></a>

### piyg

![galleryEx35](../../img/piyg_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="prgn"></a>

### prgn

![galleryEx36](../../img/prgn_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="pubu"></a>

### pubu

![galleryEx37](../../img/pubu_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="pubugn"></a>

### pubugn

![galleryEx38](../../img/pubugn_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="puor"></a>

### puor

![galleryEx39](../../img/puor_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="purd"></a>

### purd

![galleryEx40](../../img/purd_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="purples"></a>

### purples

![galleryEx41](../../img/purples_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="rdbu"></a>

### rdbu

![galleryEx42](../../img/rdbu_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="rdgy"></a>

### rdgy

![galleryEx43](../../img/rdgy_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="rdpu"></a>

### rdpu

![galleryEx44](../../img/rdpu_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="rdylbu"></a>

### rdylbu

![galleryEx45](../../img/rdylbu_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="rdylgn"></a>

### rdylgn

![galleryEx46](../../img/rdylgn_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="reds"></a>

### reds

![galleryEx47](../../img/reds_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="set1"></a>

### set1

![galleryEx48](../../img/set1_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="set2"></a>

### set2

![galleryEx49](../../img/set2_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="set3"></a>

### set3

![galleryEx50](../../img/set3_12.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="spectral"></a>

### spectral

![galleryEx51](../../img/spectral_10.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="tableau"></a>

### tableau

![galleryEx52](../../img/tableau_20.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="veggiesa"></a>

### veggiesa

![galleryEx53](../../img/veggiesa_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="veggiese"></a>

### veggiese

![galleryEx54](../../img/veggiese_7.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="ylgn"></a>

### ylgn

![galleryEx55](../../img/ylgn_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="ylgnbu"></a>

### ylgnbu

![galleryEx56](../../img/ylgnbu_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="ylorbr"></a>

### ylorbr

![galleryEx57](../../img/ylorbr_8.png)
<a href="#gallery">top of the gallery</a>     <a href="#top">back to the top</a>

<a name="ylorrd"></a>

### ylorrd

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

