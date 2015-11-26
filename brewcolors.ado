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
*     581                                                                      *
*                                                                              *
********************************************************************************
		
*! brewcolors
*! v 0.0.1
*! 26NOV2015

// Drop the program from memory if loaded
cap prog drop brewcolors

// Define new program
prog def brewcolors, rclass

	// Version number specification
	version 13.1
	
	// Syntax for program
	syntax anything(name = source) [, MAke INSTall COLors(passthru) ]
	
	// Check for/build directory
	dirfile, p(`"`c(sysdir_personal)'style"')

	// Check for/build directory
	dirfile, p(`"`c(sysdir_personal)'brewcolors"')

	// Make sure source is valid
	if `"`source'"' == "xkcd" {

		// Load and parse the xkcd data
		xkcd, `make' `install' `colors'
		
		// Loop over each of the return name macros
		foreach nm in `r(colnms)' { 
		
			// Return the individual color name/RGB
			ret loc `nm' `r(`nm')'
		
		} // End Loop over returned values
		
	} // End else block for invalid source argument
	
	// If colorblind argument is passed
	//else if `"`source'"' == "colorblind" {
	
		// Call color blind routine
		// colorblind, `make' `install' `colors'
		
	//} //
	
	// Check for new
	
// End program
end

// This subroutine will be deprecated prior to v 1.0 release
// Define sub-routine to get colorblind inversion data
prog def colorblind, rclass
	
	// Define syntax
	syntax , [ make install colors(string asis) ]

	// Store base URL 
	local urlbase "http://mkweb.bcgsc.ca/colorblind"

	// If no colors argument is passed use all as the default
	if `"`colors'"' == "" { 
		
		// Set all types of colorblindness if no argument specified
		loc colors deuteranopia protanopia tritanopia
		
		// Set colordb option
		loc colordb colordb
		
	} // End IF Block for null colors argument
	
	// Check for all keyword in the argument
	else if inlist("all", `"`: subinstr loc colors `" "' `", "', all'"') {
	
		// Set all types of colorblindness if all keyword is specified
		loc colors deuteranopia protanopia tritanopia
		
		// Set colordb option
		loc colordb colordb
		
	} // End IF Block for null colors argument
	
	// Loop over the words passed to the colors parameter
	forv i = 1/`: word count `colors'' {
	
		// Clear any data out of memory
		clear
		
		// Store individual color argument
		loc color `: word `i' of `colors''
			
		// Check for valid color argument	
		if !inlist(`"`color'"', "deuteranopia", "protanopia", "tritanopia", "all") {
											
			// Error out
			di as err "Invalid argument passed to colors parameter." _n	 ///   
			"Must be one of deuteranopia, protanopia, tritanopia, or all"
			
			// Exit from the program
			err 198
			
		} // End if Block for invalid argument
		
		// If valid
		else if inlist(`"`color'"', "deuteranopia", "green") {

			// Mark time when download started
			loc dltime `"Downloaded on : `c(current_date)' and `c(current_time)'"'
			
			// Download a copy of the table
			copy "`urlbase'/colorblind.rgb.table.deuteranopia.txt.gz"	 ///   
			`"`c(sysdir_personal)'brewcolors/deuteranopia.txt.gz"'

			// Decompress the file
			decompress `"`c(sysdir_personal)'brewcolors/deuteranopia.txt.gz"'
			
			// Load the data set
			qui: insheet using `"`c(sysdir_personal)'brewcolors/deuteranopia.txt"'
			
			// Drop the header
			qui: drop in 1
			
			// Compress to reduce memory footprint
			qui: compress
			
			// Split into individual RGB values 
			qui: split v1, p(" ") gen(c)
			
			// Create initial RGB value used for lookups.
			qui: g str11 from = c1 + " " + c2 + " " + c3
			
			// Create transformed values of the RGB 
			qui: g str11 deuteranopia = c4 + " " + c5 + " " + c6
			
			// Keep only the required fields
			qui: keep from deuteranopia
			
			// Compress the file
			qui: compress
			
			// Add labels
			la var from "Original RGB value to be transformed"
			la var deuteranopia "RGB value transformed for Deuteranopia Green-Blind"
			
			// Add notes to dataset
			note : "Data from : `urlbase'/deuteranopia.txt.gz"
			note : "Data Author: Martin Krzywinski"
			note : `"`dltime'"'

			// Save the file
			qui: save `"`c(sysdir_personal)'brewcolors/deuteranopia.dta"', replace
			
			// Remove the original file
			qui: rm `"`c(sysdir_personal)'brewcolors/deuteranopia.txt"'
			
			// Check for all options
			if `"`colordb'"' != "" {
			
				qui: copy `"`c(sysdir_personal)'brewcolors/deuteranopia.dta"' ///   
				`"`c(sysdir_personal)'brewcolors/colorblinddb.dta"'
		
			} // End IF Block for all
		
		} // End ELSEIF Block for Green color blindness
			
		// If red color blind
		else if inlist(`"`color'"', "protanopia", "red") {
		
			// Mark time when download started
			loc dltime `"Downloaded on : `c(current_date)' and `c(current_time)'"'
			
			// Download a copy of the table
			copy "`urlbase'/colorblind.rgb.table.protanopia.txt.gz"	 ///   
			`"`c(sysdir_personal)'brewcolors/protanopia.txt.gz"'

			// Decompress the file
			decompress `"`c(sysdir_personal)'brewcolors/protanopia.txt.gz"'
			
			// Load the data set
			qui: insheet using `"`c(sysdir_personal)'brewcolors/protanopia.txt"'
			
			// Drop the header
			qui: drop in 1
			
			// Compress to reduce memory footprint
			qui: compress
			
			// Split into individual RGB values 
			qui: split v1, p(" ") gen(c)
			
			// Create initial RGB value used for lookups.
			qui: g str11 from = c1 + " " + c2 + " " + c3
			
			// Create transformed values of the RGB 
			qui: g str11 protanopia = c4 + " " + c5 + " " + c6
			
			// Keep only the required fields
			qui: keep from protanopia
			
			// Compress the file
			qui: compress
			
			// Add labels
			la var from "Original RGB value to be transformed"
			la var protanopia "RGB value transformed for Protanopia Red-Blind"
			
			// Add notes to dataset
			note : "Data from : `urlbase'/protanopia.txt.gz"
			note : "Data Author: Martin Krzywinski"
			note : `"`dltime'"'

			// Save the file
			qui: save `"`c(sysdir_personal)'brewcolors/protanopia.dta"', replace

			// Remove the original file
			qui: rm `"`c(sysdir_personal)'brewcolors/protanopia.txt"'
			
			// Check for all options
			if `"`colordb'"' != "" {
			
				// Join with other files
				qui: merge 1:1 from using 								 ///   
				`"`c(sysdir_personal)'brewcolors/colorblinddb.dta"', nogen
		
				// Save the colorblind database
				qui: save `"`c(sysdir_personal)'brewcolors/colorblinddb.dta"', replace
		
			} // End IF Block for all option
		
		} // End ELSEIF Block for Red color blindness
			
		// Else if blue color blind
		else if inlist(`"`color'"', "tritanopia", "blue") {
		
			// Mark time when download started
			loc dltime `"Downloaded on : `c(current_date)' and `c(current_time)'"'
			
			// Download a copy of the table
			copy "`urlbase'/colorblind.rgb.table.tritanopia.txt.gz"	 ///   
			`"`c(sysdir_personal)'brewcolors/tritanopia.txt.gz"'

			// Decompress the file
			decompress `"`c(sysdir_personal)'brewcolors/tritanopia.txt.gz"'
			
			// Load the data set
			qui: insheet using `"`c(sysdir_personal)'brewcolors/tritanopia.txt"'
			
			// Drop the header
			qui: drop in 1
			
			// Compress to reduce memory footprint
			qui: compress
			
			// Split into individual RGB values 
			qui: split v1, p(" ") gen(c)
			
			// Create initial RGB value used for lookups.
			qui: g str11 from = c1 + " " + c2 + " " + c3
			
			// Create transformed values of the RGB 
			qui: g str11 tritanopia = c4 + " " + c5 + " " + c6
			
			// Keep only the required fields
			qui: keep from tritanopia
			
			// Compress the file
			qui: compress
			
			// Add labels
			la var from "Original RGB value to be transformed"
			la var tritanopia "RGB value transformed for Tritanopia Blue-Blind"
			
			// Add notes to dataset
			note : "Data from : `urlbase'/tritanopia.txt.gz"
			note : "Data Author: Martin Krzywinski"
			note : `"`dltime'"'

			// Save the file
			qui: save `"`c(sysdir_personal)'brewcolors/tritanopia.dta"', replace

			// Remove the original file
			qui: rm `"`c(sysdir_personal)'brewcolors/tritanopia.txt"'
			
			// Check for all options
			if `"`colordb'"' != "" {
			
				// Join with other files
				qui: merge 1:1 from using 								 ///   
				`"`c(sysdir_personal)'brewcolors/colorblinddb.dta"', nogen
				
				// Add additional note for completion of database
				note : `"File completed at `c(current_time)' on `c(current_date)'"'
		
				// Save the colorblind database
				qui: save `"`c(sysdir_personal)'brewcolors/colorblinddb.dta"', replace
		
			} // End IF Block for all option
		
		} // End ELSEIF Block for Blue color blindness
			
	} // End Loop over color arguments
		
