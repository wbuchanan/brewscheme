********************************************************************************
* Description of the Program -												   *
* This program is a tool to facilitate Stata users developing graph schemes    *
* using research-based color palettes.  Unlike other uses of the color 		   *
* palettes developed by Brewer (see References below), this program allows 	   *
* users to specify the number of colors from any of the 35 color palettes they *
* would like to use and allows users to mix/combine different palettes for the *
* various graph types.														   *
*                                                                              *
* Data Requirements -														   *
*     none                                                                     *
*																			   *
* System Requirements -														   *
*     none                                                                     *
*                                                                              *
* Program Output -                                                             *
*     scheme-`schemename'.scheme                                               *
*                                                                              *
* Lines -                                                                      *
*     1556                                                                     *
*                                                                              *
********************************************************************************
		
*! brewmeta
*! v 0.0.1
*! 03MAY2015

// Drop the program from memory if loaded
cap prog drop brewmeta

// Define the program as an rclass program
prog def brewmeta, rclass

	// Specify the version number
	version 13.1

	// Define the syntax structure of the program
	syntax anything(name=palette id="palette name"), Colors(integer)		 ///   
		[ PROPerties PROPerties2(string asis) ]
			
	// Preserve the data in memory
	preserve
	
		// Check for a b subdirectory in personal
		cap confirm file `"`c(sysdir_personal)'/b"'
		
		// If it doesn't exist create it for the user
		if _rc != 0 {
		
			// Create the subdirectory
			qui: mkdir `"`c(sysdir_personal)'/b"'
		
		} // End IF Block for b subdirectory of personal
		
		// Check for the metadata dataset
		cap confirm file `"`c(sysdir_personal)'/b/brewmeta.dta"'

		// If the file doesn't exist
		if _rc != 0 {
			
			// Create a tempfile to read the JS into
			tempfile brewjs
			
			// Get the current date/time
			loc date `"`c(current_date)'"'
			loc time `"`c(current_time)'"'
			
			// Read the javascript into memory
			copy "http://www.colorbrewer2.org/colorbrewer_schemes.js" 	 ///   
			`brewjs'.js
			
			// Read the data into memory
			qui: insheet using `brewjs'.js
			
			// Parse the JS
			qui: g x = regexs(0) if regexm(v1, 								 ///   
			`"'blind':\[[0-2].*\],'print':\[[0-2].*\],'copy':\[[0-2].*\],'screen':\[[0-2].*\]"')

			// Drop observations without data
			qui: drop if mi(x)
			
			// Parse the returned substring from the regular expression
			qui: split x, gen(y) parse("],")

			// Parse the text from the fields containing the meta data
			qui: replace y1 = regexr(y1, "('blind':\[)", "")
			qui: replace y2 = regexr(y2, "('print':\[)", "")
			qui: replace y3 = regexr(y3, "('copy':\[)", "")
			qui: replace y4 = regexr(y4, "('screen':\[)", "")
			qui: replace y4 = regexr(y4, "(\])", "")
			
			// Create variable with name of color palette in lower case letters
			qui: g palette = regexr(regexs(0), ":  {", "") if 			 ///   
							 regexm(lower(v1), "^[a-z].*:  {")

			// Keep only essential variables
			qui: keep palette y*
			
			// Split the numbers
			qui: split y1, gen(colorblind) parse(",")
			qui: split y2, gen(print) parse(",")
			qui: split y3, gen(photocopy) parse(",")
			qui: split y4, gen(lcd) parse(",")
			
			// Drop the raw text
			drop y*
			
			// Restructure the data
			reshape long colorblind print photocopy lcd, i(palette) j(colors)

			// Convert indicators to numeric values
			qui: destring colorblind print photocopy lcd, replace

			// Define maximum number of colors for each of the palettes
			#d ;
			local accent = 8; local blues = 9; local brbg = 11; local bugn = 9; 
			local bupu = 9; local dark2 = 8; local gnbu = 9; local greens = 9; 
			local greys = 9; local orrd = 9; local oranges = 9; local prgn = 11;
			local paired = 12; local pastel1 = 9; local pastel2 = 8; local piyg = 11;
			local pubu = 9; local pubugn = 9; local puor = 11; local purd = 9;
			local purples = 9; local rdbu = 11; local rdgy = 11; local rdpu = 9;
			local rdylbu = 11; local rdylgn = 11; local reds = 9; local set1 = 9;
			local set2 = 8; local set3 = 12; local spectral = 11; local ylgn = 9;
			local ylgnbu = 9; local ylorbr = 9; local ylorrd = 8; 
			#d cr
			
			// Create variable to store total number of colors in palette
			qui: g maxcol = .
			
			// Get the names of all the palettes
			qui: levelsof palette, loc(pals)
			
			// Loop over the palettes
			foreach color of loc pals { 
			
				// Set the maximum number of colors per palette
				qui: replace maxcol = ``color'' if palette == "`color'"

			} // End Loop over palettes

			// Drop any records outside of the valid range
			qui: drop if colors > maxcol
			
			// Loop over the indicators
			foreach v of var colorblind print photocopy lcd {
			
				// Reserve namespace for temporary variable
				tempvar `v'miss
				
				// Create a temporary variable to use as a marker for logic check
				bys palette (colors): g ``v'miss' = cond(!mi(`v'), 1, 0)
				
				// Fill in missing values for cases where the value is constant
				bys palette (colors): replace `v' = `v'[1] if mi(`v') &  ///   
				``v'miss'[2] == 0
			
			} // End Loop to fill in constant missing values
				
			
			// Drop auxilary and tempvars
			qui: drop maxcol `colorblindmiss' `printmiss' `photocopymiss' 	 ///  
			`lcdmiss'
			
			// Define value labels for the meta variables
			la def colorblind 	0 "Not color blind friendly" 				 ///
								1 "Color blind friendly"  					 ///
								2 "Possibly color blind friendly"			 ///   
								.n "Data Unavailable"

			la def print	 	0 "Not print friendly" 						 ///
								1 "Print friendly"  						 ///
								2 "Possibly print friendly"					 ///   
								.n "Data Unavailable"

			la def photocopy 	0 "Not photocopy friendly" 					 ///
								1 "Photocopy friendly" 						 ///   
								2 "Possibly photocopy friendly"				 ///   
								.n "Data Unavailable"

			la def lcd			0 "Not LCD friendly" 						 ///   
								1 "LCD friendly" 							 ///   
								2 "Possibly LCD friendly"					 ///   
								.n "Data Unavailable"
								
			// Apply the value labels
			la val colorblind colorblind
			la val print print
			la val photocopy photocopy
			la val lcd lcd
				
			// Create a sequence ID for the Data set 
			qui: egen seqid = concat(palette colors)
			
			// Get number of records
			qui: count
			
			// Store in local macro
			loc N = r(N)
			
			// Loop across observations
			forv i = 1/`N' {
			
				// Create stem for characteristics
				loc stem "`: di seqid[`i']'"
			
				// Loop over the property variables
				foreach v of var colorblind lcd photocopy print {
				
					// Get the characteristic for the observation
					loc theproperty : label(`v') `: di `v'[`i']'

					// Set the characteristic
					char def _dta[`stem'_`v'] `"`theproperty'"'
					
				} // End Loop over variables for characteristics
				
			} // End Loop over observations
						
			// Create variable labels
			la var palette "Name of ColorBrewer2 Color Palette"
			la var colors "Order of Colors in the Palette"
			la var colorblind "Colorblind Indicator"
			la var photocopy "Photocopy Indicator"
			la var print "Print Indicator"
			la var lcd "LCD/Laptop Indicator"
			la var seqid "Sequential ID for property lookups"
			
			// Add characteristics to the dataset
			char def _dta[timestamp] `"Data Retrieved on `date' at `time'"'
			char def _dta[rooturl] "http://www.colorbrewer2.org/"
			char def _dta[filename] "colorbrewer_schemes.js"
			char def _dta[citation] `"Brewer, C. A. (200x). http://www.ColorBrewer.org. Retrieved on `date'"'
							
			// Attach a checksum to the file
			qui: datasignature set 
			
			// Save the dataset
			qui: save `"`c(sysdir_personal)'b/brewmeta.dta"'

		} // End IF Block for non-existent meta file
		
		// If the file exists
		else {
			
			// Load the dataset 
			qui: use `"`c(sysdir_personal)'b/brewmeta.dta"'
			
		} // End ELSE Block for existing meta file
			
		// If all/no option specified	
		if "`properties'" == "" | (inlist("`properties2'", "all", "")) {
		
			// Loop over the property types
			foreach x in colorblind lcd photocopy print {
			
				// Get the characteristics
				loc prop : char _dta[`palette'`colors'_`x']
				
				// Print to the screen
				di as res `"The color palette `palette' with `colors' colors is `prop'"'
				
				// Return the value
				ret local `palette'`colors'_`x' `"`prop'"'
				
			} // End Loop over variables for characteristics
			
		} // End IF Block over all properties
			
		// other wise
		else {
		
			// Count the number of words in the string
			loc prps : word count `properties'
			
			// Set up loop to allow the command to generalize to multiple properties
			forv i = 1/`prps' {
			
				// Get the specific property value
				loc pr`i' : word `i' of `properties'
				
				// Get the characteristics
				loc prop : char _dta[`palette'`colors'_`pr`i'']
				
				// Print to the screen
				di as res `"The color palette `palette' with `colors' colors is `prop'"'
				
				// Return the value
				ret local `palette'`colors'_`pr`i'' `"`prop'"'
				
			} // End Loop to get properties
			
		} // End ELSE Block for specified properties
				
	// Return data to original state
	restore
		
// End of Program
end 		




