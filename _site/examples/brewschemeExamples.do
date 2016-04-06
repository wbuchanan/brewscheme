/* brewscheme examples */

// Example 1 for help site
brewscheme, scheme(set1) allst(set1) allc(5) allsat(80)

// Example 2 for help site
// Generate a graph scheme using the set1 color brewer palette for          ///   
// scatterplots, pastel1 for bar graphs, and brown to blue-green for all    ///   
// other graph types.  Use the default values of colors and intensity for   ///   
// each.
brewscheme, scheme(mixed1) scatst(set1) barst(pastel1) somest(brbg)

// Example 3  requires updating the markdown file
// Shows combination of D3js color palettes
brewscheme, scheme(mixed2) scatst(category10) scatc(5) barst(category20) 	///   
barc(15) boxsty(category20b) boxc(13) somesty(ggplot2) somec(7)


// Example 4
// Create a graph scheme with a distinct color palette for each graph type
brewscheme, scheme(myriadColorPalettes) barst(paired) barc(12) dotst(prgn)  ///   
dotc(7) scatstyle(set1) scatc(8) linest(pastel2) linec(7) boxstyle(accent)  ///   
boxc(7) areast(dark2) areac(7) piest(mdepoint) sunst(greys)                 ///   
histst(veggiese) cist(activitiesa) matst(spectral) reflst(purd)             ///   
refmst(set3) const(ylgn) cone(puor)

// Create a mono color scheme with three colors; this will cause all layers 
// beyond the third to not be drawn (e.g., there won't be colors defined for 
// Stata to use to assign colors to points/lines, etc...)
brewscheme, scheme(onecolorex1) allsty(ggplot2)

// Use the ggplot2 color palette with s2color theme settings; this uses 4 
// colors to help highlight how these cases are handled by Stata
brewscheme, scheme(onecolorex2) allsty(ggplot2) allc(4)	///   
themef(s2theme)

// Now five colors from same palette using the ggplot2 
// inspired theme
brewscheme, scheme(ggplot2ex1) allsty(ggplot2) allc(5)  ///   
themef(ggtheme)

// An Example showing the use of the some parameters
brewscheme, scheme(somecolorex1) somest(ggplot2) 		///   
somec(7) linest(dark2) linec(3) cist(pastel2) cic(6) 	///   
scatsty(category10) scatc(10)

// An example showing a different color palette/number 
// of colors for each graph type
brewscheme, scheme(manycolorex1) barst(paired) barc(12) ///   
dotst(prgn) dotc(7) scatstyle(set1) scatc(8) 			///   
linest(pastel2) linec(7) boxstyle(accent) boxc(4) 	    ///   
areast(dark2) areac(5) piest(mdepoint) sunst(greys) 	///   
histst(veggiese) cist(activitiesa) matst(spectral) 		///   
reflst(purd) refmst(set3) const(ylgn) cone(puor) 

// Using different numbers of colors from the same scheme 
// to highlight differences and showing the use of the 
// symbols parameter
brewscheme, scheme(ggplot2ex2) const(orange) cone(blue) ///   
consat(20) scatst(ggplot2) scatc(5) piest(ggplot2) 		///   
piec(6) barst(ggplot2) barc(2) linest(ggplot2) linec(2) ///   
areast(ggplot2) areac(5) somest(ggplot2) somec(15) 		///   
cist(ggplot2) cic(3) themef(ggtheme) 					///   
symbols(diamond triangle square)

// Load the auto.dta dataset
sysuse auto.dta, clear

// Loop over the schemes
foreach scheme in onecolorex1 onecolorex2 ggplot2ex1 	///   
somecolorex1 manycolorex1 ggplot2ex2 { 

	// Create the same graph with each of the different schemes
	tw 	fpfitci mpg weight ||								  ///   
		scatter mpg weight if rep78 == 1 || 				  ///   
		scatter mpg weight if rep78 == 2 || 				  ///    
		scatter mpg weight if rep78 == 3 || 				  ///    
		scatter mpg weight if rep78 == 4 || 				  ///    
		scatter mpg weight if rep78 == 5,  scheme(`scheme')   ///   
		legend(order(1 "Frac Poly" 2 "Frac Poly" 3 "1" 4 "2"  ///   
		5 "3" 6 "4" 7 "5")) name(`scheme', replace)
		
	// Export to an eps file
	qui: gr export `"$articledir/img/brewscheme_`scheme'.png"',   ///   
	as(png) replace

}  // End of Loop over scheme files
