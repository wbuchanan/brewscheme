********************************************************************************
* Description of the Program -												   *
* This program is used to preview how a color may be perceived by individuals  * 
* with varying forms of colorblindness.  									   *
*                                                                              *
* Dependencies -															   *
*     libbrewscheme - colorblind, cbtype, Protanopia, Deuteranopia, and 	   *
*					  Tritanopia classes and associated methods.			   *
*																			   *
* Program Output -                                                             *
*                                                                              *
* Lines -                                                                      *
*     129                                                                      *
*                                                                              *
********************************************************************************
		
*! brewcbsim
*! v 0.0.1
*! 25NOV2015

// Drops program if loaded in memory
cap prog drop brewcbsim

// Defines program with R-class property
prog def brewcbsim, rclass

	// Version of Stata to use for interpretation of code
	version 13.1
	
	// Syntax structure of program
	syntax anything(name = rgb id = "Red, Green, Blue Color")
	
	// If not all values present
	if `: word count `rgb'' != 3 {
	
		// Print error message to console
		di as err "Insufficient arguments.  Must provide red, green, and blue channels"
		
		// Error out of the program
		err 198
		
	} // End IF block 
	
	// Concatenate the RGB string
	else {
	
		// Store the Stata formatted RGB string in the local color
		loc color "`: word 1 of `rgb'' `: word 2 of `rgb'' `: word 3 of `rgb''"
	
	} // End ELSE Block for sufficient arguments
	
	// Pass the color string to the Mata wrapper used to perform the transform
	mata translateColor(`: subinstr loc color `" "' `", "', all')
	
	// Preserve current state of the data
	preserve
	
		// Clear existing data from memory
		clear
		
		// Set the number of observations
		qui: set obs 5
		
		// Set the val variable to 5
		qui: g val = 5
		
		// Create an id variable with values that will be used to identify 
		// vision types and returned colors
		qui: g id = _n
		
		// Define value labels based on the passed color string and the 
		// returned local macros from the Mata function
		la def colors 	1 `"`baselinelab' `baseline'"'						 ///   
						2 `"`achromatopsialab' `achromatopsia'"'			 ///   
						3 `"`protanopialab' `protanopia'"'					 ///   
						4 `"`deuteranopialab' `deuteranopia'"'				 ///   
						5 `"`tritanopialab' `tritanopia'"', modify
		
		// Apply the value labels
		la val id colors
	
		// Create the graph to show how the color would appear under varying 
		// types of color blindness
		gr hbar (asis) val, over(id, gap(*5) axis(off)) asyvars				 ///   
		bar(1, c("`baseline'")) bar(2, c("`achromatopsia'"))				 ///   
		bar(3, c("`protanopia'")) bar(4, c("`deuteranopia'"))				 ///   
		bar(5, c("`tritanopia'")) bargap(10)								 ///   
		graphr(ic(white) fc(white) lc(white))								 ///   
		plotr(ic(white) fc(white) lc(white))								 ///   
		legend(off) ysc(off) ylab(, nogrid) 								 ///   
		blabel(name, pos(center) size(vsmall)) 								 ///   
		ti("brewscheme: ", size(large) c(black))							 ///   
		subti("Color Sightedness Impairment Simulation", size(medium) c(black))
	
		// Return the color value passed to the program
		ret loc original `baseline'
		
		// Return the color value with label
		ret loc originallab `baselinelab'
		
		// Return the RGB transform for complete color blindness
		ret loc achromatopsic `achromatopsia'
		
		// Return the RGB transform for complete color blindness with label
		ret loc achromatopsiclab `achromatopsialab'
		
		// Return the RGB value for Red color blindness
		ret loc protanope `protanopia'
		
		// Return the RGB value for Red color blindness with label
		ret loc protanopelab `protanopialab'
		
		// Return the RGB value for Green color blindness
		ret loc deuteranope `deuteranopia'
		
		// Return the RGB value for Green color blindness with label
		ret loc deuteranopelab `deuteranopialab'
		
		// Return the RGB value for Blue color blindness
		ret loc tritanope `tritanopia'

		// Return the RGB value for Blue color blindness with label
		ret loc tritanopelab `tritanopialab'
		
	// Restore the data back to original state
	restore	

// End of program definition
end