// End of colorblind
end

// Define sub-routine to get xkcd named color list
prog def xkcd, rclass
	
	// Define syntax
	syntax [, make install colors(string asis) ]
	
	// For the xkcd colors
	import delimited using "http://xkcd.com/color/rgb.txt", delim("#")

	// Get the licensing attribution
	loc license "`: di v2[1]'" 

	// Drop first record with licensing data
	qui: drop in 1

	// Make sure all letters are lowercased
	qui: replace v2 = lower(v2)
	
	// Remove unnecessary words from color/palette names
	qui: replace v1 = subinstr(v1, `"'"', "", .)
	qui: replace v1 = subinstr(v1, "and ", "", .)
	qui: replace v1 = subinstr(v1, "/", "", .)
	qui: rename v1 meta
	
	qui: sort meta
	
	// Replace spaces in color names with underscores
	qui: g palette = _n
	qui: tostring palette, replace
	qui: replace palette = "xkcd" + palette

	// Get length of palette name string
	qui: g x = length(meta)
	
	// Drop the random character at the end of the color name that won't disappear otherwise
	qui: replace meta = substr(meta, 1, x - 1)
	
	// Convert colors from Hexadecimal to decimal RGB values
	hextorgb, hex(v2)
	
	// Compress data
	qui: compress
	
	// Drop variables that are no longer used
	qui: drop v2 x 
	
	// Null local macro to return all color names
	loc retnames 
	
	// Generate sequence ID number
	qui: g seqid = 6999 + _n
	
	// Loop over observations
	forv i = 1/949 {
	
		// Check installation option
		if "`install'" != "" {
		
			// Store color name
			loc thecolorname `: di palette[`i']'
		
			// Check to see if it is a color the user wants to install or all
			if (`: list thecolorname in colors' == 1 | "`install'" != "" |	  ///   
			`"`colors'"' == "all") {
			
				// Build local macros to return to the user
				ret loc `thecolorname' `"`: di rgb[`i']'"'
				
				// Update return names
				loc retnames `retnames' `thecolorname'
	
				// Store filename in local macro
				loc fname `"`c(sysdir_personal)'style/color-`thecolorname'.style"'
			
				// Create new file wit the color definition
				qui: file open newcolor using `"`fname'"', w replace
				
				// Write the license info into the first line
				qui: file write newcolor `"*! `: subinstr loc license `"#"' "", all'"' _n
				
				// Write a version number
				qui: file write newcolor `"*! v 0.0.0 `c(current_date)' `c(current_time)'"' _n
				
				// Write color attribution
				qui: file write newcolor `"*! Color names from XKCD.com survey (http://blog.xkcd.com/2010/05/03/color-survey-results/)"' _n
				
				// Add a sequence ID to the file
				qui: file write newcolor `"sequence `: di seqid[`i']'"' _n
				
				// Write the color name
				qui: file write newcolor `"`: di meta[`i']'"' _n
				
				// Write the color definition to the file
				qui: file write newcolor "set rgb `: di rgb[`i']'" _n(2)
				
				// Close the file
				qui: file close newcolor
					
			} // End IF Block for installable colors
			
			// If not installed skip to next iteration
			else continue
		
		} // End IF Block to install xkcd colors
		
	} // End Loop to return values
	
	// Return the local with the return names
	ret loc colnms `retnames'
	
	// Generate the color blind colors
	qui: brewtransform rgb
	
	// Generate variables needed
	foreach v in colorblind print lcd photocopy {
	
		// Populate meta data indicators with null values
		qui: g `v' = .n
		
	} // End Loop over meta data variables
	
	// Generate max colors, pcolor, colorid and seqid
	qui: g maxcolors = 1
	qui: g pcolor = 1
	qui: g colorid = 1
	
	// Set the display order of the variables
	order palette colorblind print photocopy lcd colorid pcolor rgb 		 ///   
	maxcolors seqid meta achromatopsia protanopia deuteranopia tritanopia
	
	// Variable labels
	loc varlabs "Name of Color Palette" 									 ///   
		"Colorblind Indicator" 												 ///   
		"Print Indicator"													 ///   
		"Photocopy Indicator" 												 ///   
		"LCD/Laptop Indicator"												 ///   
		"Within pcolor ID for individual color look ups" 					 ///   
		"Palette by Colors Selected ID"										 ///   
		"Red-Green-Blue Values to Build Scheme Files"						 ///   
		"Maximum number of colors allowed for the palette"					 ///   
		"Sequential ID for property lookups"								 ///   
		"Meta-Data Palette Characteristics (see char _meta[*] for more info)" ///   
		"Achromatopsic Vision RGB Transformed Equivalent"					 ///   
		"Protanopic Vision RGB Transformed Equivalent"						 ///   
		"Deuteranopic Vision RGB Transformed Equivalent"					 ///   
		"Tritanopic Vision RGB Transformed Equivalent"

	// Get variable names
	qui: ds
		
	// Loop over variable labels
	forv v = 1/15 {
	
		// Apply variable labels
		la var `: word `v' of `r(varlist)'' `"`: word `v' of `varlabs''"'
		
	} // End Loop over variables/labels
		
	// Make sequence ID a string	
	qui: tostring seqid, replace
	
	// And make it conform to the same format as the other files
	qui: replace seqid = palette + seqid

	// Save the dataset
	qui: save `"`c(sysdir_personal)'brewcolors/brewxkcd.dta"', replace
	
	// Check make option
	if `"`make'"' != "" {
	
		// Append to existing colordb if it exists
		cap confirm file `"`c(sysdir_personal)'brewcolors/colordb.dta"'
		
		// If file exists
		if _rc == 0 {
		
			// Append existing data
			qui: append using `"`c(sysdir_personal)'brewcolors/colordb.dta"'
			
			// Save over file
			qui: save `"`c(sysdir_personal)'brewcolors/colordb.dta"', replace
			
		} // End IF Block for existing color database
		
		// If file does not exist
		else {
		
			// Call the color database program
			qui: brewcolordb
		
			// Append existing data
			qui: append using `"`c(sysdir_personal)'brewcolors/colordb.dta"'
			
			// Save data as first instance of colordb
			qui: save `"`c(sysdir_personal)'brewcolors/colordb.dta"', replace
			
		} // End ELSE Block for non-existent color database
		
	} // End IF Block to make color database/update color database

// End of program
end


// Decompression sub routine for gzip files
prog def decompress

	// Version of Stata to use when interpretting the code
	version 13.1
	
	// Syntax used to call program
	syntax anything(name = thefile id = "File name to be gunzipped")
	
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
	
		if `"`c(os)'"' == "MacOSX" {
		
			loc thefile `: subinstr loc thefile `"~"' `"/Users/`c(username)'"', all'
			
		}
		
		// Decompress the Green-Blind Table	 
		! gunzip "`thefile'"

	} // End ELSE Block for *nix based systems

// End of decompression subroutine
end

