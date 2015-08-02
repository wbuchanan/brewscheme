********************************************************************************
* Description of the Program -												   *
* This program is used to check the meta data available on different visual    *
* properties of a given color palette for a specified number of colors.		   *
*                                                                              *
* Data Requirements -														   *
*     none                                                                     *
*																			   *
* System Requirements -														   *
*     none                                                                     *
*                                                                              *
* Program Output -                                                             *
*     r(paletteName[#Max][#C]_print) - Print friendliness indicator     	   *
*     r(paletteName[#Max][#C]_photocopy) - Photocopier friendliness indicator  *
*     r(paletteName[#Max][#C]_lcd) - LCD Viewing friendliness indicator        *
*     r(paletteName[#Max][#C]_colorblind) - Colorblindness friendliness		   *
*                                                                              *
* Lines -                                                                      *
*     517                                                                      *
*                                                                              *
********************************************************************************
		
*! brewmeta
*! v 0.0.4
*! 02AUG2015

// Drop the program from memory if loaded
cap prog drop brewmeta

// Define the program as an rclass program
prog def brewmeta, rclass

	// Specify the version number
	version 13.1

	// Define the syntax structure of the program
	syntax anything(name = palette id = "palette name"), colorid(integer) ///   
		[Colors(integer -12) PROPerties PROPerties2(string asis) REFresh EXTras]
	
	// Preserve the data in memory
	preserve
	
		// Check for a b subdirectory in personal
		cap confirm new file `"`c(sysdir_personal)'b"'
		
		// If it would be a new directory
		if _rc == 0 {
		
			// Create the subdirectory
			qui: mkdir `"`c(sysdir_personal)'b"'
		
		} // End IF Block for b subdirectory of personal
		
		// Check for the metadata dataset
		cap confirm file `"`c(sysdir_personal)'b/brewmeta.dta"'

		// If the file doesn't exist
		if _rc != 0 | `"`refresh'"' != "" {
			
			// Create a tempfile to read the JS into
			tempfile brewjs
			
			// Get the current date/time
			loc date `"`c(current_date)'"'
			loc time `"`c(current_time)'"'
						
			// Read the javascript into memory
			qui: copy "http://www.colorbrewer2.org/colorbrewer_schemes.js" 	 ///   
			`brewjs'.js
			
			// Read the data into memory
			qui: insheet using `brewjs'.js, clear
						
			// Remove extraneous metadata from the javascript file
			drop in 1/7
			
			// Parse the string into colors and meta-data properties
			split v1, g(z) p(`"'], 'properties'"')
			
			// This parses the data into the individual sets of colors
			split z1, g(w) parse(`":  {"')
			
			// Loop over the maximum colors for each subpalette
			forv i = 3/12 {
				
				// Value of 9 requires special handling
				if !inlist(`i', 9, 12) {
				
					// Return only the rgb values for the # of colors
					qui: g v`i' = regexs(1) if regexm(w2,					 ///   
											 `"([`i']: \[.*\], [`= `i' + 1'])"')
					
				} // End IF Block for # of colors within subpalette
				
				// For the case of the value of 9
				else if `i' == 9 {
				
					// Parse the string, hardcoding the next value
					qui: g v9 = regexs(1) if regexm(w2, `"([`i']: \[.*\],.*10:)"')
					
					// Get rid of left overs from regex
					qui: replace v9 = subinstr(v9, "0:", "", .)
					
				} // End ELSE Block for the special case for value 9
				
				// Need to handle case of 12 color palettes since the end differs
				else {
				
					// This regex makes sure the 12th color element isn't dropped
					qui: g v12 = regexs(1) if regexm(w2, `"(12: \[.*)"')

				} // End ELSE Block for parsing the RGB strings by # colors 
				
				// Parse out only the rgb parts of the strings
				qui: replace v`i' = ustrregexra(v`i', "([`i']: \[')|('\], [0-9])", "")

				// Split the string to create a single variable for each color
				split v`i', g(v`i'color) parse(`"', '"')
				
				// Get the variable by color combinations for each value 3-12
				qui: ds v`i'color*
				
				// Loop over the returned list of variables
				foreach x in `r(varlist)' {
				
					// Remove any extra space in the variables
					qui: replace `x' = trim(itrim(`x'))
					
					// Remove punctuation and 'rgb(' from the start of the value string
					qui: replace `x' = ustrregexra(`x', "(rgb\()|(\))", "")
					
					// Remove the commas between the values
					qui: replace `x' = subinstr(`x', ",", " ", .)
				
				} // End Loop over individual color variables
				
				// Drop the variable with the full set of color values for that sub palette
				qui: drop v`i'
				
			} // End Loop over possible number of colors within palettes

			// Parse the string to get the palette names
			qui: split v1, gen(palette) parse(":  {")

			// Clean up the string 
			qui: g palette = ustrregexra(palette1, ".* [DQS][a-z].* */", "")

			// Drop records if missing a value for palette
			drop if mi(palette)

			// Keep only the variables needed to build out the RGB values or properties
			keep palette v*color* v1

			// Parse the JS
			qui: g x = regexs(0) if regexm(v1, 								 ///   
			`"'blind':\[[0-2].*\],'print':\[[0-2].*\],'copy':\[[0-2].*\],'screen':\[[0-2].*\]"')

			// Drop observations without data
			qui: drop if mi(x)

			// Parse the returned substring from the regular expression
			qui: split x, gen(y) parse("],")

			// Parse the colorblind friendliness indicator from the JS
			qui: replace y1 = regexr(y1, "('blind':\[)", "")
			
			// Parse the print friendliness indicator from the JS
			qui: replace y2 = regexr(y2, "('print':\[)", "")
			
			// Parse the copy friendliness indicator from the JS
			qui: replace y3 = regexr(y3, "('copy':\[)", "")
			
			// Parse the LCD view friendliness indicator from the JS
			qui: replace y4 = regexr(y4, "('screen':\[)", "")
			
			// Clean up how the LCD property is parsed
			qui: replace y4 = regexr(y4, "(\])", "")

			// Split colorblind indicator string into element/color wise indicators
			qui: split y1, gen(colorblind) parse(",")

			// Split print indicator string into element/color wise indicators
			qui: split y2, gen(print) parse(",")

			// Split photocopy indicator string into element/color wise indicators
			qui: split y3, gen(photocopy) parse(",")

			// Split lcd indicator string into element/color wise indicators
			qui: split y4, gen(lcd) parse(",")

			// Drop some unnecessary junk to reduce memory usage
			drop x y1 y2 y3 y4 
			
			/* Brewer only created palettes with 3 - 12 colors, but the JS is 
			stored in such a way as to only include a maximum of 10 elements.  
			In order to align the indicators with the colors, we need to make 
			sure that the highest value indicator is numbered the same as the 
			corresponding color to which it references.  This takes the variables
			for each of the indicators and alters the number that appears as a 
			suffix from the split command and adds the appropriate number to it 
			to align the characteristics with the colors. */
			forv i = 10(-1)1 {
				
				// Use the group rename command to batch rename the indicators
				rename (colorblind`i' print`i' photocopy`i' lcd`i')			 ///   
				(colorblind`= `i' + 2' print`= `i' + 2' photocopy`= `i' + 2' ///   
				lcd`= `i' + 2')
				
			} // End Loop over the color metadata properties
			
			// Additional garbage collection to reduce memory usage
			keep palette v*color* colorblind* print* photocopy* lcd*
			
			// Start imposing a higher order normalized form on the data structure
			reshape long v3color v4color v5color v6color v7color v8color 	 ///   
			v9color v10color v11color v12color colorblind print photocopy 	 ///   
			lcd, i(palette) j(colorid)
			
			// Rename the remaining variables to normalize the data again
			rename v#color v#
			
			// Structure data in first normalized form:
			// Primary key = palette, pcolor, colorid
			reshape long v, i(palette colorblind print photocopy lcd 		 ///   
			colorid) j(pcolor)

			// Drop the record if no RGB value exists for it to save memory
			drop if mi(v)
			
			// Rename the generic variable 
			rename v rgb
			
			// Make all palette names lower cased
			replace palette = lower(palette)

			// Recast the numeric indicators into true numeric values
			qui: destring colorblind print photocopy lcd, replace

			// Get maximum number of values allowable
			qui: bys palette (pcolor colorid): egen maxcolors = max(pcolor)

			// Loop over the properties
			foreach v of var colorblind print photocopy lcd {

				// Replace with extended missing
				qui: replace `v' = .n if mi(`v')
				
			} // End Loop over properties

			// Define value labels for the meta variables
			la def colorblind 	0 "Not color blind friendly" 				 ///
								1 "Color blind friendly"  					 ///
								2 "Possibly color blind friendly"			 ///   
								.n "Missing Data on Colorblind Friendliness", ///   
								modify

			la def print	 	0 "Not print friendly" 						 ///
								1 "Print friendly"  						 ///
								2 "Possibly print friendly"					 ///   
								.n "Missing Data on Print Friendliness", modify

			la def photocopy 	0 "Not photocopy friendly" 					 ///
								1 "Photocopy friendly" 						 ///   
								2 "Possibly photocopy friendly"				 ///   
								.n "Missing Data on Photocopier Friendliness", ///   
								modify

			la def lcd			0 "Not LCD friendly" 						 ///   
								1 "LCD friendly" 							 ///   
								2 "Possibly LCD friendly"					 ///   
								.n "Missing Data on LCD Friendliness", modify
								
			// Apply the value labels to the metadata properties
			la val colorblind colorblind
			la val print print
			la val photocopy photocopy
			la val lcd lcd
	
			// Create a sequence ID for the Data set 
			qui: egen seqid = concat(palette pcolor colorid)
			
			// Get number of records
			qui: count
			
			// Store in local macro
			loc N = r(N)
			
			// Loop across observations
			forv i = 1/`N' {
			
				// Create stem for characteristics
				loc stem "`: di seqid[`i']'"
			
				// Loop over the property variables
				foreach v of var colorblind lcd photocopy print meta {
				
					// Get the characteristic for the observation
					loc theproperty : label(`v') `: di `v'[`i']'

					// Set the characteristic
					char def _dta[`stem'_`v'] `"`theproperty'"'
					
				} // End Loop over variables for characteristics
				
			} // End Loop over observations
			
			// Create local macros to store palettes based on scale types
			loc qual "accent, dark2, paired, pastel1, pastel2, set1, set2, set3"
			loc seq1 "blues, bugn, bupu, gnbu, greens, greys, oranges, orrd, pubu"
			loc seq2 "pubugn, purd, purples, rdpu, reds, ylgn, ylgnbu, ylorbr, ylorrd"
			loc div "brbg, piyg, prgn, puor, rdbu, rdgy, rdylbu, rdylgn, spectral"

			// Create a meta variable for use with the extra color palettes
			qui: g meta = cond(inlist(palette, `qual'), "Qualitative", 		 ///   
						  cond(inlist(palette, `seq1'), "Sequential",		 ///   
						  cond(inlist(palette, `seq2'), "Sequential",		 ///   
						  cond(inlist(palette, `div'), "Divergent", ""))))
			
			// Define Qualitative Palettes
			char _dta[qualitative] `"`qual'"'

			// Define Divergent Palettes
			char _dta[divergent] `"`div'"'

			// Define Sequential/Continuous Palettes
			char _dta[sequential] `"`seq1' `seq2'"'
			
			// Add characteristic to the dataset for the palettes available
			char _dta[palettes] `"`qual', `seq1', `seq2', `div'"'

			// Create variable labels
			la var palette "Name of Color Palette"
			la var pcolor "Palette by Colors Selected ID"
			la var colorblind "Colorblind Indicator"
			la var photocopy "Photocopy Indicator"
			la var print "Print Indicator"
			la var lcd "LCD/Laptop Indicator"
			la var seqid "Sequential ID for property lookups"
			la var colorid "Within pcolor ID for individual color look ups"
			la var rgb "Red-Green-Blue Values to Build Scheme Files"
			la var maxcolors "Maximum number of colors allowed for the palette"
			la var meta "Meta-Data Palette Characteristics (see char _meta[*] for more info)"
			
			// Add additional meta data characteristics to explain meta properties
			char _meta[Qualitative] "ColorBrewer Palettes Designed for Nominal/Ordinal Scale Variables"
			char _meta[Sequential] "ColorBrewer Palettes Designed for Intervallic/Ratio Scale Variables"
			char _meta[Divergent] "ColorBrewer Palettes Designed for Variables Encoding Deviances"
			
			// Define locals to store end of processing time data
			loc pdate `"`c(current_date)'"'
			loc ptime `"`c(current_time)'"'
			
			/* Add characteristics to the dataset detailing the retrieval and 
			clean up process. */
			char def _dta[timestamp] `"Data Retrieved on `date' at `time'"'
			char def _dta[rooturl] "http://www.colorbrewer2.org/"
			char def _dta[filename] "colorbrewer_schemes.js"
			char def _dta[citation] `"Brewer, C. A. (200x). http://www.ColorBrewer.org. Retrieved on `date'"'
			char def _dta[processtime] `"Finished processing at `ptime' on `pdate'"'		
			char def _dta[munged] "JavaScript Munged by brewmeta"
			char def _dta[brew] "brewmeta is available from the SSC Archives."
			char def _dta[brew2] `"Use: "ssc inst brewscheme" to install"'
			char def _dta[brew3] "Development version available at: "
			char def _dta[brew4] "https://github.com/wbuchanan/brewscheme"
			
			// Attach a checksum to the file
			qui: datasignature set 
			
			// Save the dataset
			qui: save `"`c(sysdir_personal)'b/brewmeta.dta"'
			
			// Call brewextras to add additional color palettes to the data set
			brewextra, ref union
			
			// Reload the newly saved data set
			qui: use `"`c(sysdir_personal)'b/brewmeta.dta"', clear
			
			/* This block shows up after the file is saved to speed up the next 
			run for the user since the data set won't have to be rebuilt. */

			// Check the colors option
			if `colors' < 2 {
			
				// Get the maximum value of colors for the given palette
				qui: su maxcolors if palette == "`palette'", meanonly
				
				// Get maximum value for the palette
				loc colors = `r(mean)'
				
			} // End IF Block if max colors parameter is missing or invalid
			
			// Validate the color ID parameter
			if `colorid' > `colors' {
			
				// Error out
				di as err "Color ID cannot exceed the maximum number of colors in the palette"
				
			} // End IF Block for color ID validation check
			
			// Check to make sure colors value is <= max colors for the palette
			else {
				
				// Get the maximum colors value for the palette
				qui: su maxcolors if palette == "`palette'", meanonly
				
				// Check the values
				if `colors' > `r(mean)' {
				
					// Error out of the program
					di as err "Colors argument cannot exceed the max # of colors for the palette"
					
					// Exit program
					exit
					
				} // End IF Block for validation check
			
			} // End ELSE Block for the colors -> max colors validation
			
		} // End IF Block for non-existent meta file
		
		// If the file exists
		else {
			
			// Load the dataset 
			qui: use `"`c(sysdir_personal)'b/brewmeta.dta"', clear
			
			// Check the colors option
			if `colors' < 2 {
			
				// Get the maximum value of colors for the given palette
				qui: su maxcolors if palette == "`palette'", meanonly
				
				// Get maximum value for the palette
				loc colors = `r(mean)'
				
			} // End IF Block if max colors parameter is missing or invalid
			
			// Validate the color ID parameter
			if `colorid' > `colors' {
			
				// Error out
				di as err "Color ID cannot exceed the maximum number of colors in the palette"
				
			} // End IF Block for color ID validation check
			
			// Check to make sure colors value is <= max colors for the palette
			else {
				
				// Get the maximum colors value for the palette
				qui: su maxcolors if palette == "`palette'", meanonly
				
				// Check the values
				if `colors' > `r(mean)' {
				
					// Error out of the program
					di as err "Colors argument cannot exceed the max # of colors for the palette"
					
					// Exit program
					exit
					
				} // End IF Block for validation check
			
			} // End ELSE Block for the colors -> max colors validation
			
		} // End ELSE Block for existing meta file
			
		// If all/no option specified	
		if inlist("`properties2'", "all", "") {
		
			// Loop over the property types
			foreach x in colorblind lcd photocopy print meta {
			
				// Get the characteristics
				loc prop : char _dta[`palette'`colors'`colorid'_`x']
				
				// Print to the screen
				di as res `"The color `colorid' of palette `palette' with `colors' colors is `prop'"'
				
				// Return the value
				ret local `palette'`colors'`colorid'_`x' `"`prop'"'
				
			} // End Loop over variables for characteristics
			
		} // End IF Block over all properties
			
		// other wise
		else {
		
			// Count the number of words in the string
			loc prps : word count `properties2'
			
			// Set up loop to allow the command to generalize to multiple properties
			forv i = 1/`prps' {
			
				// Get the specific property value
				loc pr`i' : word `i' of `properties2'
				
				// Get the characteristics
				loc prop : char _dta[`palette'`colors'`colorid'_`pr`i'']
				
				// Print to the screen
				di as res `"The color `colorid' of palette `palette' with `colors' colors is `prop'"'
				
				// Return the value
				ret local `palette'`colors'`colorid'_`pr`i'' `"`prop'"'
				
			} // End Loop to get properties
			
		} // End ELSE Block for specified properties
				
	// Return data to original state
	restore
		
// End of Program
end 

