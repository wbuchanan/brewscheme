---
layout: page
title: about
---

**brewscheme** is a Stata utility for the creation of data visualizations.  The package includes tools for conversions between colorspaces, color interpolation, setting global graph aesthetics, setting plot type aesthetics and previewing color palette combinations.  Most importantly for Stata users, this program saves *you* time.  Rather than constantly needing to pass arguments to aesthetic parameters, you can create a theme and/or scheme file to store these settings.  Then, you only need to pass an argument like `scheme(myschemeFileName)` to the command to the graph command to use all of your aesthetic settings without having to manually enter them.  

# Installation
**If you are using Windoze 10 you must make sure that the personal directory on your adopath is readable (by default this is usually C:\ado\personal)**.  On most systems the personal directory should be writable by the user, but some individuals have had difficulties using `brewscheme` due to file permission errors they believe were caused by updating to Windoze 10.  You can check on the location of your personal directory using `sysdir` from within Stata.  

## Additional information about installation
If you already installed a previous version of brewscheme, there are a few quick/minor things you'll need to do on your system to enable all the functionality of the programs:

```
// Next build out the color database (which also creates color blind translations of the Stata named color styles)
brewcolordb, ref

// If you also wanted to install all of the named colors available from the XKCD you can skip the step above and use:
brewcolors xkcd, make install ref

// If you've previously installed brewscheme, you'll also need to rebuild the look up data set used by brewscheme
// to build the scheme files (the difference is that this file will now also include the color sight impairment simulation values)
// You can also accomplish the step above this by passing the refresh option to brewscheme
brewdb, ref
```

If you used the second option above `brewcolors xkcd, make install ref`, you should see something like:

![brewcolors Example 1](../img/brewcolorsex1.png)

when you look for named color styles in Stata.  Additionally, you should also have translated version of the Stata named color styles available as well:

![brewcolors Example 2](../img/brewcolorsex2.png)

Once you've done this you should be all set.  If the look up database is not present when `brewscheme` is called it will build the file automatically for you, but before you can create a scheme/theme file you'll need to have the data set and modified named color styles created by `brewcolordb`.


# References
[Bostock, M., Ogievetsky, V., & Heer, J. (2011).  D3: data driven documents. *IEEE Transactions on Visualization & Computer Graphics. 17(12)* pp 2301 - 2309. Retrieved from http://vis.stanford.edu/papers/d3](http://vis.stanford.edu/papers/d3)  

[Brewer, C. A. (2002). Color Brewer 2. [Computer Software]. State College, PA: Cynthia Brewer, Mark Harrower, and The Pennsylvania State University](http://www.ColorBrewer2.org)

[Krzywinski, M. (2015). *Color palettes for color blindness*.  Retrieved on: 22nov2015.  Retrieved from: http://mkweb.bcgsc.ca/colorblind/](http://mkweb.bcgsc.ca/colorblind/)

[Lin, S., Fortuna, J., Kulkarni, C., Stone, M., {c 38} Heer, J. (2013). Selecting Semantically-Resonant Colors for Data Visualization. *Computer Graphics Forum 32(3)* pp. 401-410.  Retrieved from http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf](http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf)

[Lindbloom, B. (2001).  RGB working space information. Retrieved from: http://www.brucelindbloom.com/WorkingSpaceInfo.html.  Retrieved on 24nov2015.](http://www.brucelindbloom.com/WorkingSpaceInfo.html)

[Meyer, G. W., & Greenberg, D. P. (1988). Color-Defective Vision and Computer Graphics Displays. *Computer Graphics and Applications, IEEE 8(5),* pp. 28-40.](http://www-users.cs.umn.edu/~meyer/papers/meyer-greenberg-cga-1988.pdf)

[Smith, V. C., & Pokorny, J. (2005).  Spectral sensitivity of the foveal cone photopigments between 400 and 500nm.  *Journal of the Optical Society of America A, 22(10),* pp. 2060-2071.](http://macboy.uchicago.edu/~eye1/PDF%20files/Smith%20Pokorny%2075.pdf)

[Wickham, H. (2009).  *ggplot2: Elegant Graphics for Data Analysis*.  New York City, NY: Springer Science+Business Media LLC.](http://www.amazon.com/ggplot2-Elegant-Graphics-Data-Analysis/dp/0387981403)

[Wickline, M. (2014).  Color.Vision.Simulate, Version 0.1.  Retrieved from: http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js.  Retrieved on: 24nov2015](http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js)
