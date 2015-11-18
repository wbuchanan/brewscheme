---
layout: page
title: brewviewer
permalink: /brewviewer/
---

Preview sequences of 3-5, 3-8, 3-10, and 3-12 color palettes for the [D3js](http://www.d3js.org) ordinal scales [d3.scale.category10()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category10), [d3.scale.category20()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20), [d3.scale.category20b()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20b), and [d3.scale.category20c()](https://github.com/mbostock/d3/wiki/Ordinal-Scales#category20c) respectively.

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