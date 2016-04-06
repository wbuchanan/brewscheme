/* brewproof examples based on the brewscheme examples graphs */

// Load the auto.dta dataset
sysuse auto.dta, clear

// Loop over the schemes
foreach scheme in onecolorex1 onecolorex2 ggplot2ex1 		  ///   
somecolorex1 manycolorex1 ggplot2ex2 { 

	// Create the same graph with each of the different schemes
	brewproof, scheme(`scheme') : tw fpfitci mpg weight ||	  ///   
		scatter mpg weight if rep78 == 1 || 				  ///   
		scatter mpg weight if rep78 == 2 || 				  ///   
		scatter mpg weight if rep78 == 3 || 				  ///    
		scatter mpg weight if rep78 == 4 || 				  ///    
		scatter mpg weight if rep78 == 5,   				  ///   
		legend(order(1 "Frac Poly" 2 "Frac Poly" 3 "1" 4 "2"  ///   
		5 "3" 6 "4" 7 "5")) name(`scheme', replace)
		
	// Export to an eps file
	qui: gr export `"$articledir/img/brewProof_`scheme'.png"',    ///   
	as(png) replace
	
} // End of Loop over scheme files
