

*! brewviewer
*! v 0.0.0
*! 07nov2015

// Drop program if already loaded in memory
cap prog drop brewviewer

// Define new program brewviewer
prog def brewviewer

	// Interpret syntax under Version 13.1
	version 13.1
	
	// Syntax structure for the program
	syntax anything(name=pal id="BrewScheme Color Palette") [, Colors(int 0) ]
	
	// Preserve the current state of the data
	preserve
	
		// Load the brewscheme dataset
		qui: use `"`c(sysdir_personal)'b/brewmeta.dta"', clear
		
		// Get the mean from the maxcolors variable (constant by palette)
		qui: su maxcolors if palette == `"`pal'"'
			
		// If the user does not specify a value for colors or specifies too few
		// to look up values
		if `colors' < 3 {
		
			// Over write the colors macro
			loc colors = `r(mean)'
			
		} // End IF Block for default colors argument behavior

		// Set to max colors if the user specified value is > max colors
		else if `colors' > `r(mean)' {
		
			// Over write the colors macro
			loc colors = `r(mean)'
			
		} // End ELSEIF Block for default colors argument behavior
		
		// Set the size of the boxes based on the log of 3 times n colors
		loc sze `= ln(`= `colors' * 3')'
		
		// Set the axis max range for 8 times the number of colors
		loc xscale `= `colors' * 8'
		
		// Loop over the smallest number of colors available in any palettes
		forv i = 3/`colors' {
		
			// Initialize a null macro to use like a StringBuilder class in Java
			loc scat`i' 
			
			// Loop over the number of unique colors based on the palette color id
			forv j = 1/`i' {
			
				// Get the RGB values for the palette with the palette color id i
				qui: levelsof rgb if pcolor == `i' & colorid == `j' & 		 ///   
				palette == `"`pal'"', loc(xrgb)
				
				// Get the individual RGB value for this iteration
				loc col "`: word 1 of `xrgb''"
				
				// 2 less than i times 8 defines the x axis positioning
				loc xpos `= `= `i' - 2' * 8'
				
				// Build the command for graphing this individual color/label
				loc scat`i' `scat`i'' (scatteri `= `j' * 7' `xpos' (12) 	 ///   
				`"`j': "`col'""', ms(S) mc("`col'") mlabc(black) 			 ///   
				msize(`sze' `sze') mlc(black) mlabsize(vsmall) mlabgap(*2.25))

			} // End Loop over colors within a given palette color id
			
			// Add these to a container macro used to build the full graph syntax
			loc cmd `cmd' `scat`i'' 

		} // End Loop over the number of palette color ids to use

		// Graph the color palette
		tw `cmd', ysca(r(2(1)`xscale') off) xsca(r(0(1)`xscale') off) 		 ///   
		xlab(none) ylab(none, nogrid) yti("") xti("") legend(nodraw)		 ///   
		graphr(margin(zero) fc(white) lc(white) ic(white)) plotr(lc(white) 	 ///   
		fc(white) ic(white)) name(`pal'`colors', replace)					 ///   
		ti("BrewScheme palette(s) `pal'" "with `colors' Colors", size(large) span)
		
	// Return original state of the data to the user
	restore
	
// End the program
end


	
