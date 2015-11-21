********************************************************************************
* Description of the Program -												   *
* This program is used to build a dataset with the names and RGB values of all * 
* color styles defined by Stata that are part of the base installation of the  *
* program.  It will be used when proofing graphs from the perspective of 	   *
* different forms of color blindness.										   *
*                                                                              *
* Program Output -                                                             *
*                                                                              *
* Lines -                                                                      *
*     432                                                                      *
*                                                                              *
********************************************************************************
		
*! brewcolordb
*! v 0.0.1
*! 21NOV2015

// Drop the program from memory if loaded
cap prog drop brewcolordb

// Define a program
prog def brewcolordb, rclass

	// Version of Stata that should be used to interpret the code
	version 13.1

	// Defines syntax structure of program
	syntax [, DISplay]

		// Get list of color style file names
		loc colors `: dir `"`c(sysdir_base)'/style/"' files "color*.style", respect'

		// Clean up the file names
		loc colors : list clean colors
		
		// Remove quotation marks from color file names
		loc colors `: subinstr loc colors `"""' "", all'

		// Create a name reference to use 
		loc name `: word 1 of `colors''

		// Load the first color style file in memory
		qui: insheet using `"`c(sysdir_base)'style/`name'"', clear

		// Get the color name
		getColorName `name'

		// // Create an id using the name of the color style
		qui: g id = "`r(colorname)'"

		// Loop over the list of files
		forv i = 2/`: word count `colors'' {
			
			// Keep the current data preserved in memory
			preserve
				
				// Get the color style file name
				loc name `: word `i' of `colors''
				
				// Load the color style file into memory
				qui: insheet using `"`c(sysdir_base)'style/`name'"', clear
				
				// Get the color name
				getColorName `name'
				
				// Use the color name for the ID field
				qui: g id = "`r(colorname)'"
				
				// Reserve space for a temp file in memory
				tempfile `i'
				
				// Save the current data set in the tempfile reserved above
				qui: save ``i''.dta, replace

			// Restore memory to previous state (e.g., first color style file)
			restore

			// Append this color style to the existing data set
			qui: append using ``i''.dta

		} // End Loop over the color style files

		// Generate a file id (row number)
		qui: g fileid = _n

		// Count the number of lines per file
		qui: bys id (fileid): g lines = _N

		// Create a row id for the lines from each color style file
		qui: bys id (fileid): g linenum = _n

		// Keep only the records that contain the RGB values
		qui: keep if lines == linenum

		// Replace the value for the color style none
		qui: replace v1 = "" if id == "none"

		// Rename v1 to something more informative
		rename v1 rgb

		// Check display option
		if `"`display'"' != "" {

			// Write the table header
			di as text _dup(80) `"_"' _n _skip(10) "Color Name" _skip(10) 	 ///   
			"RGB" _n _dup(80) "_" _n 

		} // End If Block for Display Header
		
		// Loop over the observations
		forv v = 1/`: word count `colors'' {
		
			// Check display option
			if `"`display'"' != "" {

				// Print the data to the screen
				di as res _skip(10) id[`v'] _col(30) rgb[`v']

			} // End IF Block for display option
			
			// Return the color value in the name of the color
			ret loc `: di id[`v']' `"`: di rgb[`v']'"'
				
		} // End Loop
			
		// Check display option
		if `"`display'"' != "" {

			// Add footer
			di as text _dup(80) "_"
			
		} // End IF Block for display option
		
		// Set the display order of the variables
		order id rgb
		
		// Keep only the needed variables
		qui: keep id rgb
		
		// Add metadata 
		la var id "Name of Stata Colorstyle"
		la var rgb "RGB Value of Stata Colorstyle"

		// Save to the brewscheme created directories
		qui: save `"`c(sysdir_personal)'brewuser/colordb.dta"', replace
		
// end of program
end

// Utility subroutine to parse the color name from a color style file name
prog def getColorName, rclass

	// Accepts only single mandatory argument of the color style file name
	syntax anything(name = cfname id = "Color style file name")
	
	// Remove the opening of the color style file name
	loc cname `: subinstr loc cfname `"color-"' "", all'
	
	// Remove the file extension
	loc cname `: subinstr loc cname `".style"' "", all'

	// Return the value
	ret loc colorname `cname'
	
// End of subroutine
end

