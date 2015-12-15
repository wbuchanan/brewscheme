********************************************************************************
* Description of the Program -												   *
* This program is used to generate a series of colors interpolated between two *
* known colors.  There are also options available to return an arbitrarily 	   *
* brighter and/or darker color (for RGB), the inverse of the color, and 	   *
* provides options to return color strings in several color spaces.			   *
*                                                                              *
* Data Requirements -														   *
*     none                                                                     *
*																			   *
* System Requirements -														   *
*     JRE >= 1.8 															   *
*                                                                              *
* Program Output -                                                             *
*     r(start) - The value of the color used as the starting point	     	   *
*     r(end) - The value of the color used as the end point					   *
*     r(colorstring) - A string of colors from start to end in a single macro  *
*     r(terpcolor#) - The ith interpolated color between start and end		   *
*                                                                              *
* Lines -                                                                      *
*     216                                                                      *
*                                                                              *
********************************************************************************
		
*! brewterpolate
*! v 0.0.3
*! 15DEC2015

// Drop the program from memory if loaded
cap prog drop brewterpolate

// Define the program with rclass property
prog def brewterpolate, rclass

	// Set the version to interpret the code under
	version 13.1

	// Set the syntax for the program
	syntax, SColor(string) EColor(string) Colors(integer) 					 ///   
			[ LUMinance(string) ICSpace(string) RCSpace(string) INVerse ]

		// Check arguments passed to luminance parameter
		if !inlist(`"`luminance'"', "brighter", "darker", "") {

			// Print error message to screen
			di as err `"Argument `luminance' not allowed for the "' 		 ///   
			"luminance parameter.  Ignoring this argument." 

		} // End IF Block for luminance parameter

		// Check input color space
		if !inlist(`"`icspace'"', "rgb", "rgba", "srgb", "srgba", "hsb", 	 ///   
		"hsba", "web", "") {

			// Print error message to screen
			di as err `"Illegal input color space `icspace'."' _n			 ///   
			"The only allowable values are: rgb, srgb, hsb, hsba, and "		 ///   
			"web." _n  "Program defaults to RGB if no value passed."

			// Return error code
			err 198

		} // End IF Block for invalid input color space

		else if inlist(`"`icspace'"', "rgb", "rgba", "srgb", "srgba",  		 ///   
		"hsb", "hsba") {

			// Remove ',' characters and replace with spaces
			loc scolor : subinstr loc scolor "," " ", all

			// Remove double spaces and replace with single space
			loc scolor : subinstr loc scolor "  " " ", all

		} // End ELSEIF Block for input colorspace

		// Check for web-based color values
		else if `"`icspace'"' == "web" {

			loc scolor `scolor'

		} // End ELSEIF Block for web-based colors

		// Check for web-based color values
		else if `"`icspace'"' == "" {

			// Set default input color space
			loc icspace "rgb"

			// Remove ',' characters and replace with spaces
			loc scolor : subinstr loc scolor "," " ", all

			// Remove double spaces and replace with single space
			loc scolor : subinstr loc scolor "  " " ", all

		} // End ELSEIF Block for default color space

		// Check returned color space
		if !inlist(`"`rcspace'"', "rgb", "rgba", "srgb", "srgba", "hsb", 	 ///   
					"hsba", "") {

			// Print error message to screen
			di as err `"Illegal input color space `icspace'."' _n			 ///   
			"The only allowable values are: rgb(a), srgb(a), and hsb(a)."    ///   
			_n "Program defaults to RGB if no value passed."

			// Return error code
			err 198

		} // End IF Block for invalid input color space

		// If return color space is acceptable value
		else if inlist(`"`rcspace'"', "rgb", "rgba", "srgb", "srgba",  		 ///   
		"hsb", "hsba") {

			// Remove ',' characters and replace with spaces
			loc ecolor : subinstr loc ecolor "," " ", all

			// Remove double spaces and replace with single space
			loc ecolor : subinstr loc ecolor "  " " ", all
		
		} // End ELSEIF Block for return color space
		
		// Check for web-based color values
		else if `"`rcspace'"' == "web" {

			loc ecolor `ecolor'

		} // End ELSEIF Block for web-based colors

		// Check for null return colorspace
		else if `"`rcspace'"' == "" {

			// Set default return color space
			loc rcspace "rgb"

			// Remove ',' characters and replace with spaces
			loc ecolor : subinstr loc ecolor "," " ", all

			// Remove double spaces and replace with single space
			loc ecolor : subinstr loc ecolor "  " " ", all

		} // End ELSEIF Block for default returned color space

		// Set boolean value for no inverted colors
		if "`inverse'" == "" {

			// Java boolean string for no inverted colors
			loc inverse false

		} // End IF Block for inverted colors

		// If user wants inverted colors
		else {

			// Set java boolean to return inverted colors
			loc inverse true
 
		} // End ELSE Block for inverted colors

		// Incremented by 1 so there will be `colors' points between start and end
		loc icolors `= `colors' + 1'

		// Call the java program to interpolate the colors
		javacall org.paces.Stata.ColorTerp.ColorTerp interpcolors, args()

		// Clear existing return valies
		return clear
		
		// Return colors
		loc retcolors `= `colors' + 2'
		
		// Loop over the returned results
		forv i = 1/`retcolors' {

			// Set the return macros
			ret loc terpcolor`i' "`color`i''"

			// On first iteration
			if `i' == 1 {
			
				// Add each of the colors to the same macro
				loc scolorstring `""`color`i''""'
				
				// Store the starting color
				loc startingcolor "`color`i''"
			
			} // End IF Block for first iteration
			
			// ELSE Block for cases after the first iteration
			else {

				// Add each of the colors to the same macro
				loc scolorstring `"`scolorstring' "`color`i''""'
				
				// Check for last iteration and store ending color
				if `i' == `retcolors' loc endingcolor "`color`i''"
			
			} // End ELSE Block for iterations after the first
			
		} // End Loop
		
		// Return starting color
		ret loc start "`startingcolor'"
		
		// Return ending color
		ret loc end "`endingcolor'"
		
		// Return the total number of colors
		ret loc totalcolors `retcolors'
		
		// Return range for interpolated colors
		ret loc interpstart 2
		ret loc interpend `= `retcolors' - 1'

// End Program definition
end

