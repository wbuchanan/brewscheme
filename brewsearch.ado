********************************************************************************
* Description of the Program -												   *
* This is an ado wrapper around the brewColorSearch and brewNameSearch methods * 
* of the brewsearch class.  The program returns RGB values in returned macros. *
*                                                                              *
* Data Requirements -														   *
*     none                                                                     *
*																			   *
* System Requirements -														   *
*     none                                                                     *
*                                                                              *
* Program Output -                                                             *
*	r(rgb) 				-	The normal color vision RGB value				   *
*	r(achromatopsia)	-	The complete color loss RGB value				   *
*	r(protanopia)		-	The RGB value for red color sight impairment	   *
*	r(deuteranopia)		-	The RGB value for green color sight impairment	   *
*	r(tritanopia)		-	The RGB value for blue color sight impairment	   *
*                                                                              *
* Lines -                                                                      *
*     109                                                                      *
*                                                                              *
********************************************************************************

*! brewsearch
*! v 1.0.1
*! 03APR2016

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
	
	// Create a new instance of a brewcolors object
	qui: mata: brewsearch = brewcolors()
	
	// For single word
	if `: word count `color'' == 1 & regexm(`"`: word 1 of `color''"', 		 ///   
	"[a-zA-Z]") == 0 {
	
		// Search for the RGB values
		qui: mata: brewsearch.brewColorSearch("`: word 1 of `color''")

	} // End IF Block for single RGB string 
	
	// For single word
	else if `: word count `color'' == 1 & regexm(`"`: word 1 of `color''"',  ///   
	"[a-zA-Z]") == 1 {
	
		// Search for the RGB values
		qui: mata: brewsearch.brewNameSearch("`: word 1 of `color''")

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
				qui: mata: brewsearch.brewColorSearch("`theword'")
			
			} // End IF Block for RGB string
			
			// If not RGB String or varname assume it is a named color
			else {
			
				// Search for the RGB values
				qui: mata: brewsearch.brewNameSearch("`theword'")
			
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

