# NEWS
This update to the development branch concludes the last commit with any feature additions and/or enhancements.  There is still documentation needing completion for the `brewtheme` program, but there should not be any significant changes beyond that.  Bugs will still be fixed before the version 1 release, but this version can generally be considered representative of what the stable release will look like and demonstrate the features that will be available.  

# brewscheme
A data visualization toolkit for Stata.  This package contains Stata programs; Mata functions, classes, and methods; and Java plugins to make customizing graphs in Stata easier.  The major functionality is provided by the `brewtheme` and `brewscheme` programs which generate a `.theme` file (for aesthetic settings that are not specific to a graph/plot type) and `.scheme` files (which inherit the `.theme` files and set aesthetic properties specific to plot/graph types).  In addition to the user specified/requested aesthetics, these programs also leverage the `libbrewscheme` Mata library to generate parallel versions of these files with values that simulate the appearance to individuals with achromatopsia (complete color blindness), protanopia (red color sight impairment), deuteranopia (green color sight impairment), and tritanopia (blue color sight impairment).  

There are additional programs for color interpolation (`brewterpolate`), translation between hexadecimal and RGB color spaces (`hextorgb`), estimating simulated RGB values for the forms of color sight impairments listed above (`libbrewscheme`), a color palette previewer (`brewviewer`), and a color vision simulator (`brewcbsim`).  

Together, this provides users with a powerful toolkit to customize their data visualizations generated in Stata and makes it easier and faster to incorporate Stata code into production environments that require standardization.

## Examples
To view examples, please see the [project website](https://wbuchanan.github.io/brewscheme).

 
## Other examples
For other examples of graphs created with brewscheme visit the examples from a related project [eda](https://github.com/wbuchanan/eda/blob/master/eda-example.pdf).
 
## References
[Bostock, M., Ogievetsky, V., & Heer, J. (2011).  D3: data driven documents. *IEEE Transactions on Visualization & Computer Graphics. 17(12)* pp 2301 - 2309. Retrieved from http://vis.stanford.edu/papers/d3](http://vis.stanford.edu/papers/d3)  

[Brewer, C. A. (2002). Color Brewer 2. [Computer Software]. State College, PA: Cynthia Brewer, Mark Harrower, and The Pennsylvania State University](http://www.ColorBrewer2.org)

[Krzywinski, M. (2015). *Color palettes for color blindness*.  Retrieved on: 22nov2015.  Retrieved from: http://mkweb.bcgsc.ca/colorblind/](http://mkweb.bcgsc.ca/colorblind/)

[Lin, S., Fortuna, J., Kulkarni, C., Stone, M., {c 38} Heer, J. (2013). Selecting Semantically-Resonant Colors for Data Visualization. *Computer Graphics Forum 32(3)* pp. 401-410.  Retrieved from http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf](http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf)

[Lindbloom, B. (2001).  RGB working space information. Retrieved from: http://www.brucelindbloom.com/WorkingSpaceInfo.html.  Retrieved on 24nov2015.](http://www.brucelindbloom.com/WorkingSpaceInfo.html)

[Meyer, G. W., & Greenberg, D. P. (1988). Color-Defective Vision and Computer Graphics Displays. *Computer Graphics and Applications, IEEE 8(5),* pp. 28-40.  Retrieved from: http://www-users.cs.umn.edu/~meyer/papers/meyer-greenberg-cga-1988.pdf.  Retrieved on: 26nov2015](http://www-users.cs.umn.edu/~meyer/papers/meyer-greenberg-cga-1988.pdf)

[Smith, V. C., & Pokorny, J. (2005).  Spectral sensitivity of the foveal cone photopigments between 400 and 500nm.  *Journal of the Optical Society of America A, 22(10),* pp. 2060-2071. Retrieved from: http://macboy.uchicago.edu/~eye1/PDF%20files/Smith%20Pokorny%2075.pdf.  Retrieved on: 26nov2015](http://macboy.uchicago.edu/~eye1/PDF%20files/Smith%20Pokorny%2075.pdf)

[Wickham, H. (2009).  *ggplot2: Elegant Graphics for Data Analysis*.  New York City, NY: Springer Science+Business Media LLC.](http://www.amazon.com/ggplot2-Elegant-Graphics-Data-Analysis/dp/0387981403)
	
[Wickline, M. (2014). *Color.Vision.Simulate, Version 0.1*.  Retrieved from: http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js.  Retrieved on: 24nov2015.](http://galacticmilk.com/labs/Color-Vision/Javascript/Color.Vision.Simulate.js)
	
## License Information
Please view  section 4 of the [ColorBrewer](http://www.colorbrewer2.org) copyright notice for additional information pertaining to the licensing and redistribution of ColorBrew intellectual property.  

## Additional Info
For additional information/examples about the brewscheme package see [Buchanan, W. R. (2015). Brewing color schemes in Stata: Making it easier for end users to customize Stata graphs.  Presented 31jul2015 at the  2015 Stata North American Users' Group Meeting.  Columbus, OH.](http://www.stata.com/meeting/columbus15/abstracts/materials/columbus15_buchanan.pdf)

