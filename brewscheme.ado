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
*     1964                                                                     *
*                                                                              *
********************************************************************************
		
*! brewscheme
*! v 0.0.8
*! 13OCT2015

// Drop the program from memory if loaded
cap prog drop brewscheme

// Define the program as an rclass program
prog def brewscheme, rclass

	// Specify the version number
	version 13.1

	// Define the syntax structure of the program
	syntax , SCHEMEname(string asis)										 ///   
		[ ALLSTyle(string asis) ALLColors(real 3) ALLSATuration(real 100)	 ///    
		BARSTyle(string asis) BARColors(real 3) BARSATuration(real 100)		 ///   
		SCATSTyle(string asis) SCATColors(real 3) SCATSATuration(real 100)	 ///
		AREASTyle(string asis) AREAColors(real 3) AREASATuration(real 100)	 ///
		LINESTyle(string asis) LINEColors(real 3) LINESATuration(real 100)	 ///
		BOXSTyle(string asis) BOXColors(real 3) BOXSATuration(real 100)		 ///
		DOTSTyle(string asis) DOTColors(real 3) DOTSATuration(real 100)		 ///
		PIESTyle(string asis) PIEColors(real 3) PIESATuration(real 100)		 ///
		SUNSTyle(string asis) SUNColors(real 4) SUNSATuration(real 100)		 ///
		HISTSTyle(string asis) HISTColors(real 3) HISTSATuration(real 100)	 ///
		CISTyle(string asis) CIColors(real 3) CISATuration(real 100)		 ///
		MATSTyle(string asis) MATColors(real 3) MATSATuration(real 100)		 ///
		REFLSTyle(string asis) REFLColors(real 3) REFLSATuration(real 100)	 ///
		REFMSTyle(string asis) REFMColors(real 3) REFMSATuration(real 100) 	 ///   
		CONSTart(string asis) CONEnd(string asis) CONSATuration(real 100)	 ///   
		SOMESTyle(string asis) SOMEColors(real 3) SOMESATuration(real 100)	 ///   
		REFResh DBug ]

		// Preserve data currently loaded in memory
		preserve
		
			// Check for the metadata dataset
			cap confirm new file `"`c(sysdir_personal)'b/brewmeta.dta"'

			// If file doesn't exist
			if inlist(_rc, 0, 603) | "`refresh'" != "" { {
			
				// Call brewmeta to build lookup data set
				qui: brewdb, `refresh'
				
				// Load the lookup table
				qui: use `"`c(sysdir_personal)'b/brewmeta.dta"', clear			
				
			} // End IF Block to build look up data set
				
			// If the file exists load it
			else {
				
				// Load the lookup table
				qui: use `"`c(sysdir_personal)'b/brewmeta.dta"', clear

			} // End ELSE Block to load brewmeta file
			
			// Get acceptable palette names
			qui: levelsof palette, loc(palettes)
			
			// Loop over the palette names
			foreach v of loc palettes {
			
				// Get the maximum number of colors available in the palette
				qui: su maxcolors if palette == `"`v'"', meanonly
				
				// Store in the macro with the name of the palette followed by c
				loc `v'c = `r(mean)'
				
			} // End Loop to get maximum number of colors per palette
			
			// Set local with the graph type stub names
			loc gr1 bar scat area line con box dot pie
			loc gr2 sun hist ci mat refl refm
			loc grstyles `gr1' `gr2'
			
			/* Validate arguments (if all graph types are null, an all parameter 
			must be specified */
			if mi("`barstyle'") & mi("`scatstyle'") & mi("`areastyle'") & 	 ///   
			mi("`linestyle'") & mi("`constyle'") & mi("`boxstyle'") & 		 ///  
			mi("`dotstyle'") & mi("`piestyle'") & mi("`sunstyle'") & 		 ///   
			mi("`histstyle'") & mi("`cistyle'") & mi("`matstyle'") & 		 ///   
			mi("`reflstyle'") & mi("`refmstyle'") & mi("`allstyle'") {
			
				// Print error message to the screen
				di as err "Must include either arguments for the all "		 ///   
				"parameters or use a combination of graph type arguments and "	 ///   
				"some arguments to provide default colors to the other graph types"
				
				// Kill the program
				exit	
				
			} // End IF Block for valid arguments
			
			// If all the graph styles are missing and an all style is specified
			else if mi("`barstyle'") & mi("`scatstyle'") & mi("`areastyle'") & 	 ///   
			mi("`linestyle'") & mi("`boxstyle'") & mi("`dotstyle'") & 		 ///   
			mi("`piestyle'") & mi("`sunstyle'") & mi("`histstyle'") & 		 ///   
			mi("`cistyle'") & mi("`matstyle'") & mi("`reflstyle'") & 		 ///   
			mi("`refmstyle'") & mi("`constyle'") & !mi("`allstyle'")  {

				// Set the style parameters for all graph types to the values in the 
				// all parameters
				if `allcolors' <= ``allstyle'c' {
				
					// Check to see if all style was an available palette
					if `: list allstyle in palettes' != 1 {
					
						// Let user know valid values
						di as err `"Styles arguments must be one of: `palettes'"'
						
						// Exit program
						exit
						
					} // End IF Block to check for valid color palette
					
					// Loop over graph types and assign the all styles to them
					foreach stile in "bar" "scat" "area" "line" "box" 		 ///   
						"dot" "pie" "sun" "hist" "ci" "mat" "con" "refl" "refm" {
						
						/* Assign the all style, color, and saturation levels to the 
						individual graph types. */
						loc `stile'style `allstyle'
						loc `stile'colors  `allcolors'
						loc `stile'saturation  `allsaturation'

					} // End Loop over graph types
					
				} // End IF Block to check if the # of colors is valid for the style

				// If the user selected more colors than available in the palette
				else {
				
					// Print error message to the screen
					di as err `"More colors (`allcolors') than "'			 ///   
					`"available (``allstyle'c') in the palette `allstyle'"'
					
					// Kill the program
					exit
					
				} // End ELSE Block for # colors > available colors
				
			} // End ELSEIF Block for missing graph styles with nonmissing all style
			
			// If missing some arguments make sure some parameters have values
			else if ("`barstyle'" == "" |  "`scatstyle'" == "" |   		     ///   
				"`areastyle'" == "" |  "`linestyle'" == "" |  		    	 ///   
				"`boxstyle'" == "" |  "`dotstyle'" == "" |					 ///
				"`piestyle'" == "" |  "`sunstyle'" == "" |   		    	 ///   
				"`histstyle'" == "" |  "`cistyle'" == "" |  		    	 ///   
				"`matstyle'" == "" | "`reflstyle'" == "" |  		   		 ///   
				"`refmstyle'" == "" | "`constart'" == "" | "`conend'" == "") & 	 ///   
				"`somestyle'" == "" {
				
				// If missing some graph type styles must include defaults in some
				di as err "Must include arguments for somestyle if missing graph types"
				
				// Kill program
				exit	
				
			} // End ELSEIF Block for missing types w/o some argument
			
			// If missing some graph types and defaults provided
			else if ("`barstyle'" == "" |  "`scatstyle'" == "" |   		   	 ///   
				"`areastyle'" == "" |  "`linestyle'" == "" |  		    	 ///   
				"`dotstyle'" == "" |  "`boxstyle'" == "" |  				 ///
				"`piestyle'" == "" |  "`sunstyle'" == "" |   		    	 ///   
				"`histstyle'" == "" |  "`cistyle'" == "" |  		    	 ///   
				"`matstyle'" == "" | "`reflstyle'" == "" |  		    	 ///   
				"`refmstyle'" == "" | "`constyle'" == "") & "`somestyle'" != "" {
				
				// Check to see if some style was an available palette
				if `: list somestyle in palettes' != 1 {
												
					// Let user know valid values
					di as err "Styles arguments must be one of: " _n `"`palettes'"'
					
					// Exit program
					exit
					
				} // End IF Block to check for valid color palette
				
				// Loop over # available colors per graph
				foreach stile in `grstyles' {
				
					// If the style is missing and valid # colors for default
					if "``stile'style'" == "" & `somecolors' <= ``somestyle'c' {
					
						// Loop over the individual graph types
						foreach x in "bar" "scat" "area" "line" "box" "dot"  ///   
						"pie" "sun" "hist" "ci" "mat" "refl" "con" "refm" {
						
							// If the graph type does not have a style specified
							if "``x'style'" == "" {
							
								// Assign the default styles to the graph type
								loc `x'style "`somestyle'"
								loc `x'colors `somecolors'
								loc `x'saturation `somesaturation'
								
								
							} // End IF Block for unspecified graphs
							
							// If the graph type has a style specified
							else {
							
								// Continue on to next graph type
								continue
								
							} // End ELSE Block for graphs with specified colors
							
						} // End Loop over graph types
						
						exit
						
					} // End IF Block checking # colors available for default
					
					// If more colors specified for default than available
					else if "``stile'style'" == "" & `somecolors' > ``somestyle'c' {
					
						// Print error message to screen
						di as err `"More colors (``stile'colors') than "'	 ///   
						`"available (``stile'style') in the palette "`stile'style""'
						
						// Kill the program
						err 198
						
					} // End ELSEIF Block for # colors > available for defaults
					
					// Check for # colors available for specific graph types
					else if "``stile'style'" != "" &						 ///   
						``stile'colors' > ```stile'style'c' {
						
						// Print error message to the screen
						di as err `"More colors (``stile'colors') than "'	 ///   
						`"available (``stile'style') in the palette "`stile'style""'
						
						// Kill the program
						err 198
						
					} // End ELSEIF Block for # colors > available for graph types
					
				} // End Loop over # colors for specified styles
				
			} // End ELSE Block for valid parameters
				
			// Check for data set containing the color attributes
			cap confirm file `"`c(sysdir_personal)'b/brewmeta.dta"'
			
			// If data set doesn't exist or user wants to recreate it
			if _rc != 0 | "`refresh'" != "" {
			
				// Create the dataset
				qui: brewdb, `refresh'
				
				// Load the dataset
				qui: use `"`c(sysdir_personal)'b/brewmeta.dta"', clear

			} // End IF Block for checking for brewscheme dataset
			
			// Otherwise load the metadata file
			else {
			
				// Load the dataset
				qui: use `"`c(sysdir_personal)'b/brewmeta.dta"', clear
				
			} // End ELSE Block to load the metadata file

			// If color intensity is not a valid value
			if !inlist(`allsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 	///   
				100, 200) {
				
				// If if invalid value is <= 104
				if `allsaturation' <= 104 {
				
					// Set the value to the nearest decile in [0, 100]
					loc allsaturation = round(`allsaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `allsaturation' > 104 {
				
					// Set to max valid saturation value
					loc allsaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For all other cases 
				else {
				
					// Print message to the results screen
					di "Setting ALL saturation to 100"
					
					// Set value to full saturation
					loc allsaturation 100
					
				} // End ELSE Block for all other values of saturation
				
			} // End IF Block for allsaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`barsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,   ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `barsaturation' <= 104 {
				
					// Set the value to the nearest decile in [0, 100]
					loc barsaturation = round(`barsaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `barsaturation' > 104 {
				
					// Set to max valid saturation value
					loc barsaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For bar other cases 
				else {
				
					// Print message to the results screen
					di "Setting bar graph saturation to 100"
					
					// Set value to full saturation
					loc barsaturation 100
					
				} // End ELSE Block for bar other values of saturation
				
			} // End IF Block for barsaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`areasaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `areasaturation' <= 104 {
				
					// Set the value to the nearest decile in [0, 100]
					loc areasaturation = round(`areasaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `areasaturation' > 104 {
				
					// Set to max valid saturation value
					loc areasaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For area other cases 
				else {
				
					// Print message to the results screen
					di "Setting area graph saturation to 100"
					
					// Set value to full saturation
					loc areasaturation 100
					
				} // End ELSE Block for area other values of saturation
				
			} // End IF Block for areasaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`consaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,   ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `consaturation' <= 104 {
				
					// Set the value to the nearest deconle in [0, 100]
					loc consaturation = round(`consaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `consaturation' > 104 {
				
					// Set to max valid saturation value
					loc consaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For con other cases 
				else {
				
					// Print message to the results screen
					di "Setting contour plot saturation to 100"
					
					// Set value to full saturation
					loc consaturation 100
					
				} // End ELSE Block for con other values of saturation
				
			} // End IF Block for consaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`boxsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,   ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `boxsaturation' <= 104 {
				
					// Set the value to the nearest decile in [0, 100]
					loc boxsaturation = round(`boxsaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `boxsaturation' > 104 {
				
					// Set to max valid saturation value
					loc boxsaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For box other cases 
				else {
				
					// Print message to the results screen
					di "Setting box plot saturation to 100"
					
					// Set value to full saturation
					loc boxsaturation 100
					
				} // End ELSE Block for box other values of saturation
				
			} // End IF Block for boxsaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`piesaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `piesaturation' <= 104 {
				
					// Set the value to the nearest decile in [0, 100]
					loc piesaturation = round(`piesaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `piesaturation' > 104 {
				
					// Set to max valid saturation value
					loc piesaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For pie other cases 
				else {
				
					// Print message to the results screen
					di "Setting pie graph saturation to 100"
					
					// Set value to full saturation
					loc piesaturation 100
					
				} // End ELSE Block for pie other values of saturation
				
			} // End IF Block for piesaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`sunsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,   ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `sunsaturation' <= 104 {
				
					// Set the value to the nearest decile in [0, 100]
					loc sunsaturation = round(`sunsaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `sunsaturation' > 104 {
				
					// Set to max valid saturation value
					loc sunsaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For sun other cases 
				else {
				
					// Print message to the results screen
					di "Setting sunflower plot saturation to 100"
					
					// Set value to full saturation
					loc sunsaturation 100
					
				} // End ELSE Block for sun other values of saturation
				
			} // End IF Block for sunsaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`histsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `histsaturation' <= 104 {
				
					// Set the value to the nearest decile in [0, 100]
					loc histsaturation = round(`histsaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `histsaturation' > 104 {
				
					// Set to max valid saturation value
					loc histsaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For hist other cases 
				else {
				
					// Print message to the results screen
					di "Setting histogram saturation to 100"
					
					// Set value to full saturation
					loc histsaturation 100
					
				} // End ELSE Block for hist other values of saturation
				
			} // End IF Block for histsaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`cisaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,    ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `cisaturation' <= 104 {
				
					// Set the value to the nearest decile in [0, 100]
					loc cisaturation = round(`cisaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `cisaturation' > 104 {
				
					// Set to max valid saturation value
					loc cisaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For ci other cases 
				else {
				
					// Print message to the results screen
					di "Setting confidence interval saturation to 100"
					
					// Set value to full saturation
					loc cisaturation 100
					
				} // End ELSE Block for ci other values of saturation
				
			} // End IF Block for cisaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`matsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,   ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `matsaturation' <= 104 {
				
					// Set the value to the nearest dematle in [0, 100]
					loc matsaturation = round(`matsaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `matsaturation' > 104 {
				
					// Set to max valid saturation value
					loc matsaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For mat other cases 
				else {
				
					// Print message to the results screen
					di "Setting scatterplot matrix saturation to 100"
					
					// Set value to full saturation
					loc matsaturation 100
					
				} // End ELSE Block for mat other values of saturation
				
			} // End IF Block for matsaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`reflsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `reflsaturation' <= 104 {
				
					// Set the value to the nearest dereflle in [0, 100]
					loc reflsaturation = round(`reflsaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `reflsaturation' > 104 {
				
					// Set to max valid saturation value
					loc reflsaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For refl other cases 
				else {
				
					// Print message to the results screen
					di "Setting reference line saturation to 100"
					
					// Set value to full saturation
					loc reflsaturation 100
					
				} // End ELSE Block for refl other values of saturation
				
			} // End IF Block for reflsaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`refmsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `refmsaturation' <= 104 {
				
					// Set the value to the nearest derefmle in [0, 100]
					loc refmsaturation = round(`refmsaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `refmsaturation' > 104 {
				
					// Set to max valid saturation value
					loc refmsaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For refm other cases 
				else {
				
					// Print message to the results screen
					di "Setting reference marker saturation to 100"
					
					// Set value to full saturation
					loc refmsaturation 100
					
				} // End ELSE Block for refm other values of saturation
				
			} // End IF Block for refmsaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`somesaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `somesaturation' <= 104 {
				
					// Set the value to the nearest decile in [0, 100]
					loc somesaturation = round(`somesaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `somesaturation' > 104 {
				
					// Set to max valid saturation value
					loc somesaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For some other cases 
				else {
				
					// Print message to the results screen
					di "Setting some saturation to 100"
					
					// Set value to full saturation
					loc somesaturation 100
					
				} // End ELSE Block for some other values of saturation
				
			} // End IF Block for somesaturation value validation

			// Line saturation gets defined as a color multiplier
			// loc linesaturation = `linesaturation'/100
			
			// Dot plot saturation is defined as a color multiplier
			// loc dotsaturation = `dotsaturation'/100
								
			// Scatterplot saturation gets defined as a color multiplier
			// loc scatsaturation = `scatsaturation'/100
					
			// Write the scheme file to a location on the path
			qui: file open scheme using ///
				`"`c(sysdir_plus)'/s/scheme-`schemename'.scheme"', w replace

			// Find maximum number of colors to set the recycle parameter
			loc pcycles = max(	`barcolors', `scatcolors', `areacolors',	 ///   
								`linecolors', `boxcolors', `dotcolors', 	 ///   
								`piecolors', `suncolors', `histcolors', 	 ///   
								`cicolors', `matcolors', `reflcolors', 		 ///   
								`refmcolors')
			
			// Loop over color macros
			foreach color in bar scat area line box dot pie hist ci mat		 ///   
			refl refm sun {
			
				/* Create the sequence of color ids for each graph type based on 
				the maximum number of colors in any listed color argument. */
				qui: mata: recycle(``color'colors', `pcycles')
				
				// Assign the id sequence to a local with seq as suffix
				loc `color'seq = `"`sequence'"'
				
				// Get RGB values for a given palette and max colors
				qui: levelsof rgb if palette == "``color'style'" & 			 ///   
				pcolor == ``color'colors', loc(rgbs)
				
				if "`dbug'" != "" {
					levelsof rgb if palette == "``color'style'" & pcolor == ``color'colors'
					di "Graph type = `color'"
					// Print debugging message
					di "Color: `color'" _n "Number of colors: ``color''" _n  ///   
					`"Color sequence: ``color'seq'"'
				}
				
				// Loop over the rgb values to construct the graph specific  
				// rgb values
				foreach c of loc `color'seq {
				
					// Construct macro with RGB values for lookup
					loc `color'rgb `"``color'rgb' "`: word `c' of `rgbs''" "'
					
				} // End Loop
				
				// Check for debug option
				if "`dbug'" != "" {
									
					// Print the RGB color string to screen
					di `"``color'rgb'"'
				
				} // End debug option
				
			} // End Loop over number of colors for graph types					
							  
			file write scheme `"sequence 1210"' _n
			file write scheme `"label "`style' `colors'""' _n
			file write scheme `"system naturally_white 1"' _n

			file write scheme `"graphsize 5"' _n
			file write scheme `"graphsize x 9"' _n
			file write scheme `"graphsize y 6"' _n

			file write scheme `"numstyle 1"' _n
			file write scheme `"numstyle grid_outer_tol 0.23"' _n
			file write scheme `"numstyle legend_rows 1"' _n
			file write scheme `"numstyle legend_cols 2"' _n
			file write scheme `"numstyle zyx2rows 0"' _n
			file write scheme `"numstyle zyx2cols 1"' _n
			file write scheme `"numstyle graph_aspect 0"' _n
			file write scheme `"numstyle pcycle `pcycles'"' _n
			file write scheme `"numstyle max_wted_symsize 10"' _n
			file write scheme `"numstyle bar_num_dots 100"' _n
			file write scheme `"numstyle dot_num_dots 100"' _n
			file write scheme `"numstyle dot_extend_high 0"' _n
			file write scheme `"numstyle dot_extend_low 0"' _n
			file write scheme `"numstyle pie_angle 90"' _n
			file write scheme `"numstyle contours `pcycles'"' _n

			file write scheme `"gsize medium"' _n
			file write scheme `"gsize gap tiny"' _n
			file write scheme `"gsize text medsmall"' _n
			file write scheme `"gsize body small"' _n
			file write scheme `"gsize small_body vsmall"' _n
			file write scheme `"gsize heading medlarge"' _n
			file write scheme `"gsize subheading medium"' _n
			file write scheme `"gsize axis_title small"' _n
			file write scheme `"gsize matrix_label medium"' _n
			file write scheme `"gsize label medsmall"' _n
			file write scheme `"gsize small_label small"' _n
			file write scheme `"gsize matrix_marklbl medsmall"' _n
			file write scheme `"gsize key_label small"' _n
			file write scheme `"gsize note vsmall"' _n
			file write scheme `"gsize star small"' _n
			file write scheme `"gsize text_option small"' _n
			file write scheme `"gsize dot_rectangle third_tiny"' _n
			file write scheme `"gsize axis_space half_tiny"' _n
			file write scheme `"gsize axis_title_gap minuscule"' _n
			file write scheme `"gsize tick tiny"' _n
			file write scheme `"gsize minortick third_tiny"' _n
			file write scheme `"gsize tickgap half_tiny"' _n
			file write scheme `"gsize notickgap tiny"' _n
			file write scheme `"gsize tick_label small"' _n
			file write scheme `"gsize tick_biglabel small"' _n
			file write scheme `"gsize minortick_label vsmall"' _n
			file write scheme `"gsize filled_text medsmall"' _n
			file write scheme `"gsize reverse_big large"' _n
			file write scheme `"gsize alternate_gap zero"' _n
			file write scheme `"gsize title_gap small"' _n
			file write scheme `"gsize key_gap small"' _n
			file write scheme `"gsize key_linespace small"' _n
			file write scheme `"gsize star_gap minuscule"' _n
			file write scheme `"gsize legend_colgap medium"' _n
			file write scheme `"gsize label_gap half_tiny"' _n
			file write scheme `"gsize matrix_mlblgap half_tiny"' _n
			file write scheme `"gsize barlabel_gap tiny"' _n
			file write scheme `"gsize legend_row_gap tiny"' _n
			file write scheme `"gsize legend_col_gap large"' _n
			file write scheme `"gsize legend_key_gap vsmall"' _n
			file write scheme `"gsize legend_key_xsize 13"' _n
			file write scheme `"gsize legend_key_ysize medsmall"' _n
			file write scheme `"gsize zyx2legend_key_gap tiny"' _n
			file write scheme `"gsize zyx2legend_key_xsize vhuge"' _n
			file write scheme `"gsize zyx2legend_key_ysize medium"' _n
			file write scheme `"gsize zyx2rowgap zero"' _n
			file write scheme `"gsize zyx2colgap large"' _n
			file write scheme `"gsize clegend_width medsmall"' _n
			file write scheme `"gsize clegend_height zero"' _n
			file write scheme `"gsize pie_explode medsmall"' _n
			file write scheme `"gsize pielabel_gap medsmall"' _n
			file write scheme `"gsize plabel vsmall"' _n
			file write scheme `"gsize pboxlabel vsmall"' _n
			file write scheme `"gsize sts_risktable_space tiny"' _n
			file write scheme `"gsize sts_risktable_tgap tiny"' _n
			file write scheme `"gsize sts_risktable_lgap tiny"' _n
			file write scheme `"gsize sts_risk_label medsmall"' _n
			file write scheme `"gsize sts_risk_title medsmall"' _n
			file write scheme `"gsize sts_risk_tick zero"' _n
			
			file write scheme `"special default_slope1 .3"' _n
			file write scheme `"special default_knot1 4"' _n
			file write scheme `"special default_slope2 1"' _n
			file write scheme `"special by_slope1 .3"' _n
			file write scheme `"special by_knot1 3"' _n
			file write scheme `"special by_slope2 1"' _n
			file write scheme `"special combine_slope1 .5"' _n
			file write scheme `"special combine_knot1 3"' _n
			file write scheme `"special combine_slope2 1"' _n
			file write scheme `"special matrix_slope1 .3"' _n
			file write scheme `"special matrix_knot1 4"' _n
			file write scheme `"special matrix_slope2 1"' _n
			file write scheme `"special matrix_yaxis "ylabels(#3, angle(horizontal) axis(Y))""' _n
			file write scheme `"special matrix_xaxis "xlabels(#3, axis(X))""' _n

			file write scheme `"relsize bar_gap 40pct"' _n
			file write scheme `"relsize bar_groupgap 80pct"' _n
			file write scheme `"relsize bar_supgroupgap 200pct"' _n
			file write scheme `"relsize bar_outergap 20pct"' _n
			file write scheme `"relsize dot_gap neg100pct"' _n
			file write scheme `"relsize dot_groupgap 0pct"' _n
			file write scheme `"relsize dot_supgroupgap 75pct"' _n
			file write scheme `"relsize dot_outergap 0pct"' _n
			file write scheme `"relsize box_gap 50pct"' _n
			file write scheme `"relsize box_groupgap 100pct"' _n
			file write scheme `"relsize box_supgroupgap 150pct"' _n
			file write scheme `"relsize box_outergap 25pct"' _n
			file write scheme `"relsize box_fence 75pct"' _n
			file write scheme `"relsize box_fencecap 0pct"' _n
			
			file write scheme `"symbolsize medium"' _n
			file write scheme `"symbolsize symbol medium"' _n
			file write scheme `"symbolsize smallsymbol medsmall"' _n
			file write scheme `"symbolsize star vlarge"' _n
			file write scheme `"symbolsize histogram medium"' _n
			file write scheme `"symbolsize histback vlarge"' _n
			file write scheme `"symbolsize dots vtiny"' _n
			file write scheme `"symbolsize ci medlarge"' _n
			file write scheme `"symbolsize ci2 medlarge"' _n
			file write scheme `"symbolsize matrix medsmall"' _n
			file write scheme `"symbolsize refmarker medium"' _n
			file write scheme `"symbolsize sunflower medium"' _n
			file write scheme `"symbolsize backsymbol large"' _n
			file write scheme `"symbolsize backsymspace large"' _n
			file write scheme `"symbolsize p medium"' _n
			file write scheme `"symbolsize pback zero"' _n
			file write scheme `"symbolsize parrow medium"' _n
			file write scheme `"symbolsize parrowbarb medsmall"' _n
			
			// Number of ticks
			file write scheme `"numticks_g 0"' _n
			file write scheme `"numticks_g major 5"' _n
			file write scheme `"numticks_g horizontal_major 5"' _n
			file write scheme `"numticks_g vertical_major 5"' _n
			file write scheme `"numticks_g horizontal_minor 0"' _n
			file write scheme `"numticks_g vertical_minor 0"' _n
			file write scheme `"numticks_g horizontal_tmajor 0"' _n
			file write scheme `"numticks_g vertical_tmajor 0"' _n
			file write scheme `"numticks_g horizontal_tminor 0"' _n
			file write scheme `"numticks_g vertical_tminor 0"' _n

			file write scheme `"color black"' _n
			file write scheme `"color background white"' _n
			file write scheme `"color foreground white"' _n
			file write scheme `"color symbol black"' _n
			file write scheme `"color backsymbol none"' _n
			file write scheme `"color text black"' _n
			file write scheme `"color body black"' _n
			file write scheme `"color small_body black"' _n
			file write scheme `"color heading black"' _n
			file write scheme `"color subheading black"' _n
			file write scheme `"color axis_title black"' _n
			file write scheme `"color matrix_label black"' _n
			file write scheme `"color label black"' _n
			file write scheme `"color key_label black"' _n
			file write scheme `"color tick_label black"' _n
			file write scheme `"color tick_biglabel black"' _n
			file write scheme `"color matrix_marklbl black"' _n
			file write scheme `"color sts_risk_label black"' _n
			file write scheme `"color sts_risk_title black"' _n
			file write scheme `"color box none"' _n
			file write scheme `"color textbox white"' _n
			file write scheme `"color mat_label_box white"' _n
			file write scheme `"color text_option black"' _n
			file write scheme `"color text_option_line white"' _n
			file write scheme `"color text_option_fill white"' _n
			file write scheme `"color filled_text black"' _n
			file write scheme `"color filled white"' _n
			file write scheme `"color bylabel_outline white"' _n
			file write scheme `"color reverse_big none"' _n
			file write scheme `"color reverse_big_line black"' _n
			file write scheme `"color reverse_big_text white"' _n
			file write scheme `"color grid white"' _n
			file write scheme `"color major_grid white"' _n
			file write scheme `"color minor_grid white"' _n
			file write scheme `"color axisline black"' _n
			file write scheme `"color tick black"' _n
			file write scheme `"color minortick black"' _n
			file write scheme `"color ci_line black"' _n
			file write scheme `"color ci_arealine black"' _n
			file write scheme `"color ci_area "`: word 1 of `areargb''" "' _n
			file write scheme `"color ci_symbol "`: word 1 of `cirgb''" "' _n
			file write scheme `"color ci2_line black"' _n
			file write scheme `"color ci2_arealine black"' _n
			file write scheme `"color ci2_area "`: word 2 of `areargb''" "' _n
			file write scheme `"color ci2_symbol "`: word 2 of `cirgb''" "' _n
			file write scheme `"color pieline black"' _n
			file write scheme `"color matrix white"' _n
			file write scheme `"color matrixmarkline black"' _n
			file write scheme `"color refmarker black"' _n
			file write scheme `"color refmarkline black"' _n
			file write scheme `"color histogram "`: word 1 of `histrgb''" "' _n
			file write scheme `"color histback white"' _n
			file write scheme `"color histogram_line black"' _n
			file write scheme `"color dot_line black"' _n
			file write scheme `"color dot_arealine black"' _n
			file write scheme `"color dot_area "`: word 1 of `areargb''" "' _n
			file write scheme `"color dotmarkline black"' _n
			file write scheme `"color xyline black"' _n
			file write scheme `"color refline black"' _n
			file write scheme `"color dots black"' _n
			file write scheme `"color plotregion white"' _n
			file write scheme `"color plotregion_line white"' _n
			file write scheme `"color matrix_plotregion white"' _n
			file write scheme `"color matplotregion_line black"' _n
			file write scheme `"color legend white"' _n
			file write scheme `"color legend_line white"' _n
			file write scheme `"color clegend none"' _n
			file write scheme `"color clegend_outer none"' _n
			file write scheme `"color clegend_inner none"' _n
			file write scheme `"color clegend_line none"' _n
			
			// Check for values for starting/ending contour plots
			if "`constart'" == "" {
				loc constart blue
			} 
			if "`conend'" == "" {
				loc conend orange
			}
			
			file write scheme `"color contour_begin `constart'"' _n
			file write scheme `"color contour_end `conend'"' _n
			file write scheme `"color zyx2 black"' _n
			file write scheme `"color sunflower "`: word 1 of `sunrgb''""' _n
			file write scheme `"color sunflowerlb black"' _n
			file write scheme `"color sunflowerlf "`: word 2 of `sunrgb''""' _n
			file write scheme `"color sunflowerdb black"' _n
			file write scheme `"color sunflowerdf "`: word 3 of `sunrgb''""' _n
			file write scheme `"color pboxlabelfill white"' _n
			file write scheme `"color plabelfill white"' _n
			file write scheme `"color pmarkback white"' _n
			file write scheme `"color pmarkbkfill white"' _n
			
			file write scheme `"symbol circle"' _n
			file write scheme `"symbol sunflower circle_hollow"' _n
			file write scheme `"symbol none none"' _n
			file write scheme `"symbol histogram circle"' _n
			file write scheme `"symbol histback none"' _n
			file write scheme `"symbol dots circle"' _n
			file write scheme `"symbol ci circle"' _n
			file write scheme `"symbol ci2 circle"' _n
			file write scheme `"symbol ilabel none"' _n
			file write scheme `"symbol matrix circle"' _n
			file write scheme `"symbol refmarker circle"' _n
			file write scheme `"symbol p circle"' _n
			file write scheme `"symbol pback none"' _n
			file write scheme `"symbol pbarback none"' _n
			file write scheme `"symbol pdotback none"' _n
			
			file write scheme `"linepattern solid"' _n
			file write scheme `"linepattern foreground blank"' _n
			file write scheme `"linepattern background blank"' _n
			file write scheme `"linepattern ci solid"' _n
			file write scheme `"linepattern ci_area solid"' _n
			file write scheme `"linepattern histogram solid"' _n
			file write scheme `"linepattern dendrogram solid"' _n
			file write scheme `"linepattern grid blank"' _n
			file write scheme `"linepattern major_grid blank"' _n
			file write scheme `"linepattern minor_grid blank"' _n
			file write scheme `"linepattern axisline solid"' _n
			file write scheme `"linepattern tick solid"' _n
			file write scheme `"linepattern minortick solid"' _n
			file write scheme `"linepattern xyline solid"' _n
			file write scheme `"linepattern refline solid"' _n
			file write scheme `"linepattern refmarker solid"' _n
			file write scheme `"linepattern matrixmark solid"' _n
			file write scheme `"linepattern dots solid"' _n
			file write scheme `"linepattern dot solid"' _n
			file write scheme `"linepattern dot_area solid"' _n
			file write scheme `"linepattern dotmark solid"' _n
			file write scheme `"linepattern pie solid"' _n
			file write scheme `"linepattern legend solid"' _n
			file write scheme `"linepattern clegend solid"' _n
			file write scheme `"linepattern plotregion solid"' _n
			file write scheme `"linepattern sunflower solid"' _n
			file write scheme `"linepattern matrix_plotregion solid"' _n
			file write scheme `"linepattern text_option blank"' _n
			file write scheme `"linepattern zyx2 solid"' _n
			file write scheme `"linepattern p solid"' _n
			file write scheme `"linepattern pmark solid"' _n
			
			file write scheme `"markerstyle p1"' _n
			file write scheme `"markerstyle dots dots"' _n
			file write scheme `"markerstyle star star"' _n
			file write scheme `"markerstyle histogram histogram"' _n
			file write scheme `"markerstyle ci ci"' _n
			file write scheme `"markerstyle ci2 ci2"' _n
			file write scheme `"markerstyle ilabel ilabel"' _n
			file write scheme `"markerstyle matrix matrix"' _n
			file write scheme `"markerstyle box_marker refmarker"' _n
			file write scheme `"markerstyle editor editor"' _n
			file write scheme `"markerstyle editor_arrow ed_arrow"' _n
			file write scheme `"markerstyle sunflower sunflower"' _n

			// Settings for Margins
			file write scheme `"margin zero"' _n
			file write scheme `"margin graph medium"' _n
			file write scheme `"margin twoway medsmall"' _n
			file write scheme `"margin bygraph zero"' _n
			file write scheme `"margin combinegraph medsmall"' _n
			file write scheme `"margin combine_region zero"' _n
			file write scheme `"margin matrixgraph zero"' _n
			file write scheme `"margin piegraph small"' _n
			file write scheme `"margin piegraph_region medsmall"' _n
			file write scheme `"margin matrix_plotreg small"' _n
			file write scheme `"margin matrix_label zero"' _n
			file write scheme `"margin mat_label_box zero"' _n
			file write scheme `"margin by_indiv small"' _n
			file write scheme `"margin text vsmall"' _n
			file write scheme `"margin textbox zero"' _n
			file write scheme `"margin body vsmall"' _n
			file write scheme `"margin small_body vsmall"' _n
			file write scheme `"margin heading vsmall"' _n
			file write scheme `"* margin heading ".6 .6 .6 .6""' _n
			file write scheme `"margin subheading vsmall"' _n
			file write scheme `"margin axis_title zero"' _n
			file write scheme `"margin label zero"' _n
			file write scheme `"margin key_label zero"' _n
			file write scheme `"margin text_option zero"' _n
			file write scheme `"margin plotregion medsmall"' _n
			file write scheme `"margin star tiny"' _n
			file write scheme `"margin bargraph bargraph"' _n
			file write scheme `"margin boxgraph bargraph"' _n
			file write scheme `"margin dotgraph bargraph"' _n
			file write scheme `"margin hbargraph bargraph"' _n
			file write scheme `"margin hboxgraph bargraph"' _n
			file write scheme `"margin hdotgraph bargraph"' _n
			file write scheme `"margin legend small"' _n
			file write scheme `"margin legend_key_region tiny"' _n
			file write scheme `"margin legend_boxmargin small"' _n
			file write scheme `"margin clegend medium"' _n
			file write scheme `"margin cleg_title medsmall"' _n
			file write scheme `"margin clegend_boxmargin small"' _n
			file write scheme `"margin key_label zero"' _n
			file write scheme `"margin filled_textbox small"' _n
			file write scheme `"margin filled_box zero"' _n
			file write scheme `"margin editor zero"' _n
			file write scheme `"margin plabel zero"' _n
			file write scheme `"margin plabelbox zero"' _n
			file write scheme `"margin pboxlabel zero"' _n
			file write scheme `"margin pboxlabelbox zero"' _n
			
			// Shade/fill settings
			file write scheme `"shadestyle foreground"' _n
			file write scheme `"shadestyle background background"' _n
			file write scheme `"shadestyle foreground foreground"' _n
			file write scheme `"shadestyle ci ci"' _n
			file write scheme `"shadestyle ci2 ci2"' _n
			file write scheme `"shadestyle histogram histogram"' _n
			file write scheme `"shadestyle dendrogram dendrogram"' _n
			file write scheme `"shadestyle dotchart dotchart"' _n
			file write scheme `"shadestyle legend legend"' _n
			file write scheme `"shadestyle clegend_outer clegend_outer"' _n
			file write scheme `"shadestyle clegend_inner clegend_inner"' _n
			file write scheme `"shadestyle clegend_preg none"' _n
			file write scheme `"shadestyle plotregion plotregion"' _n
			file write scheme `"shadestyle matrix_plotregion matrix_plotregion"' _n
			file write scheme `"shadestyle sunflower sunflower"' _n
			file write scheme `"shadestyle sunflowerlb sunflowerlb"' _n
			file write scheme `"shadestyle sunflowerdb sunflowerdb"' _n
			file write scheme `"shadestyle contour_begin contour_begin"' _n
			file write scheme `"shadestyle contour_end contour_end"' _n
			file write scheme `"shadestyle p foreground"' _n
			
			// Settings for graph lines
			file write scheme `"linestyle foreground"' _n
			file write scheme `"linestyle background background"' _n
			file write scheme `"linestyle foreground foreground"' _n
			file write scheme `"linestyle symbol symbol"' _n
			file write scheme `"linestyle boxline foreground"' _n
			file write scheme `"linestyle textbox none"' _n
			file write scheme `"linestyle axis axisline"' _n
			file write scheme `"linestyle axis_withgrid foreground"' _n
			file write scheme `"linestyle zero_line foreground"' _n
			file write scheme `"linestyle tick tick"' _n
			file write scheme `"linestyle minortick minortick"' _n
			file write scheme `"linestyle star p1"' _n
			file write scheme `"linestyle ci ci"' _n
			file write scheme `"linestyle ci_area ci_area"' _n
			file write scheme `"linestyle ci2 ci2"' _n
			file write scheme `"linestyle ci2_area ci2_area"' _n
			file write scheme `"linestyle histogram histogram"' _n
			file write scheme `"linestyle histback histogram"' _n
			file write scheme `"linestyle dendrogram dendrogram"' _n
			file write scheme `"linestyle grid none"' _n
			file write scheme `"linestyle major_grid none"' _n
			file write scheme `"linestyle minor_grid none"' _n
			file write scheme `"linestyle xyline xyline"' _n
			file write scheme `"linestyle refline refline"' _n
			file write scheme `"linestyle refmarker refmarker"' _n
			file write scheme `"linestyle matrixmark matrixmark"' _n
			file write scheme `"linestyle matrix p1solid"' _n
			file write scheme `"linestyle dotchart dotchart"' _n
			file write scheme `"linestyle dotchart_area dotchart_area"' _n
			file write scheme `"linestyle dotmark dotmark"' _n
			file write scheme `"linestyle box_whiskers ci"' _n
			file write scheme `"linestyle box_median refline"' _n
			file write scheme `"linestyle pie_line pie"' _n
			file write scheme `"linestyle legend none"' _n
			file write scheme `"linestyle clegend clegend"' _n
			file write scheme `"linestyle clegend_outer none"' _n
			file write scheme `"linestyle clegend_inner none"' _n
			file write scheme `"linestyle clegend_preg foreground"' _n
			file write scheme `"linestyle mat_label_box foreground"' _n
			file write scheme `"linestyle reverse_big reverse_big"' _n
			file write scheme `"linestyle plotregion plotregion"' _n
			file write scheme `"linestyle matrix_plotregion matrix_plotregion"' _n
			file write scheme `"linestyle dots dot"' _n
			file write scheme `"linestyle editor editor"' _n
			file write scheme `"linestyle sunflower sunflower"' _n
			file write scheme `"linestyle sunflowerlb sunflowerlb"' _n
			file write scheme `"linestyle sunflowerlf sunflowerlf"' _n
			file write scheme `"linestyle sunflowerdb sunflowerdb"' _n
			file write scheme `"linestyle sunflowerdf sunflowerdf"' _n
			file write scheme `"linestyle text_option text_option"' _n
			file write scheme `"linestyle sts_risktable none"' _n
			file write scheme `"linestyle zyx2 zyx2"' _n
			file write scheme `"linestyle pmarkback background"' _n
			file write scheme `"linestyle pboxmarkback background"' _n
			file write scheme `"linestyle plabel foreground"' _n
			file write scheme `"linestyle pboxlabel foreground"' _n
			file write scheme `"linewidth thin thin"' _n
			file write scheme `"linewidth medium medium"' _n
			file write scheme `"linewidth p vthin"' _n
			file write scheme `"linewidth foreground none"' _n
			file write scheme `"linewidth background none"' _n
			file write scheme `"linewidth grid none"' _n
			file write scheme `"linewidth major_grid none"' _n
			file write scheme `"linewidth minor_grid none"' _n
			file write scheme `"linewidth axisline thin"' _n
			file write scheme `"linewidth tick vthin"' _n
			file write scheme `"linewidth tickline vthin"' _n
			file write scheme `"linewidth minortick vvthin"' _n
			file write scheme `"linewidth ci medium"' _n
			file write scheme `"linewidth ci_area medthin"' _n
			file write scheme `"linewidth ci2 medium"' _n
			file write scheme `"linewidth ci2_area medthin"' _n
			file write scheme `"linewidth histogram vthin"' _n
			file write scheme `"linewidth dendrogram medium"' _n
			file write scheme `"linewidth xyline medthin"' _n
			file write scheme `"linewidth refline medium"' _n
			file write scheme `"linewidth refmarker medthin"' _n
			file write scheme `"linewidth matrixmark vvthin"' _n
			file write scheme `"linewidth dots vthin"' _n
			file write scheme `"linewidth dot_line medthick"' _n
			file write scheme `"linewidth dot_area medthin"' _n
			file write scheme `"linewidth dotmark vthin"' _n
			file write scheme `"linewidth plotregion vthin"' _n
			file write scheme `"linewidth legend none"' _n
			file write scheme `"linewidth clegend none"' _n
			file write scheme `"linewidth pie vthin"' _n
			file write scheme `"linewidth reverse_big thin"' _n
			file write scheme `"linewidth sunflower thin"' _n
			file write scheme `"linewidth matrix_plotregion thin"' _n
			file write scheme `"linewidth text_option none"' _n
			file write scheme `"linewidth zyx2 medium"' _n
			file write scheme `"linewidth pbar vthin"' _n
			
			file write scheme `"connectstyle direct"' _n
			file write scheme `"connectstyle p direct"' _n

			// Settings for color saturation
			file write scheme `"intensity full"' _n
			file write scheme `"intensity foreground full"' _n
			file write scheme `"intensity background full"' _n
			file write scheme `"intensity symbol inten`scatsaturation'"' _n
			file write scheme `"intensity ci_area inten`cisaturation'"' _n
			file write scheme `"intensity histogram inten`histsaturation'"' _n
			file write scheme `"intensity dendrogram inten`linesaturation'"' _n
			file write scheme `"intensity dot_area inten`dotsaturation'"' _n
			file write scheme `"intensity sunflower inten`sunsaturation'"' _n
			file write scheme `"intensity bar inten`barsaturation'"' _n
			file write scheme `"intensity bar_line full"' _n
			file write scheme `"intensity box inten`boxsaturation'"' _n
			file write scheme `"intensity box_line full"' _n
			file write scheme `"intensity pie inten`piesaturation'"' _n
			file write scheme `"intensity legend full"' _n
			file write scheme `"intensity plotregion full"' _n
			file write scheme `"intensity matrix_plotregion inten`matsaturation'"' _n
			file write scheme `"intensity clegend full"' _n
			file write scheme `"intensity clegend_outer full"' _n
			file write scheme `"intensity clegend_inner full"' _n
			file write scheme `"intensity p inten`scatsaturation'"' _n

			file write scheme `"fillpattern pattern10"' _n
			file write scheme `"fillpattern foreground pattern10"' _n
			file write scheme `"fillpattern background pattern10"' _n
			file write scheme `"textboxstyle body"' _n
			file write scheme `"textboxstyle title heading"' _n
			file write scheme `"textboxstyle subtitle subheading"' _n
			file write scheme `"textboxstyle caption body"' _n
			file write scheme `"textboxstyle note body"' _n
			file write scheme `"textboxstyle leg_title heading"' _n
			file write scheme `"textboxstyle leg_subtitle subheading"' _n
			file write scheme `"textboxstyle leg_caption small_body"' _n
			file write scheme `"textboxstyle leg_note small_body"' _n
			file write scheme `"textboxstyle cleg_title clegend"' _n
			file write scheme `"textboxstyle cleg_subtitle subheading"' _n
			file write scheme `"textboxstyle cleg_caption body"' _n
			file write scheme `"textboxstyle cleg_note small_body"' _n
			file write scheme `"textboxstyle t1title subheading"' _n
			file write scheme `"textboxstyle t2title body"' _n
			file write scheme `"textboxstyle b1title subheading"' _n
			file write scheme `"textboxstyle b2title body"' _n
			file write scheme `"textboxstyle r1title subheading"' _n
			file write scheme `"textboxstyle r2title body"' _n
			file write scheme `"textboxstyle l1title subheading"' _n
			file write scheme `"textboxstyle l2title body"' _n
			file write scheme `"textboxstyle heading heading"' _n
			file write scheme `"textboxstyle subheading subheading"' _n
			file write scheme `"textboxstyle body body"' _n
			file write scheme `"textboxstyle text_option text_option"' _n
			file write scheme `"textboxstyle legend_key legend_key"' _n
			file write scheme `"textboxstyle barlabel small_label"' _n
			file write scheme `"textboxstyle axis_title axis_title"' _n
			file write scheme `"textboxstyle matrix_label matrix_label"' _n
			file write scheme `"textboxstyle pielabel small_label"' _n
			file write scheme `"textboxstyle tick tick_label"' _n
			file write scheme `"textboxstyle minortick minortick_label"' _n
			file write scheme `"textboxstyle bigtick tick_biglabel"' _n
			file write scheme `"textboxstyle sts_risktable sts_risktable"' _n
			file write scheme `"textboxstyle label label"' _n
			file write scheme `"textboxstyle ilabel small_label"' _n
			file write scheme `"textboxstyle key_label key_label"' _n
			file write scheme `"textboxstyle small_label small_label"' _n
			file write scheme `"textboxstyle matrix_marklbl matrix_marklbl"' _n
			file write scheme `"textboxstyle star star_label"' _n
			file write scheme `"textboxstyle bytitle bytitle"' _n
			file write scheme `"textboxstyle editor editor"' _n

			file write scheme `"areastyle background"' _n
			file write scheme `"areastyle foreground foreground"' _n
			file write scheme `"areastyle background background"' _n
			file write scheme `"areastyle plotregion plotregion"' _n
			file write scheme `"areastyle inner_plotregion none"' _n
			file write scheme `"areastyle twoway_plotregion plotregion"' _n
			file write scheme `"areastyle twoway_iplotregion none"' _n
			file write scheme `"areastyle bar_plotregion plotregion"' _n
			file write scheme `"areastyle bar_iplotregion none"' _n
			file write scheme `"areastyle hbar_plotregion plotregion"' _n
			file write scheme `"areastyle hbar_iplotregion none"' _n
			file write scheme `"areastyle dot_plotregion plotregion"' _n
			file write scheme `"areastyle dot_iplotregion none"' _n
			file write scheme `"areastyle box_plotregion plotregion"' _n
			file write scheme `"areastyle box_iplotregion none"' _n
			file write scheme `"areastyle hbox_plotregion plotregion"' _n
			file write scheme `"areastyle hbox_iplotregion none"' _n
			file write scheme `"areastyle combine_plotregion none"' _n
			file write scheme `"areastyle combine_iplotregion none"' _n
			file write scheme `"areastyle bygraph_plotregion none"' _n
			file write scheme `"areastyle bygraph_iplotregion none"' _n
			file write scheme `"areastyle matrixgraph_plotregion none"' _n
			file write scheme `"areastyle matrixgraph_iplotregion none"' _n
			file write scheme `"areastyle matrix_plotregion matrix_plotregion"' _n
			file write scheme `"areastyle matrix_iplotregion none"' _n
			file write scheme `"areastyle legend legend"' _n
			file write scheme `"areastyle legend_key_region none"' _n
			file write scheme `"areastyle legend_inkey_region none"' _n
			file write scheme `"areastyle inner_legend none"' _n
			file write scheme `"areastyle clegend clegend_preg"' _n
			file write scheme `"areastyle clegend_preg none"' _n
			file write scheme `"areastyle clegend_inpreg none"' _n
			file write scheme `"areastyle clegend_outer clegend_outer"' _n
			file write scheme `"areastyle clegend_inner clegend_inner"' _n
			file write scheme `"areastyle graph background"' _n
			file write scheme `"areastyle inner_graph none"' _n
			file write scheme `"areastyle bygraph background"' _n
			file write scheme `"areastyle inner_bygraph none"' _n
			file write scheme `"areastyle piegraph background"' _n
			file write scheme `"areastyle piegraph_region plotregion"' _n
			file write scheme `"areastyle inner_pieregion none"' _n
			file write scheme `"areastyle inner_piegraph none"' _n
			file write scheme `"areastyle combinegraph background"' _n
			file write scheme `"areastyle combinegraph_inner none"' _n
			file write scheme `"areastyle matrix_label background"' _n
			file write scheme `"areastyle matrix_ilabel none"' _n
			file write scheme `"areastyle ci ci"' _n
			file write scheme `"areastyle ci2 ci2"' _n
			file write scheme `"areastyle histogram histogram"' _n
			file write scheme `"areastyle dendrogram dendrogram"' _n
			file write scheme `"areastyle dotchart dotchart"' _n
			file write scheme `"areastyle sunflower sunflower"' _n
			file write scheme `"areastyle sunflowerlb sunflowerlb"' _n
			file write scheme `"areastyle sunflowerdb sunflowerdb"' _n

			// Horizontal Text Alignment
			file write scheme `"horizontal center"' _n
			file write scheme `"horizontal heading center"' _n
			file write scheme `"horizontal subheading center"' _n
			file write scheme `"horizontal label center"' _n
			file write scheme `"horizontal key_label left"' _n
			file write scheme `"horizontal body center"' _n
			file write scheme `"horizontal small_body center"' _n
			file write scheme `"horizontal axis_title center"' _n
			file write scheme `"horizontal matrix_label center"' _n
			file write scheme `"horizontal filled center"' _n
			file write scheme `"horizontal text_option center"' _n
			file write scheme `"horizontal editor left"' _n
			file write scheme `"horizontal sts_risk_label default"' _n
			file write scheme `"horizontal sts_risk_title right"' _n

			// Vertical Text Alignment
			file write scheme `"vertical bottom"' _n
			file write scheme `"vertical_text bottom"' _n
			file write scheme `"vertical_text heading bottom"' _n
			file write scheme `"vertical_text subheading bottom"' _n
			file write scheme `"vertical_text label middle"' _n
			file write scheme `"vertical_text key_label middle"' _n
			file write scheme `"vertical_text body bottom"' _n
			file write scheme `"vertical_text small_body bottom"' _n
			file write scheme `"vertical_text axis_title bottom"' _n
			file write scheme `"vertical_text matrix_label middle"' _n
			file write scheme `"vertical_text legend bottom"' _n
			file write scheme `"vertical_text text_option middle"' _n
			file write scheme `"vertical_text filled middle"' _n

			// Orientation
			file write scheme `"tb_orientstyle horizontal"' _n

			// Axis Styling Text Alignment
			file write scheme `"axisstyle horizontal_default"' _n
			file write scheme `"axisstyle horizontal_default horizontal_default"' _n
			file write scheme `"axisstyle vertical_default vertical_default"' _n
			file write scheme `"axisstyle horizontal_nogrid horizontal_nogrid"' _n
			file write scheme `"axisstyle vertical_nogrid vertical_nogrid"' _n
			file write scheme `"axisstyle bar_super horizontal_nogrid"' _n
			file write scheme `"axisstyle dot_super horizontal_nogrid"' _n
			file write scheme `"axisstyle bar_group horizontal_notick"' _n
			file write scheme `"axisstyle dot_group horizontal_notick"' _n
			file write scheme `"axisstyle bar_var horizontal_notick"' _n
			file write scheme `"axisstyle dot_var horizontal_notick"' _n
			file write scheme `"axisstyle bar_scale_horiz horizontal_nogrid"' _n
			file write scheme `"axisstyle bar_scale_vert vertical_nogrid"' _n
			file write scheme `"axisstyle dot_scale_horiz horizontal_nogrid"' _n
			file write scheme `"axisstyle dot_scale_vert vertical_nogrid"' _n
			file write scheme `"axisstyle box_scale_horiz horizontal_nogrid"' _n
			file write scheme `"axisstyle box_scale_vert vertical_nogrid"' _n
			file write scheme `"axisstyle matrix_horiz horizontal_nogrid"' _n
			file write scheme `"axisstyle matrix_vert vertical_nogrid"' _n
			file write scheme `"axisstyle sts_risktable sts_risktable"' _n
			file write scheme `"axisstyle clegend clegend"' _n

			file write scheme `"gridstyle default"' _n
			file write scheme `"gridstyle major major"' _n
			file write scheme `"gridstyle minor major"' _n
			file write scheme `"gridlinestyle default"' _n
			file write scheme `"gridlinestyle default default"' _n
			file write scheme `"tickstyle default"' _n
			file write scheme `"tickstyle default default"' _n
			file write scheme `"tickstyle major major"' _n
			file write scheme `"tickstyle minor minor"' _n
			file write scheme `"tickstyle major_nolabel major_nolabel"' _n
			file write scheme `"tickstyle minor_nolabel minor_nolabel"' _n
			file write scheme `"tickstyle major_notick major_notick"' _n
			file write scheme `"tickstyle minor_notick minor_notick"' _n
			file write scheme `"tickstyle major_notickbig major_notickbig"' _n
			file write scheme `"tickstyle minor_notickbig minor_notickbig"' _n
			file write scheme `"tickstyle sts_risktable sts_risktable"' _n
			file write scheme `"ticksetstyle major_horiz_default"' _n
			file write scheme `"ticksetstyle major_horiz_default major_horiz_default"' _n
			file write scheme `"ticksetstyle major_vert_default major_vert_default"' _n
			file write scheme `"ticksetstyle minor_horiz_default minor_horiz_default"' _n
			file write scheme `"ticksetstyle minor_vert_default minor_vert_default"' _n
			file write scheme `"ticksetstyle major_horiz_withgrid major_horiz_default"' _n
			file write scheme `"ticksetstyle major_vert_withgrid major_vert_withgrid"' _n
			file write scheme `"ticksetstyle major_horiz_nolabel major_horiz_nolabel"' _n
			file write scheme `"ticksetstyle major_vert_nolabel major_vert_nolabel"' _n
			file write scheme `"ticksetstyle minor_horiz_nolabel minor_horiz_nolabel"' _n
			file write scheme `"ticksetstyle minor_vert_nolabel minor_vert_nolabel"' _n
			file write scheme `"ticksetstyle major_horiz_notick major_horiz_notick"' _n
			file write scheme `"ticksetstyle major_vert_notick major_vert_notick"' _n
			file write scheme `"ticksetstyle minor_horiz_notick minor_horiz_notick"' _n
			file write scheme `"ticksetstyle minor_vert_notick minor_vert_notick"' _n
			file write scheme `"ticksetstyle major_horiz_notickbig major_horiz_notickbig"' _n
			file write scheme `"ticksetstyle major_vert_notickbig major_vert_notickbig"' _n
			file write scheme `"ticksetstyle sts_risktable sts_risktable"' _n
			file write scheme `"ticksetstyle major_clegend major_clegend"' _n
			file write scheme `"tickposition axis_tick outside"' _n
			file write scheme `"barlabelpos bar outside"' _n
			file write scheme `"compass2dir east"' _n
			file write scheme `"compass2dir p east"' _n
			file write scheme `"compass2dir key_label west"' _n
			file write scheme `"compass2dir legend_fillpos center"' _n
			file write scheme `"compass2dir legend_key default"' _n
			file write scheme `"compass2dir text_option center"' _n
			file write scheme `"compass2dir graph_aspect center"' _n
			file write scheme `"compass2dir editor east"' _n
			file write scheme `"compass3dir east"' _n
			file write scheme `"compass3dir p east"' _n
			file write scheme `"clockdir 12"' _n
			file write scheme `"clockdir title_position 12"' _n
			file write scheme `"clockdir subtitle_position 12"' _n
			file write scheme `"clockdir caption_position 4"' _n
			file write scheme `"clockdir note_position 7"' _n
			file write scheme `"clockdir legend_position 12"' _n
			file write scheme `"clockdir zyx2legend_position 3"' _n
			file write scheme `"clockdir by_legend_position 12"' _n
			file write scheme `"clockdir ilabel 3"' _n
			file write scheme `"clockdir matrix_marklbl 12"' _n
			file write scheme `"clockdir p 0"' _n
			file write scheme `"clockdir legend_title_position 12"' _n
			file write scheme `"clockdir legend_subtitle_position 12"' _n
			file write scheme `"clockdir legend_caption_position 4"' _n
			file write scheme `"clockdir legend_note_position 7"' _n
			file write scheme `"clockdir clegend_title_position 12"' _n
			file write scheme `"relative_posn zyx2legend_pos right"' _n
			file write scheme `"relative_posn clegend_pos right"' _n
			file write scheme `"relative_posn clegend_axispos right"' _n
			file write scheme `"gridringstyle spacers_ring 11"' _n
			file write scheme `"gridringstyle title_ring 7"' _n
			file write scheme `"gridringstyle subtitle_ring 6"' _n
			file write scheme `"gridringstyle caption_ring 5"' _n
			file write scheme `"gridringstyle note_ring 4"' _n
			file write scheme `"gridringstyle legend_ring 3"' _n
			file write scheme `"gridringstyle zyx2legend_ring 4"' _n
			file write scheme `"gridringstyle clegend_ring 3"' _n
			file write scheme `"gridringstyle by_legend_ring 3"' _n
			file write scheme `"gridringstyle legend_title_ring 7"' _n
			file write scheme `"gridringstyle legend_subtitle_ring 6"' _n
			file write scheme `"gridringstyle legend_caption_ring 5"' _n
			file write scheme `"gridringstyle legend_note_ring 3"' _n
			file write scheme `"gridringstyle clegend_title_ring 7"' _n
			file write scheme `"anglestyle horizontal"' _n
			file write scheme `"anglestyle horizontal_tick horizontal"' _n
			file write scheme `"anglestyle vertical_tick horizontal"' _n
			file write scheme `"anglestyle clegend horizontal"' _n
			file write scheme `"anglestyle p stdarrow"' _n
			file write scheme `"anglestyle parrow stdarrow"' _n
			file write scheme `"anglestyle parrowbarb zero"' _n
			
			file write scheme `"plotregionstyle default"' _n
			file write scheme `"plotregionstyle graph graph"' _n
			file write scheme `"plotregionstyle twoway twoway"' _n
			file write scheme `"plotregionstyle bygraph bygraph"' _n
			file write scheme `"plotregionstyle combinegraph matrixgraph"' _n
			file write scheme `"plotregionstyle combineregion combineregion"' _n
			file write scheme `"plotregionstyle matrixgraph matrixgraph"' _n
			file write scheme `"plotregionstyle bargraph bargraph"' _n
			file write scheme `"plotregionstyle hbargraph hbargraph"' _n
			file write scheme `"plotregionstyle boxgraph boxgraph"' _n
			file write scheme `"plotregionstyle hboxgraph hboxgraph"' _n
			file write scheme `"plotregionstyle piegraph piegraph"' _n
			file write scheme `"plotregionstyle matrix matrix"' _n
			file write scheme `"plotregionstyle matrix_label matrix_label"' _n
			file write scheme `"plotregionstyle legend_key_region legend_key_region"' _n
			file write scheme `"plotregionstyle clegend clegend"' _n
			file write scheme `"graphstyle default"' _n
			file write scheme `"graphstyle default default"' _n
			file write scheme `"graphstyle graph default"' _n
			file write scheme `"graphstyle matrixgraph matrixgraph"' _n
			file write scheme `"bygraphstyle default"' _n
			file write scheme `"bygraphstyle default default"' _n
			file write scheme `"bygraphstyle bygraph default"' _n
			file write scheme `"bygraphstyle combine combine"' _n
			file write scheme `"piegraphstyle default"' _n
			file write scheme `"piegraphstyle piegraph default"' _n
			file write scheme `"legendstyle default"' _n
			file write scheme `"legendstyle default default"' _n
			file write scheme `"legendstyle zyx2 zyx2"' _n
			file write scheme `"clegendstyle default"' _n
			file write scheme `"clegendstyle default default"' _n
			file write scheme `"labelstyle default"' _n
			file write scheme `"labelstyle ilabel ilabel"' _n 
			file write scheme `"labelstyle matrix matrix"' _n 
			file write scheme `"labelstyle editor editor"' _n 
			file write scheme `"labelstyle sunflower default"' _n
			
			file write scheme `"yesno textbox no"' _n
			file write scheme `"yesno text_option no"' _n
			file write scheme `"yesno connect_missings yes"' _n
			file write scheme `"yesno cmissings yes"' _n
			file write scheme `"yesno pcmissings yes"' _n
			file write scheme `"yesno extend_axes_low yes"' _n
			file write scheme `"yesno extend_axes_high yes"' _n
			file write scheme `"yesno extend_axes_full_low yes"' _n
			file write scheme `"yesno extend_axes_full_high yes"' _n
			file write scheme `"yesno draw_major_grid no"' _n
			file write scheme `"yesno draw_minor_grid no"' _n
			file write scheme `"yesno draw_majornl_grid no"' _n
			file write scheme `"yesno draw_minornl_grid no"' _n
			file write scheme `"yesno draw_major_hgrid no"' _n
			file write scheme `"yesno draw_minor_hgrid no"' _n
			file write scheme `"yesno draw_majornl_hgrid no"' _n
			file write scheme `"yesno draw_minornl_hgrid no"' _n
			file write scheme `"yesno draw_major_vgrid yes"' _n
			file write scheme `"yesno draw_minor_vgrid no"' _n
			file write scheme `"yesno draw_majornl_vgrid no"' _n
			file write scheme `"yesno draw_minornl_vgrid no"' _n
			file write scheme `"yesno draw_major_nl_vgrid no"' _n
			file write scheme `"yesno draw_minor_nl_vgrid no"' _n
			file write scheme `"yesno draw_majornl_nl_vgrid no"' _n
			file write scheme `"yesno draw_minornl_nl_vgrid no"' _n
			file write scheme `"yesno draw_major_nl_hgrid no"' _n
			file write scheme `"yesno draw_minor_nl_hgrid no"' _n
			file write scheme `"yesno draw_majornl_nl_hgrid no"' _n
			file write scheme `"yesno draw_minornl_nl_hgrid no"' _n
			file write scheme `"yesno draw_major_nt_vgrid no"' _n
			file write scheme `"yesno draw_minor_nt_vgrid no"' _n
			file write scheme `"yesno draw_majornl_nt_vgrid no"' _n
			file write scheme `"yesno draw_minornl_nt_vgrid no"' _n
			file write scheme `"yesno draw_major_nt_hgrid no"' _n
			file write scheme `"yesno draw_minor_nt_hgrid no"' _n
			file write scheme `"yesno draw_majornl_nt_hgrid no"' _n
			file write scheme `"yesno draw_minornl_nt_hgrid no"' _n
			file write scheme `"yesno draw_major_nlt_vgrid no"' _n
			file write scheme `"yesno draw_minor_nlt_vgrid no"' _n
			file write scheme `"yesno draw_majornl_nlt_vgrid no"' _n
			file write scheme `"yesno draw_minornl_nlt_vgrid no"' _n
			file write scheme `"yesno draw_major_nlt_hgrid no"' _n
			file write scheme `"yesno draw_minor_nlt_hgrid no"' _n
			file write scheme `"yesno draw_majornl_nlt_hgrid no"' _n
			file write scheme `"yesno draw_minornl_nlt_hgrid no"' _n
			file write scheme `"yesno extend_grid_low yes"' _n
			file write scheme `"yesno extend_grid_high yes"' _n
			file write scheme `"yesno extend_minorgrid_low yes"' _n
			file write scheme `"yesno extend_minorgrid_high yes"' _n
			file write scheme `"yesno extend_majorgrid_low yes"' _n
			file write scheme `"yesno extend_majorgrid_high yes"' _n
			file write scheme `"yesno grid_draw_min no"' _n
			file write scheme `"yesno grid_draw_max no"' _n
			file write scheme `"yesno grid_force_nomin no"' _n
			file write scheme `"yesno grid_force_nomax no"' _n
			file write scheme `"yesno xyline_extend_low yes"' _n
			file write scheme `"yesno xyline_extend_high yes"' _n
			file write scheme `"yesno alt_xaxes no"' _n
			file write scheme `"yesno alt_yaxes no"' _n
			file write scheme `"yesno x2axis_ontop yes"' _n
			file write scheme `"yesno y2axis_onright yes"' _n
			file write scheme `"yesno use_labels_on_ticks no"' _n
			file write scheme `"yesno alternate_labels no"' _n
			file write scheme `"yesno swap_bar_scaleaxis no"' _n
			file write scheme `"yesno swap_bar_groupaxis no"' _n
			file write scheme `"yesno swap_dot_scaleaxis no"' _n
			file write scheme `"yesno swap_dot_groupaxis no"' _n
			file write scheme `"yesno swap_box_scaleaxis no"' _n
			file write scheme `"yesno swap_box_groupaxis no"' _n
			file write scheme `"yesno extend_dots yes"' _n
			file write scheme `"yesno bar_reverse_scale no"' _n
			file write scheme `"yesno dot_reverse_scale no"' _n
			file write scheme `"yesno box_reverse_scale no"' _n
			file write scheme `"yesno box_hollow no"' _n
			file write scheme `"yesno box_custom_whiskers no"' _n
			file write scheme `"yesno pie_clockwise yes"' _n
			file write scheme `"yesno by_edgelabel yes"' _n
			file write scheme `"yesno by_alternate_xaxes no"' _n
			file write scheme `"yesno by_alternate_yaxes no"' _n
			file write scheme `"yesno by_skip_xalternate no"' _n
			file write scheme `"yesno by_skip_yalternate no"' _n
			file write scheme `"yesno by_outer_xtitles yes"' _n
			file write scheme `"yesno by_outer_ytitles yes"' _n
			file write scheme `"yesno by_outer_xaxes yes"' _n
			file write scheme `"yesno by_outer_yaxes yes"' _n
			file write scheme `"yesno by_indiv_xaxes no"' _n
			file write scheme `"yesno by_indiv_yaxes no"' _n
			file write scheme `"yesno by_indiv_xtitles no"' _n
			file write scheme `"yesno by_indiv_ytitles no"' _n
			file write scheme `"yesno by_indiv_xlabels yes"' _n
			file write scheme `"yesno by_indiv_ylabels yes"' _n
			file write scheme `"yesno by_indiv_xticks yes"' _n
			file write scheme `"yesno by_indiv_yticks yes"' _n
			file write scheme `"yesno by_indiv_xrescale no"' _n
			file write scheme `"yesno by_indiv_yrescale no"' _n
			file write scheme `"yesno by_indiv_as_whole no"' _n
			file write scheme `"yesno by_shrink_plotregion no"' _n
			file write scheme `"yesno by_shrink_indiv no"' _n
			file write scheme `"yesno mat_label_box yes"' _n
			file write scheme `"yesno mat_label_as_textbox yes"' _n
			file write scheme `"yesno legend_col_first no"' _n
			file write scheme `"yesno legend_text_first no"' _n
			file write scheme `"yesno legend_stacked no"' _n
			file write scheme `"yesno legend_force_keysz no"' _n
			file write scheme `"yesno legend_force_draw no"' _n
			file write scheme `"yesno legend_force_nodraw no"' _n
			file write scheme `"yesno title_span no"' _n
			file write scheme `"yesno subtitle_span no"' _n
			file write scheme `"yesno caption_span no"' _n
			file write scheme `"yesno note_span no"' _n
			file write scheme `"yesno legend_span no"' _n
			file write scheme `"yesno zyx2legend_span no"' _n
			file write scheme `"yesno clegend_title_span yes"' _n
			file write scheme `"yesno adj_xmargins no"' _n
			file write scheme `"yesno adj_ymargins no"' _n
			file write scheme `"yesno plabelboxed no"' _n
			file write scheme `"yesno pboxlabelboxed no"' _n
			file write scheme `"yesno contours_outline no"' _n
			file write scheme `"yesno contours_reversekey no"' _n
			file write scheme `"yesno contours_colorlines no"' _n

			file write scheme `"barstyle default"' _n
			file write scheme `"barstyle default default"' _n
			file write scheme `"barstyle dot dotdefault"' _n
			file write scheme `"barstyle box boxdefault"' _n
			file write scheme `"barlabelstyle bar bar"' _n
			file write scheme `"dottypestyle dot dot"' _n
			file write scheme `"medtypestyle boxplot line"' _n
			file write scheme `"pielabelstyle default none"' _n
			file write scheme `"arrowstyle default editor"' _n
			file write scheme `"arrowstyle editor editor"' _n
			file write scheme `"starstyle default"' _n
			file write scheme `"starstyle default default"' _n
			file write scheme `"above_below star below"' _n
			file write scheme `"zyx2rule contour intensity"' _n
			file write scheme `"zyx2rule contour hue"' _n
			file write scheme `"zyx2style default"' _n
			file write scheme `"zyx2style default default"' _n
			file write scheme `"seriesstyle p1"' _n
			file write scheme `"seriesstyle dendrogram dendrogram"' _n
			file write scheme `"seriesstyle ilabel ilabel"' _n
			file write scheme `"seriesstyle matrix matrix"' _n

			file write scheme `"sunflowerstyle sunflower sunflower"' _n
			
			// Set generic parameters
			forv i = 1/`pcycles' {
			
				// Define generics for contour plots
				file write scheme `"zyx2style p`i' default"' _n
				
				// Define generic shade styles
				file write scheme `"shadestyle p`i' p`i'"' _n
				file write scheme `"shadestyle p`i'area p`i'area"' _n
				file write scheme `"shadestyle p`i'bar p`i'bar"' _n
				file write scheme `"shadestyle p`i'box p`i'box"' _n
				file write scheme `"shadestyle p`i'pie p`i'pie"' _n
			
				// Define generic marker styles
				file write scheme `"markerstyle p`i' p`i'"' _n
				file write scheme `"markerstyle p`i'box p`i'box"' _n
				file write scheme `"markerstyle p`i'dot p`i'dot"' _n
				file write scheme `"markerstyle p`i'arrow p`i'arrow"' _n

				// Generic Series Styles
				file write scheme `"seriesstyle p`i' p`i'"' _n
				file write scheme `"seriesstyle p`i'area p`i'area"' _n
				file write scheme `"seriesstyle p`i'arrow p`i'arrow"' _n
				file write scheme `"seriesstyle p`i'bar p`i'bar"' _n
				file write scheme `"seriesstyle p`i'box p`i'box"' _n
				file write scheme `"seriesstyle p`i'dot p`i'dot"' _n
				file write scheme `"seriesstyle p`i'line p`i'line"' _n

				// Define generic linee styles
				file write scheme `"linestyle p`i' p`i'"' _n
				file write scheme `"linestyle p`i'area p`i'area"' _n
				file write scheme `"linestyle p`i'arrow p`i'arrow"' _n
				file write scheme `"linestyle p`i'arrowline p`i'arrowline"' _n
				file write scheme `"linestyle p`i'bar p`i'bar"' _n
				file write scheme `"linestyle p`i'box p`i'box"' _n
				file write scheme `"linestyle p`i'boxmark p`i'boxmark"' _n
				file write scheme `"linestyle p`i'dotmark p`i'dotmark"' _n
				file write scheme `"linestyle p`i'line p`i'line"' _n
				file write scheme `"linestyle p`i'mark p`i'mark"' _n
				file write scheme `"linestyle p`i'pie p`i'pie"' _n
				file write scheme `"linestyle p`i'other p`i'other"' _n
				file write scheme `"linestyle p`i'sunflowerdark p`i'sunflowerdark"' _n
				file write scheme `"linestyle p`i'sunflowerlight p`i'sunflowerlight"' _n
				
				// Generic Text Box Styles
				file write scheme `"textboxstyle p`i' p`i'"' _n
				file write scheme `"textboxstyle p`i'boxlabel p`i'boxlabel"' _n
				
				// Generic Area Styles
				file write scheme `"areastyle p`i' p`i'"' _n
				file write scheme `"areastyle p`i'area p`i'area"' _n
				file write scheme `"areastyle p`i'bar p`i'bar"' _n
				file write scheme `"areastyle p`i'box p`i'box"' _n
				file write scheme `"areastyle p`i'pie p`i'pie"' _n
				file write scheme `"areastyle p`i'sunflowerdark p`i'sunflowerdark"' _n
				file write scheme `"areastyle p`i'sunflowerlight p`i'sunflowerlight"' _n

				// Generic Label Styles
				file write scheme `"labelstyle p`i' p`i'"' _n
				file write scheme `"labelstyle p`i'box p`i'box"' _n
							
				// Generic Sunflower plot styles
				if `i' == 1 {
					file write scheme `"sunflowerstyle p1 sunflower"' _n
				}
				else {
					file write scheme `"sunflowerstyle p`i' p`i'"' _n
				}
			
			} // End Generic parameters
				
			// Write the Area Graph characteristics for the number of colors chosen
			forv i = 1/`pcycles' {

				// Get area color index value
				loc areaid `: word `i' of `areacolorsseq''
			
				// Get bar color index value
				loc barid `: word `i' of `barcolorsseq''
			
				// Get box plot color index value
				loc boxid `: word `i' of `boxcolorsseq''

				// Get dot plot color index value
				loc dotid `: word `i' of `dotcolorsseq''

				// Get line plot color index value
				loc lineid `: word `i' of `linecolorsseq''

				// Get pie color index value
				loc pieid `: word `i' of `piecolorsseq''

				// Get scatterplot color index value
				loc scatid `: word `i' of `scatcolorsseq''
				
				// Get the area color RGB code
				loc areacolor "`: word `i' of `areargb''"

				// Get the bar color RGB code
				loc barcolor "`: word `i' of `barrgb''"
				
				// Get the box plot color RGB code
				loc boxcolor "`: word `i' of `boxrgb''"

				// Get the dot color RGB code
				loc dotcolor "`: word `i' of `dotrgb''"

				// Get the line color RGB code
				loc linecolor "`: word `i' of `linergb''"
				
				// Get the pie slice color RGB code
				loc piecolor "`: word `i' of `piergb''"

				// Get the scatterplot color RGB code
				loc scatcolor "`: word `i' of `scatrgb''"
				
				// Check debug option
				if "`dbug'" != "" {
				
					di as res `"Color Sequence `i'"' _n						 ///   
					`"Area `i' RGB `areacolor'"' _n							 ///
					`"Bar `i' RGB `barcolor'"' _n							 ///   
					`"Box `i' RGB `boxcolor'"' _n							 ///
					`"Dot `i' RGB `dotcolor'"' _n							 ///   
					`"Line `i' RGB `linecolor'"' _n							 ///
					`"Pie Slice `i' RGB `piecolor'"' _n						 /// 
					`"Scatter `i' RGB `scatcolor'"'

				} // End IF Block for debugging option
				
				/* Connected Plots */
				// Primary connected plot entries
				file write scheme `"color p`i'area "`areacolor'""' _n
				file write scheme `"linewidth p`i'area vvthin"' _n
				file write scheme `"linepattern p`i'area solid"' _n
				file write scheme `"color p`i'arealine "`linecolor'""' _n
				file write scheme `"intensity p`i'area inten`areasaturation'"' _n

				// Define scheme colors for bar graphs
				file write scheme `"color p`i' "`barcolor'""' _n
				file write scheme `"color p`i'bar "`barcolor'""' _n
				file write scheme `"intensity p`i'bar inten`barsaturation'"' _n
				file write scheme `"areatyle p`i'bar p`i'bar"' _n
				file write scheme `"seriesstyle p`i'bar p`i'bar"' _n
				file write scheme `"color p`i'barline black"' _n

				/* Box Plot Styles */
				// Primary box plot entries
				file write scheme `"color p`i'box "`boxcolor'""' _n
				file write scheme `"intensity box inten`boxsaturation'"' _n
				file write scheme `"linewidth p`i'box medthin"' _n
				file write scheme `"linepattern p`i'box solid"' _n
				file write scheme `"color p`i'boxline black"' _n
				file write scheme `"intensity box_line full"' _n
				file write scheme `"symbol p`i'box circle"' _n
				file write scheme `"symbolsize p`i'box medium"' _n
				file write scheme `"linewidth p`i'boxmark vthin"' _n
				file write scheme `"color p`i'boxmarkfill "`scatcolor'""' _n
				file write scheme `"color p`i'boxmarkline	black"' _n
				file write scheme `"gsize p`i'boxlabel vsmall"' _n
				file write scheme `"color p`i'boxlabel black"' _n
				file write scheme `"clockdir p`i'box 0"' _n

				// Composite entries for box plots
				file write scheme `"linestyle p`i'box p`i'box"' _n
				file write scheme `"linestyle p`i'boxmark p`i'boxmark"' _n
				file write scheme `"markerstyle p`i'box p`i'box"' _n
				file write scheme `"seriesstyle p`i'box p`i'box"' _n

				// Custom median and whisker entries
				file write scheme `"medtypestyle boxplot line"' _n
				file write scheme `"yesno custom_whiskers yes"' _n
				file write scheme `"linestyle box_whiskers ci"' _n
				file write scheme `"linestyle box_median refline"' _n
				file write scheme `"markerstyle box_marker p`i'box"' _n
				
				/* Connected Plots */
				// Primary connected plot entries
				file write scheme `"color p`i'line "`linecolor'""' _n
				file write scheme `"yesno pcmissings yes"' _n
				file write scheme `"yesno p`i'cmissings yes"' _n
				file write scheme `"connectstyle p`i' direct"' _n

				// Composite entries for connected plots
				file write scheme `"markerstyle p`i' p`i'"' _n
				file write scheme `"seriesstyle p`i' p`i'"' _n
				file write scheme `"linestyle p`i'connect p`i'"' _n
				file write scheme `"linestyle p`i'mark p`i'line"' _n
				file write scheme `"linewidth p`i' medium"' _n
				file write scheme `"linepattern p`i'line solid"' _n

				/* Connected Plots */
				// Primary connected plot entries
				file write scheme `"color p`i'dotmarkfill "`dotcolor'"' _n
				file write scheme `"linewidth p`i'dotmark vthin"' _n
				file write scheme `"symbol p`i'dot diamond"' _n
				file write scheme `"symbolsize p`i'dot medium"' _n

				// Composite entries for connected plots
				file write scheme `"linestyle p`i'dotmark p`i'dotmark"' _n
				file write scheme `"markerstyle p`i'dot p`i'dot"' _n
				file write scheme `"seriesstyle p`i'dot p`i'dot"' _n

				/* Connected Plots */
				// Primary connected plot entries
				file write scheme `"color p`i'lineplot "`linecolor'""' _n
				file write scheme `"linewidth p`i'lineplot medium"' _n
				file write scheme `"linepattern p`i'lineplot solid"' _n
				file write scheme `"yesno p`i'cmissings yes"' _n
				file write scheme `"connectstyle p`i' direct"' _n

				// Primary entries for scatter plots
				file write scheme `"color p`i'pie "`piecolor'""' _n
				file write scheme `"color p`i'pieline black"' _n
				file write scheme `"intensity pie inten`piesaturation'"' _n
				file write scheme `"areastyle p`i'pie p`i'pie"' _n
				file write scheme `"seriesstyle p`i'pie p`i'pie"' _n
					
				// Primary entries for scatter plots
				file write scheme `"symbol p`i' circle"' _n
				file write scheme `"symbolsize p`i' medium"' _n
				file write scheme `"color p`i'markline black"' _n
				file write scheme `"linewidth p`i'mark vthin"' _n
				file write scheme `"color p`i'markfill "`scatcolor'""' _n
				file write scheme `"color p`i'label black"' _n
				file write scheme `"clockdir p`i' 0"' _n
					
				// Secondary entries for scatter plots
				file write scheme `"color p`i'shade "`scatcolor'""' _n
				file write scheme `"intensity p`i'shade inten`scatsaturation'"' _n
				file write scheme `"linewidth p`i'other vthin"' _n
				file write scheme `"linepattern p`i'other solid"' _n
				file write scheme `"color p`i'otherline "`linecolor'""' _n 

				// Composite entries for scatter plots
				file write scheme `"linestyle p`i'mark p`i'mark"' _n
				file write scheme `"markerstyle p`i' p`i'"' _n
				file write scheme `"labelstyle p`i' p`i'"' _n
				file write scheme `"seriesstyle p`i' p`i'"' _n

			} // End Loop to create scatterplot scheme file entries

		// Close and save the graph scheme file
		file close scheme

		// Create loop to generate all of the returned values
		foreach metachar in `: char _dta[]' {
		
			// Return the characteristics in self names locals
			ret loc `metachar' = `"`: char _dta[`metachar']'"'
			
		} // End Loop to build returned macros
		
	// Return data in memory to user
	restore
		
	// Print reference to console
	di in smcl "For additional information about these color palettes, " _n    
	di "see: http://www.colorbrewer2.org" _n _skip(15) " & " _n				 ///   
	"http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf"
	
// End of Program		
end

