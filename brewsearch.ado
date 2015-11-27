


// Define mata functions for searches	
mata: 

// Method used to search for RGB values based on named style definitions
void brewNameSearch(string scalar name) {

	// Declares variables used in the function
	string matrix rgbdata, results
	
	// String scalar to store file path
	string scalar colordb
	
	// Stores the file path to the color data base
	colordb = st_macroexpand("`" + "c(sysdir_personal)" + "'") + "brewcolors/colordb.dta"
	
	// Load the color palette data base
	stata(`"use ""' + colordb + `"", clear"')

	// Create a view onto the color data base
	st_sview(rgbdata, ., ("palette", "meta", "rgb", "achromatopsia", 
						  "protanopia", "deuteranopia", "tritanopia"))

	// First pass search on the palette name
	results = select(rgbdata, rgbdata[., 1] :== name)
	
	// If there are results
	if (rows(results) != 0) {
	
		// Return the results in Stata macros
		st_local("rgb", results[1, 3])
		st_local("achromatopsia", results[1, 4])
		st_local("protanopia", results[1, 5])
		st_local("deuteranopia", results[1, 6])
		st_local("tritanopia", results[1, 7])
		
	} // End IF Block for success on palette names
	
	// If palette name search not successful
	else {
	
		// Search the meta data variable (helpful for XKCD variables)
		results = select(rgbdata, rgbdata[., 2] :== name)
		
		// If results are found
		if (rows(results) != 0) {
	
			// Return the results in Stata macros
			st_local("rgb", results[1, 3])
			st_local("achromatopsia", results[1, 4])
			st_local("protanopia", results[1, 5])
			st_local("deuteranopia", results[1, 6])
			st_local("tritanopia", results[1, 7])
		
		} // End IF Block for success on meta variable search
		
		// If no success
		else {
		
			// Print error message to console for end user
			_error(3498, "The named color style could not be found in the color database.")
		
		} // End ELSE Block for no success
		
	} // End ELSE Block for search on meta variable 

} // End function definition

// Search for colorblind values given an RGB string
void brewColorSearch(string scalar rgbstring) {

	// Declares variables used in the function
	string matrix rgbdata, results
	
	// String scalar to store root file path
	string scalar meta, colordb
	
	// Get the personal subdirectory
	meta = st_macroexpand("`" + "c(sysdir_personal)" + "'") + "b/brewmeta.dta"
	colordb = st_macroexpand("`" + "c(sysdir_personal)" + "'") + "brewcolors/colordb.dta"
	
	// Load the color palette data base
	stata(`"use ""' + colordb + `"", clear"')
	
	// Create a view onto the color data base
	st_sview(rgbdata, ., ("palette", "meta", "rgb", "achromatopsia", 
						  "protanopia", "deuteranopia", "tritanopia"))

	// First pass search on the palette name
	results = select(rgbdata, rgbdata[., 3] :== rgbstring)
	
	// If there are results
	if (rows(results) != 0) {
	
		// Return the results in Stata macros
		st_local("rgb", results[1, 3])
		st_local("achromatopsia", results[1, 4])
		st_local("protanopia", results[1, 5])
		st_local("deuteranopia", results[1, 6])
		st_local("tritanopia", results[1, 7])
		
	} // End IF Block for success on palette names

	// Load the user specified colors data base
	stata(`"use ""' + meta + `"", clear"')
	
		// Create a view onto the color data base
	st_sview(rgbdata, ., ("palette", "meta", "rgb", "achromatopsia", 
						  "protanopia", "deuteranopia", "tritanopia"))

	// First pass search on the palette name
	results = select(rgbdata, rgbdata[., 3] :== rgbstring)
	
	// If there are results
	if (rows(results) != 0) {
	
		// Return the results in Stata macros
		st_local("rgb", results[1, 3])
		st_local("achromatopsia", results[1, 4])
		st_local("protanopia", results[1, 5])
		st_local("deuteranopia", results[1, 6])
		st_local("tritanopia", results[1, 7])
		
	} // End IF Block for success on palette names

	// If no success
	else {

		// Print error message to console for end user
		_error(3498, "The named color style could not be found in the color database.")
	
	} // End ELSE Block for no success

} // End Function definition for RGB color search
	
// End of Mata function definitions	
end	

// Drop program from memory if previously loaded
cap prog drop brewsearch

// Define program with rclass property
prog def brewsearch, rclass

	// Set version to interpet Stata syntax
	version 13.1
	
	// Define syntax structure
	syntax anything(name = color id = "Named Color or RGB triplet") 
	
	// Allowable arguments for return parameter
	loc validreturns rgb achromatopsia protanopia deuteranopia tritanopia 
	
	// For single word
	if `: word count `color'' == 1 & regexm(`"`: word 1 of `color''"', 		 ///   
	"[a-zA-Z]") == 0 {
	
		// Search for the RGB values
		mata: brewColorSearch("`: word 1 of `color''")

	} // End IF Block for single RGB string 
	
	// For single word
	else if `: word count `color'' == 1 & regexm(`"`: word 1 of `color''"',  ///   
	"[a-zA-Z]") == 1 {
	
		// Search for the RGB values
		mata: brewNameSearch("`: word 1 of `color''")

	} // End IF Block for single RGB string 
		
	// For all other cases 
	else {
	
		// Loop over arguments passed to program
		forv i = 1/`: word count `color'' {
		
			// Store current word in local
			loc theword `: word `i' of "`color'"'
		
			// Check for RGB string by matching on string that does not contain letters
			if regexm(`"`theword'"', "[a-zA-Z]") == 0 {
			
				// Search for the RGB values
				mata: brewColorSearch("`theword'")
			
			} // End IF Block for RGB string
			
			// If not RGB String or varname assume it is a named color
			else {
			
				// Search for the RGB values
				mata: brewNameSearch("`theword'")
			
			} // End ELSE Block for named colors
		
		} // End Loop over arguments

	} // End ELSE Block for multi word cases
	
	// Return normal vision/baseline RGB string
	ret loc rgb `rgb'
	
	// Return total color blindness RGB string
	ret loc achromatopsia `achromatopsia'
	
	// Return red color blindness RGB string
	ret loc protanopia `protanopia'
	
	// Return green color blindness RGB string
	ret loc deuteranopia `deuteranopia'
	
	// Return blue color blindness RGB string
	ret loc tritanopia `tritanopia'
	
// End program definition
end

