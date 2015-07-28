********************************************************************************
* Description of the Program -												   *
* This program is used to download/install additional color references.  The   *
* program either builds/installs additional colors into Stata, or will build   *
* lookup tables used to transform the RGB colorspace to colors that represent  *
* how the graph would be viewed by someone with one of the three types of 	   *
* colorblindness.  This can be helpful for proofing graphs prior to publishing *
* as a quality assurance/quality control method to ensure the graph can be 	   *
* viewed and interpretted correctly by the widest audience possible.		   *
*                                                                              *
* Data Requirements -														   *
*     none                                                                     *
*																			   *
* System Requirements -														   *
*     Gunzip                                                                   *
*                                                                              *
* Program Output -                                                             *
*                                                                              *
* Lines -                                                                      *
*     1556                                                                     *
*                                                                              *
********************************************************************************
		
*! brewcolors
*! v 0.0.1
*! 20JUL2015

// Drop the program from memory if loaded
cap prog drop brewcolors

// Define new program
prog def brewcolors

	// Version number specification
	version 13.1
	
	// Syntax for program
	syntax anything(name = source) [, SAve(passthru) INSTall(passthru)]

	// Make sure source is valid
	if !inlist("`source'", "xkcd", "cbinvert") {
		
		// Display error message
		di as err "Only two sources currently available: xkcd and cbinvert"
		
		// Return error code
		err 198
		
	} // End else block for invalid source argument
	
	// Call the appropriate subroutine
	`source', `save' `install'
	
// End program
end


