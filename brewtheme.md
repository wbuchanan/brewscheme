---
layout: page
title: brewtheme
permalink: /brewtheme/
---

# BREWTHEME

This program is used to set global aesthetic properties (e.g., gridlines, number of axis ticks, etc...) that are generally independent of specific plot/graph types. [BREWSCHEME](https://wbuchanan.github.io/brewscheme) has been updated to allow a "theme" file to be passed to it as an argument, or will generate a theme file with the same defaults that have been used in [BREWSCHEME](https://wbuchanan.github.io/brewscheme/brewscheme) since the beginning of the project.  


## Examples
This is a first attempt/example at creating a theme file that emulates the aesthetics of the 
[ggplot2](https://github.com/hadley/ggplot2) package for the R language.  

Change End of Line delimiter, generate the theme file used to simulate ggplot2 aesthetics, and then switch back to carriage-return end of line delimiter.

```
// Generate the theme file used to simulate ggplot2 aesthetics
brewtheme ggplot2, numticks("major 5" "horizontal_major 5" "vertical_major 5" ///    
"horizontal_minor 10" "vertical_minor 10") color("plotregion gs15" 			 ///   
"matrix_plotregion gs15" "background gs15" "textbox gs15" "legend gs15" 	 ///   
"box gs15" "mat_label_box gs15" "text_option_fill gs15" "clegend gs15" 		 ///   
"histback gs15" "pboxlabelfill gs15" "plabelfill gs15" "pmarkbkfill gs15"	 ///    
"pmarkback gs15") linew("major_grid medthick" "minor_grid thin" "legend medium" ///   
"clegend medium") clockdir("legend_position 3") yesno("draw_major_grid yes"  ///   
"draw_minor_grid yes" "legend_force_draw yes" "legend_force_nodraw no" 		 ///   
"draw_minor_vgrid yes" "draw_minor_hgrid yes" "extend_grid_low yes" 		 ///   
"extend_grid_high yes" "extend_axes_low no" "extend_axes_high no") 			 ///   
gridsty("minor minor") axissty("horizontal_default horizontal_withgrid" 	 ///   
"vertical_default vertical_withgrid") linepattern("major_grid solid" 		 ///   
"minor_grid solid") linesty("major_grid major_grid" "minor_grid minor_grid") ///    
ticksty("minor minor_notick" "minor_notick minor_notick") 					 ///   
ticksetsty("major_vert_withgrid minor_vert_nolabel" 						 ///   
"major_horiz_withgrid minor_horiz_nolabel" 									 ///   
"major_horiz_nolabel major_horiz_default" 									 ///   
"major_vert_nolabel major_vert_default") gsize("minortick_label zero" 		 ///   
"minortick tiny") numsty("legend_cols 1" "legend_rows 0") 					 ///   
verticaltext("legend top")
```
 
Create a new scheme file using the theme file created above and the ggplot2 color palette

```
brewscheme, scheme(ggtest2) const(orange) cone(blue) consat(20) 			 ///  
scatst(ggplot2) scatc(5) piest(ggplot2) piec(6) barst(ggplot2) barc(2) 		 ///   
linest(ggplot2) linec(2) areast(ggplot2) areac(5) somest(ggplot2) somec(24)  ///   
cist(ggplot2) cic(3) themef(ggplot2)
```

Load the auto.dta data set and create a graph w/pseudo-ggplot2 aesthetics

```
sysuse auto.dta, clear

tw lowess mpg weight, || scatter mpg weight if rep78 == 1 || 				 ///   
scatter mpg weight if rep78 == 2 || scatter mpg weight if rep78 == 3 || 	 ///   
scatter mpg weight if rep78 == 4 || scatter mpg weight if rep78 == 5, 		 ///   
scheme(ggtest2) legend(order(2 "1978 Repair Record = 1" 					 ///   
3 "1978 Repair Record = 2" 4 "1978 Repair Record = 3"						 ///   
5 "1978 Repair Record = 4" 6 "1978 Repair Record = 5"))
```   

![brewtheme Example 1](../img/ggthemeTest.png)
Figure 1. *Example of graph created with ggplot2 theme file and ggplot2 color palettes in Stata.*