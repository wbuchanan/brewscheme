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
*     779                                                                      *
*                                                                              *
********************************************************************************
		
*! brewcolors
*! v 0.0.2
*! 01DEC2015

// Drop the program from memory if loaded
cap prog drop brewcolors

// Define new program
prog def brewcolors, rclass

	// Version number specification
	version 13.1
	
	// Syntax for program (make adds to color DB, install install's colors)
	syntax anything(name = source) [, MAke INSTall COLors(passthru) REFresh ]
	
	// Check for any optional arguments to add a comma to the command string
	if `"`make'`install'`colors'"' == "" loc optstring ","
	
	// Build local macro with the command string
	loc cmdstring brewcolors `source'`optstring' `make' `install' `colors' `refresh'
	
	// Preserve current state of the data
	preserve 
	
		// Clear any data from memory
		clear
	
		// Check for/build directory
		dirfile, p(`"`c(sysdir_personal)'style"')

		// Check for/build directory
		dirfile, p(`"`c(sysdir_personal)'brewcolors"')

		// Make sure source is valid
		if `"`source'"' == "xkcd" {

			// Load and parse the xkcd data
			xkcd, `make' `install' `colors' `refresh' cmd(`cmdstring')
			
			// Loop over each of the return name macros
			foreach nm in `r(colnms)' { 
			
				// Return the individual color name/RGB
				ret loc `nm' `r(`nm')'
			
			} // End Loop over returned values
			
		} // End else block for invalid source argument
		
		// If colorblind argument is passed
		else if `"`source'"' == "new" {
		
			// Call color blind routine
			colorinstaller, `make' `install' `colors' `refresh' cmd(`cmdstring')
			
			// Return the sub routine's return value
			ret loc colorpath `r(colorpath)'
			
		} // End ELSE IF Block for the argument new passed to the program
		
	// Restore data to original state
	restore
	
// End program
end

// Drop program if previously loaded in memory
cap prog drop colorinstaller

// Sub routine for user defined named colors
prog def colorinstaller, rclass

	// Syntax for sub routine
	syntax, colors(string asis) [ make install cmd(passthru) refresh ]
	
	// Set the number of observations
	qui: set obs `: word count `colors''

	// Create palette and RGB string variables
	qui: g palette = ""
	qui: g str11 rgb = ""

	// Loop over arguments passed in the color string
	forv i = 1/`: word count `colors'' {
	
		// Get the word string
		loc wrd `"`: word `i' of `colors''"'
		
		// If single word, assume it is RGB string
		if `: word count `wrd'' == 1 {
				
			// Get the palette name
			loc palname "uc`: subinstr loc wrd `" "' "", all'"
		
			// Get the color string
			loc colorstring "`wrd'"
			
			// Create a meta string
			loc metastring "User Defined Color - "
			
		} // End IF Block for single word color definition
		
		// If user specifies color name
		else {
		
			// Get the palette name
			loc palname "`: word 1 of `wrd'"
			
			// Get the color string
			loc colorstring "`: word 2 of `wrd''"
			
			// Create a meta string
			loc metastring "User Defined Color - "
			
		} // End ELSE Block for colors with user specified names
				
		// Generate the palette name
		qui: replace palette = "`palname'"'
		
		// Generate the rgb value
		qui: replace rgb = "`colorstring'"
		
		// Generate the rest of the variables
		brewcolorvars, meta(`"`metastring'"' + palette) colorb `cmd'
		
	} // End Loop over color arguments
	
	// Check install option
	if `"`install'"' != "" {
	
		// Loop over records
		forv i = 1/`: word count `colors'' {
	
			// Store filename in local macro
			loc fname `"`c(sysdir_personal)'style/color-`palname'.style"'
		
			// Create new file wit the color definition
			qui: file open newcolor using `"`fname'"', w replace
			
			// Write a version number
			qui: file write newcolor `"*! v 0.0.0 `c(current_date)' `c(current_time)'"' _n
			
			// Write color attribution
			qui: file write newcolor `"*! Color defined by the user: `c(username)'"' _n
			
			// Add a sequence ID to the file
			qui: file write newcolor `"sequence `: di seqid[`i']'"' _n
			
			// Write the color name
			qui: file write newcolor `"label "`: di meta[`i']'""' _n(2)
			
			// Write the color definition to the file
			qui: file write newcolor `"set rgb "`: di rgb[`i']'""' _n(2)
			
			// Close the file
			qui: file close newcolor
						
		} // End Loop over records
		
	} // End IF Block for color installation
	
	// Save the dataset with the colors
	qui: save `"`c(sysdir_personal)'brewcolors/colorsBy`c(username)'.dta"', replace

	// Check for make option
	qui: brewColorMaker `c(sysdir_personal)'brewcolors/colorsBy`c(username)'.dta, `refresh'
	
	// Return the file path for the colors created by the user
	ret loc colorpath `"`c(sysdir_personal)'brewcolors/colorsBy`c(username)'.dta"'
	
// End of subroutine definition	
end	
	
// Drop program if previously loaded in memory
cap prog drop colorblind	

// This subroutine will be deprecated prior to v 1.0 release
// Define sub-routine to get colorblind inversion data
prog def colorblind, rclass
	
	// Define syntax
	syntax , [ make cmd(`cmdstring')]

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

// Drop program if previously loaded in memory
cap prog drop xkcd

// Define sub-routine to get xkcd named color list
prog def xkcd, rclass
	
	// Define syntax
	syntax [, make install colors(string asis) refresh cmd(passthru) ]
	
	// For the xkcd colors
	import delimited using "http://xkcd.com/color/rgb.txt", delim("#") clear

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
	
	// Sort Colors alphabetically
	qui: sort v1
	
	// Add XKCD Ref to meta
	qui: replace v1 = "XKCD - " + proper(v1)
	
	// Replace spaces in color names with underscores
	qui: g palette = _n
	qui: tostring palette, replace
	qui: replace palette = "xkcd" + palette

	// Get length of palette name string
	qui: g x = length(v1)
	
	// Drop the random character at the end of the color name that won't disappear otherwise
	qui: replace v1 = substr(v1, 1, x - 1)
	
	// Convert colors from Hexadecimal to decimal RGB values
	hextorgb, hex(v2)
	
	// Compress data
	qui: compress
	
	// Drop variables that are no longer used
	qui: drop v2 x 
	
	// Null local macro to return all color names
	loc retnames 
	
	// Generate sequence ID number
	qui: g tmpid = 6999 + _n
	
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
				qui: file write newcolor `"sequence `: di tmpid[`i']'"' _n
				
				// Write the color name
				qui: file write newcolor `"label "`: di v1[`i']'""' _n(2)
				
				// Write the color definition to the file
				qui: file write newcolor `"set rgb "`: di rgb[`i']'""' _n(2)
				
				// Close the file
				qui: file close newcolor
					
			} // End IF Block for installable colors
			
			// If not installed skip to next iteration
			else continue
		
		} // End IF Block to install xkcd colors
		
	} // End Loop to return values
	
	// Return the local with the return names
	ret loc colnms `retnames'
	
	// Create required variables
	qui: brewcolorvars, meta(v1) colorb `cmd' seqid(palette + strofreal(tmpid))
	
	// Drop variables that are no longer needed
	qui: drop v1 tmpid
	
	// Save the dataset
	qui: save `"`c(sysdir_personal)'brewcolors/brewxkcd.dta"', replace
	
	// Check make option
	if `"`make'"' != "" brewColorMaker `c(sysdir_personal)'brewcolors/brewxkcd.dta, `refresh'

// End of program
end

// Drop program if previously loaded in memory
cap prog drop decompress

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

// Drop program if previously loaded in memory
cap prog drop brewcolorvars 

// Defines subroutine for adding standard variables for color definitions
prog def brewcolorvars

	// Define syntax structure
	syntax [, seqid(string asis) meta(string asis) COLORBlindvars cmd(string asis) ] 
	
	// Check for palette name and RGB string variables
	cap confirm v rgb palette
	
	// If these variables do not exist throw an error and exit
	if _rc != 0 {
	
		// Print error message for user
		di as err "The brewcolorvars subroutine called by `cmd' requires "	 ///   
		"the variables palette (color/palette name) and rgb (the Stata "	 ///   
		"formatted RGB string) to be present in the dataset currently in " 	 ///   
		"memory."
		
		// Error code
		err 198
		
	} // End IF Block for bad data
		
	// Check for colorblindvars parameter
	if `"`colorblindvars'"' != "" {
		
		// Set the macro with the names of the color blind variables for sorting
		loc colorblindvars achromatopsia protanopia deuteranopia tritanopia
		
		// Generate color blindness variables
		qui: brewtransform rgb
		
	} // End IF Block for color blindness variables
	
	// Add variables to existing file
	foreach v in colorblind lcd photocopy print {
	
		// Initialize variables w/extended missing values
		qui: g `v' = .n
		
	} // End Loop for meta variables
	
	// Add id variables
	foreach v in pcolor colorid maxcolors {
	
		// Add variables used for IDs
		qui: g `v' = 1
		
	} // End Loop over ID variables
	
	// Check for sequence ID argument
	if `"`seqid'"' != "" {

		// Create a sequence ID variable
		qui: g seqid = `seqid'
		
	} // End IF Block for user specified sequence id
	
	// If no argument passed
	else {
	
		// Generic sequence ID 
		qui: g seqid = palette + strofreal(pcolor) + strofreal(colorid)
		
	} // End ELSE Block for no sequence ID argument
	
	// Check if meta is a variable or string
	cap confirm v `meta'
	
	// If argument is a variable generate the meta variable from the variable passed
	qui: g meta = `meta'
	
	// Specify the display order of the variables
	order palette colorblind print photocopy lcd colorid pcolor rgb 		 ///   
	maxcolors seqid meta `colorblindvars'
	
	// Variable labels
	la var palette "Name of Color Palette" 									 
	la var colorblind "Colorblind Indicator" 
	la var print "Print Indicator"
	la var photocopy "Photocopy Indicator"
	la var lcd "LCD/Laptop Indicator"
	la var colorid "Within pcolor ID for individual color look ups"
	la var pcolor "Palette by Colors Selected ID"
	la var rgb "Red-Green-Blue Values to Build Scheme Files"
	la var maxcolors "Maximum number of colors allowed for the palette"
	la var seqid "Sequential ID for property lookups"
	la var meta "Meta-Data Palette Characteristics (see char _meta[*] for more info)"
	la var achromatopsia "Achromatopsic Vision RGB Transformed Equivalent"
	la var protanopia "Protanopic Vision RGB Transformed Equivalent"
	la var deuteranopia "Deuteranopic Vision RGB Transformed Equivalent"
	la var tritanopia "Tritanopic Vision RGB Transformed Equivalent"

// End of subroutine definition
end

// Drop program if previously loaded in memory
cap prog drop brewColorMaker

// Define program
prog def brewColorMaker

	// Syntax
	syntax anything(name = filename id = "Colors to install") [, refresh ]
	
	// Append to existing colordb if it exists
	cap confirm new file `"`c(sysdir_personal)'brewcolors/colordb.dta"'
	
	// If file exists
	if _rc == 0 | `"`refresh'"' != "" {
	
		// Call the color database program
		brewcolordb, `refresh'
		
		// Load colordb file
		qui: use `"`c(sysdir_personal)'brewcolors/colordb.dta"', clear
	
		// Append existing data
		qui: append using `"`filename'"'
		
		// Drop any duplicate color references
		qui: duplicates drop
		
		// Save data as first instance of colordb
		qui: save `"`c(sysdir_personal)'brewcolors/colordb.dta"', replace
		
	} // End ELSE Block for non-existent color database
	
	// If file does not exist
	else {
			
		// Append existing data
		qui: append using `"`c(sysdir_personal)'brewcolors/colordb.dta"'
		
		// Drop any duplicate color references
		qui: duplicates drop
		
		// Save over file
		qui: save `"`c(sysdir_personal)'brewcolors/colordb.dta"', replace
		
	} // End IF Block for existing color database
		
// End of program definition
end