// Define sub-routine to get colorblind inversion data
prog def cbinvert, rclass
	
	// Define syntax
	syntax , [ INSTall(string asis) ]
	
	// Store base URL 
	local urlbase "http://mkweb.bcgsc.ca/colorblind"
	
	// Download a copy of the file locally
	copy "`urlbase'/colorblind.rgb.table.deuteranopia.txt.gz"				 ///   
		`"`c(sysdir_plus)'/b/deuteranopia.txt.gz"'
	copy "`urlbase'/colorblind.rgb.table.protanopia.txt.gz"					 ///   
		`"`c(sysdir_plus)'/b/protanopia.txt.gz"'
	copy "`urlbase'/colorblind.rgb.table.tritanopia.txt.gz"					 ///   
		`"`c(sysdir_plus)'/b/tritanopia.txt.gz"'
	copy "`urlbase'/colorblind.rgb.table.txt.gz"							 ///   
		 `"`c(sysdir_plus)'/b/cboverall.txt.gz"'

	loc dltime `"Downloaded on : `c(current_date)' and `c(current_time)'"'

	// Make sure using compatible OS
	if regexm(`"`c(os)'"', "[xX]") != 1 {
	
		// Turn Pause on
		pause on
		
		// Print pause message to screen
		pause "If gunzip is not available from your system path, you need "	 ///   
		"to decompress the files deuteranopia, protanopia, tritanopia, "	 ///   
		"and overall.txt.gz manually.  Enter the letter q into the console " ///   
		"and hit enter after doing this in order to continue."
		
		// Turn pause off
		pause off
		
	} // End IF Block for windoze
	
	// For *nix based systems
	else {

		// Decompress the Green-Blind Table	 
		! gunzip `"`c(sysdir_plus)'/b/deuteranopia.txt.gz"'

		// Decompress the Red-Blind Table
		! gunzip `"`c(sysdir_plus)'/b/protanopia.txt.gz"'
		
		// Decompress the Blue-Blind Table
		! gunzip `"`c(sysdir_plus)'/b/tritanopia.txt.gz"'
		
		// Decompress an overall table
		! gunzip `"`c(sysdir_plus)'/b/cboverall.txt.gz"'
		
	} // End ELSE Block for *nix based systems
	
	// Loop over the files
	foreach v in deuteranopia protanopia tritanopia cboverall {
	
		// Read the data into Stata
		qui: infix str lne 1-2045 using `"`c(sysdir_plus)'/b/`v'.txt"', clear

		// Add notes to dataset
		note "Data from : `urlbase'/colorblind.rgb.table.`v'.txt.gz"
		note "Data Author: Martin Krzywinski"
		note `"`dltime'"'
		note "Implemented in Stata using brewscheme"
		note "William.Buchanan@mpls.k12.mn.us - brewsceme maintainer"

		// Drop leading comment lines
		drop if regexm(lne, "^(#)") == 1

		// Make storage more efficient
		qui: compress

		// Parse the string
		qui: split lne, p(" ") gen(x)

		// Rename the variables
		rename (x1 x2 x3 x4 x5 x6 x7)(cbtype r1 g1 b1 r2 g2 b2)

		// Create the RGB string
		qui: egen color = concat(r1 g1 b1), p(" ")

		// Create the transposed color based on color blindness type
		qui: egen cbcolor = concat(r2 g2 b2), p(" ")
		
		// Count number of records
		qui: count
		
		// Loop over records to return results
		forv i = 1/`= r(N)' {
		
			// Store values temporarily
			loc cbt `: di cbtype[`i']'
			loc col `: di color[`i']'
			loc tcol `: di cbcolor[`i']'
			
			// Remove spaces from the RGB value
			loc ncol `: subinstr local col " " "", all'

			// Return local with regular color that returns the transpose
			ret loc `cbt'`ncol' "`cbcolor[`i']'"
			
			// Check to see if this color should be installed
			if inlist("`install'", "`cbt'", "`cbt'`ncol'", "`col'", "all") {
				
				// Store filename in local macro
				loc fname `c(sysdir_personal)'c/color-`cbt'`ncol'.style
			
				// Make sure directory exists
				cap confirm file `"`c(sysdir_personal)'c"'
				
				// If subdirectory doesn't exist create it
				if _rc != 0 mkdir `"`c(sysdir_personal)'c"'
				
				// Open file
				file open brewcolor using `fname', w replace
				
				// Write the color definition
				file write brewcolor `"set rgb `tcol'"' _n(2)
				
				// Close the file
				file close brewcolor
				
			} // End IF Block to install transpose colors
			
		} // End Loop over colors

		// Save the dataset
		qui: save `"`c(sysdir_personal)'b/brew_`v'.dta"', replace
		
	} // End Loop over files

// End of colorblind
end

// Define sub-routine to get xkcd named color list
prog def xkcd, rclass
	
	// Define syntax
	syntax , save(string asis) [ INSTall(string asis) ]
	
	// For the xkcd colors
	import delimited using "http://xkcd.com/color/rgb.txt", delim("#")

	// Get the licensing attribution
	loc license "`: di v2[1]'" 

	// Drop first record with licensing data
	qui: drop in 1

	// Make sure all letters are lowercased
	qui: replace v2 = lower(v2)

	// Split the string into component parts
	forv i = 1/6 {
		
		// Move each character into a new variable
		qui: g pos`i' = substr(v2, `i', 1)
		
		// Convert the individual hex value to decimal form
		qui: replace pos`i' = 
			 cond(pos`i' == "f", "15", cond(pos`i' == "e", "14",			 ///   
			 cond(pos`i' == "d", "13", cond(pos`i' == "c", "12",			 ///   
			 cond(pos`i' == "b", "11", cond(pos`i' == "a", "10",  pos`i'))))))
			 
		// Recast the value to numeric	 
		qui: destring pos`i', replace
		
	} // End Loop over the hexadecimal characters

	// Change the end of line delimiter
	#d ;
	
	// Convert the two character hexadecmial values to decimal values
	qui: g r = pos1 + pos2^2; qui: g g = pos3 + pos4^2; qui: g b = pos5 + pos6^2; 	
	
	// Concatenate the three values together and then clean up the other data
	qui: egen rgb = concat(r g b), p(" "); qui: drop pos* r g b; qui: compress;

	// Remove any/all spaces from the color names and prepend with xkcd
	qui: replace v1 = "xkcd_" + subinstr(v1, " ", "_", .);

	// Change EOL delimiter to original
	#d cr
	
	// Loop over observations
	forv i = 1/949 {
	
		// Build local macros to return to the user
		ret loc `: di v1[`i']' "`: di rgb[`i']'"
		
		// Check installation option
		if "`install'" != "" {
		
			// Check to see if it is a color the user wants to install or all
			if ("`: di v1[`i']'" == "`install'") | "`install'" == "all" {
			
				// Store filename in local macro
				loc fname `c(sysdir_personal)'c/color-`: di v1[`i']'.style
			
				// Make sure directory exists
				cap confirm file `"`c(sysdir_personal)'c"'
				
				// If subdirectory doesn't exist create it
				if _rc != 0 mkdir `"`c(sysdir_personal)'c"'
			
				// Create new file wit the color definition
				file open newcolor using `"`fname'"', w replace
				
				// Write the color definition to the file
				file write newcolor `"set rgb "`: di rgb[`i']'"' _n(2)
				
				// Close the file
				file close newcolor
				
			} // End IF Block for installable colors
			
			// If not installed skip to next iteration
			else continue
		
		} // End IF Block to install xkcd colors
		
	} // End Loop to return values
	
	// Save the dataset
	qui: save `"`c(sysdir_personal)'b/brewxkcd.dta"', replace

// End of program
end

