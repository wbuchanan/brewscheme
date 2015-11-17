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
*     1534                                                                     *
*                                                                              *
********************************************************************************
		
*! brewscheme
*! v 0.0.12
*! 17NOV2015

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
		REFResh DBug THEMEFile(string asis) ]
		
		// Try closing existing file if it already exists
		cap file close scheme

		// Preserve data currently loaded in memory
		preserve
		
			// Check for directory and if not build it	
			dirfile, p(`"`c(sysdir_personal)'b"') 
			
			// Check for subdirectory used for storing scheme files
			dirfile, p(`"`c(sysdir_plus)'s"')

			// Check for the metadata dataset
			cap confirm new file `"`c(sysdir_personal)'b/brewmeta.dta"'

			// If file doesn't exist
			if inlist(_rc, 0, 603) {
			
				// Call brewmeta to build lookup data set
				qui: brewdb, `refresh'
				
				// Load the lookup table
				qui: use `"`c(sysdir_personal)'b/brewmeta.dta"', clear			
				
			} // End IF Block to build look up data set
			
			// Check for file
			cap confirm new file `"`c(sysdir_personal)'b/brewmeta.dta"'
				
			// If file doesn't exist
			if inlist(_rc, 0, 603) | "`refresh'" != "" {
			
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
			if _rc != 0 | _rc == 603 | "`refresh'" != "" {
			
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
				
				// Create marker for graph type with maximum number of colors
				if ``color'colors' == `pcycles' {
				
					// Set the generic color macro to reference macro w/max colors
					loc gencolor `"``color'rgb'"'
					
				} // End of IF Block to define generic color macro	
			
				// Check for debug option
				if "`dbug'" != "" {
									
					// Print the RGB color string to screen
					di `"``color'rgb'"'
				
				} // End debug option
				
			} // End Loop over number of colors for graph types	
			
			// Line counter
			loc line = 0
				
			// Check for theme file
			if `"`themefile'"' != "" {
			
				// Open the file
				file open theme using										 ///   
					`"`c(sysdir_personal)'b/theme/theme-`themefile'.theme"', r 
				
				// Loop until end of file
				while r(eof) != 1 {
				
					// Increment line counter
					loc line = `line' + 1
					
					// Read line into local macro
					file read theme line`line'
				
				} // End Loop over theme file
				
				// Close the file connection
				file close theme
			
			} // End IF Block for user specified theme file
			
			// If user does not specify a file
			else {
			
				// Check for default file
				cap confirm file											 ///   
					`"`c(sysdir_personal)'b/theme/theme-default.theme"'
			
				// If the default file exists
				if _rc == 0 {
				
					// Load the default file
					file open theme using									 ///   
						`"`c(sysdir_personal)'b/theme/theme-default.theme"', r
			
				} // End IF Block to open a connection to the default theme
				
				// Else
				else {
				
					// Call the brewtheme subroutine to generate the default template
					qui: brewtheme
				
					// Load the default file
					file open theme using									 ///   
						`"`c(sysdir_personal)'b/theme/theme-default.theme"', r
			
				} // End ELSE Block for non-existent theme file
			
				// Loop until end of file
				while r(eof) != 1 {
					
					// Increment line counter
					loc line = `line' + 1
					
					// Read line into local macro
					file read theme line`line'
				
				} // End Loop over theme file
				
				// Close the file connection
				file close theme
						
			} // End ELSE Block for null theme file
			
			
			file write scheme `"*                                    s2color.scheme"' _n
			file write scheme `""' _n
			file write scheme `"* s2 scheme family with a naturally white background (white plotregions and"' _n
			file write scheme `"* lightly colored background) and color foreground (lines, symbols, text, etc)."' _n
			file write scheme `""' _n
			file write scheme `"*  For p[#][stub] scheme references the corresponding style is resolved by"' _n
			file write scheme `"*  searching the scheme ids with the following preference ordering:"' _n
			file write scheme `"*"' _n
			file write scheme `"*                p#stub"' _n
			file write scheme `"*                pstub"' _n
			file write scheme `"*                p#"' _n
			file write scheme `"*                p"' _n
			file write scheme `"*"' _n
			file write scheme `"*  Thus it is possible to control the selected style to great detail, or let it"' _n
			file write scheme `"*  default to common defaults.  In particular -p- or -pstub- without"' _n
			file write scheme `"*  # can be used to designate a common plotting symbol, or back plotting"' _n
			file write scheme `"*  symbol, or for that matter common color or sizes."' _n
			file write scheme `"*"' _n
			file write scheme `"*  "style"s designated "special" are not styles at all, but direct signals to"' _n
			file write scheme `"*  graphs, plots, or other classes and their parsers.  Their contents are"' _n
			file write scheme `"*  specific to the use and may only be understood by the caller."' _n
			file write scheme `""' _n
			file write scheme `"*!  version 1.2.5   16jun2011"' _n(2)
			file write scheme `"sequence 1299"' _n
			file write scheme `"label "`schemename'""' _n(2)
			file write scheme `"* system naturally_white  1"' _n(3)

			// Loop over first 10 lines of theme file
			forv i = 1/10 {
			
				// Write each line to the scheme file
				file write scheme `line`i''
				
			} // End Loop over lines 1-10 of theme file
			
			file write scheme `"numstyle pcycle           `pcycles'"' _n(2)
			
			// Loop over lines 11-16 of the theme file
			forv i = 11/16 {
			
				// Write each line to the scheme file
				file write scheme `line`i''
				
			} // End loop over lines 11-16 of the theme file
			
			file write scheme `"numstyle contours         `pcycles'"' _n(2)
						
			// Loop over lines 17-179 of the theme file
			forv i = 17/179 {
			
				// Write each line to the scheme file
				file write scheme `line`i''
				
			} // End loop over lines 17-179 of the theme file
			
			file write scheme `"color ci_line        black"' _n
			file write scheme `"color ci_arealine    black"' _n
			file write scheme `"color ci_area        "`: word 1 of `areargb''" "' _n
			file write scheme `"color ci_symbol      "`: word 1 of `cirgb''" "' _n
			file write scheme `"color ci2_line       black"' _n
			file write scheme `"color ci2_arealine   black"' _n
			file write scheme `"color ci2_area       "`: word 2 of `areargb''" "' _n
			file write scheme `"color ci2_symbol     "`: word 2 of `cirgb''" "' _n(2)
			
			file write scheme `"color pieline        black"' _n(2)
			
			// Writes line 180 from the theme file
			file write scheme `line180'
			
			// Writes line 181 from the theme file
			file write scheme `line181'
			
			file write scheme `"color refmarker      black"' _n
			file write scheme `"color refmarkline    black"' _n
			file write scheme `"color histogram      "`: word 1 of `histrgb''" "' _n

			// Writes line 182 from the theme file
			file write scheme `line182'
			
			file write scheme `"color histogram_line black"' _n
			file write scheme `"color dot_line       black"' _n
			file write scheme `"color dot_arealine   black"' _n
			file write scheme `"color dot_area       "`: word 1 of `areargb''" "' _n
			file write scheme `"color dotmarkline    black"' _n(2)
			
			file write scheme `"color xyline         black"' _n
			file write scheme `"color refline        black"' _n
			file write scheme `"color dots           black"' _n(2)
			
			// Loop over lines 183-192 of the theme file
			forv i = 183/192 {
			
				// Write each line to the scheme file
				file write scheme `line`i''
				
			} // End loop over lines 183-192 of the theme file
			
			// Check for values for starting/ending contour plots
			if "`constart'" == "" {
				loc constart blue
			} 
			if "`conend'" == "" {
				loc conend orange
			}
			
			file write scheme `"color contour_begin `constart'"' _n
			file write scheme `"color contour_end `conend'"' _n
			file write scheme `"color zyx2 black"' _n(2)
			
			file write scheme `"color sunflower "`: word 1 of `sunrgb''""' _n
			file write scheme `"color sunflowerlb black"' _n
			file write scheme `"color sunflowerlf "`: word 2 of `sunrgb''""' _n
			file write scheme `"color sunflowerdb black"' _n
			file write scheme `"color sunflowerdf "`: word 3 of `sunrgb''""' _n(2)
			
			/* Add generic color loop here */
			forv i = 1/`: word count `gencolor'' {
			
				file write scheme `"color p`i' "`: word `i' of `gencolor''""' _n
			
			} // End Loop for generic colors
			
			file write scheme `""' _n
			
			// Loop over lines 193-331 of the theme file
			forv i = 193/331 {
			
				// Write each line to the scheme file
				file write scheme `line`i''
				
			} // End loop over lines 193-331 of the theme file
			
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
			file write scheme `"markerstyle sunflower sunflower"' _n(2)
			
			// Write generic marker styles
			foreach i in "" "box" "dot" "arrow" {
			
				// Loop over cycle numbers
				forv v = 1/`pcycles' {
				
					// Add entry to scheme file
					file write scheme `"markerstyle p`v'`i'  p`v'`i'"' _n
				
				} // End Loop over cycle number
				
				// Write blank line between each of the types
				file write scheme `""' _n
			
			} // End Loop over marker style generic types

			// Add extra space after p#arrow
			file write scheme `""' _n
			
			// Loop over lines 332-382 of the theme file
			forv i = 332/382 {
			
				// Write each line to the scheme file
				file write scheme `line`i''
				
			} // End loop over lines 332-382 of the theme file
			
			// Shade/fill settings
			file write scheme `"shadestyle foreground"' _n
			file write scheme `"shadestyle background background"' _n
			file write scheme `"shadestyle foreground foreground"' _n(2)
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
			file write scheme `"shadestyle contour_end contour_end"' _n(2)
			file write scheme `"shadestyle p foreground"' _n(2)
			
			// Write generic marker styles
			foreach i in "" "bar" "box" "pie" "area" {
			
				// Loop over cycle numbers
				forv v = 1/`pcycles' {
				
					// Add entry to scheme file
					file write scheme `"shadestyle p`v'`i'  p`v'`i'"' _n
				
				} // End Loop over cycle number
				
				// Spaces between graph types
				if "`i'" != "area" {
				
					// Write blank line between each of the types
					file write scheme `""' _n

				} // End IF Block for other graphtypes
				
				// For area shade styles
				else {
				
					// This line files final area entry
					file write scheme `"* shadestyle p#other  p1"' _n(3)
					
				} // End Else Block for area shade styles
					
			} // End Loop over marker style generic types

			// Loop over lines 383-434 of the theme file
			forv i = 383/434 {
			
				// Write each line to the scheme file
				file write scheme `line`i''
				
			} // End loop over lines 383-434 of the theme file
			
			// Write generic marker styles
			foreach i in "" "bar" "box" "area" "line" "other" "mark" 		 ///   
			"boxmark" "dotmark" "arrow" "arrowline" "sunflowerlight" 		 ///   
			"sunflowerdark" {
			
				// Loop over cycle numbers
				forv v = 1/`pcycles' {

					// Check for sunflower cases
					if !inlist(`"`i'"', "sunflowerlight", "sunflowerdark") {

						// Add entry to scheme file
						file write scheme `"linestyle p`v'`i'  p`v'`i'"' _n
					
					} // End If Block for non sunflower plots
					
					// For the sunflower caes
					else {
					
						// Use the generic line style for the sunflower plots
						file write scheme `"linestyle p`v'`i' p`v'"' _n
					
					} // End ELSE Block for sunflower plots
					
				} // End Loop over cycle number
				
				// Write blank line between each of the types
				file write scheme `""' _n

			} // End Loop over marker style generic types
			
			// Loop over lines 435-495 of the theme file
			forv i = 435/495 {
			
				// Write each line to the scheme file
				file write scheme `line`i''
				
			} // End loop over lines 435-495 of the theme file
			
			// Settings for color saturation
			file write scheme `"intensity            full"' _n
			file write scheme `"intensity foreground inten100"' _n
			file write scheme `"intensity background inten100"' _n(2)
			file write scheme `"intensity symbol     inten`scatsaturation'"' _n
			file write scheme `"intensity ci_area    inten`cisaturation'"' _n
			file write scheme `"intensity histogram  inten`histsaturation'"' _n
			file write scheme `"intensity dendrogram inten`linesaturation'"' _n
			file write scheme `"intensity dot_area   inten`dotsaturation'"' _n
			file write scheme `"intensity sunflower  inten`sunsaturation'"' _n(2)
			file write scheme `"intensity bar        inten`barsaturation'"' _n
			file write scheme `"intensity bar_line   inten`linesaturation'"' _n
			file write scheme `"intensity box        inten`boxsaturation'"' _n
			file write scheme `"intensity box_line   inten`linesaturation'"' _n
			file write scheme `"intensity pie        inten`piesaturation'"' _n(2)
			file write scheme `"intensity legend     inten100"' _n
			file write scheme `"intensity plotregion inten100"' _n
			file write scheme `"intensity matrix_plotregion inten`matsaturation'"' _n(2)
			file write scheme `"intensity clegend       inten100"' _n
			file write scheme `"intensity clegend_outer inten100"' _n
			file write scheme `"intensity clegend_inner inten100"' _n(3)
			file write scheme `"intensity p          inten`scatsaturation'"' _n

			file write scheme `"* intensity p#        inten80"' _n
			file write scheme `"* intensity p#shade   inten80"' _n
			file write scheme `"* intensity p#bar     inten80	   // twoway bar only, graph bar overall"' _n
			file write scheme `"* intensity p#box     inten80	   // unused, overall only, control w/ color"' _n
			file write scheme `"* intensity p#pie     inten80	   // unused, overall only, control w/ color"' _n
			file write scheme `"* intensity p#area    inten80"' _n(3)
			
			file write scheme `"fillpattern pattern10"' _n
			file write scheme `"fillpattern foreground pattern10"' _n
			file write scheme `"fillpattern background pattern10"' _n(3)
			
			// Loop over lines 496-537 of the theme file
			forv i = 496/537 {
			
				// Write each line to the scheme file
				file write scheme `line`i''
				
			} // End loop over lines 496-537 of the theme file
			
			// Write generic marker styles
			foreach i in "" "boxlabel" {
			
				// Loop over cycle numbers
				forv v = 1/`pcycles' {

					// Add entry to scheme file
					file write scheme `"textboxstyle p`v'`i'  p`v'`i'"' _n
					
				} // End Loop over cycle number
				
				// Write blank line between each of the types
				file write scheme `""' _n

			} // End Loop over marker style generic types
			
			file write scheme `"* textboxstyle p15label     xyz"' _n(3)

			// Loop over lines 538-591 of the theme file
			forv i = 538/591 {
			
				// Write each line to the scheme file
				file write scheme `line`i''
				
			} // End loop over lines 538-591 of the theme file
			
			// Write generic marker styles
			foreach i in "" "bar" "box" "pie" "area" "sunflowerlight" 		 ///   
			"sunflowerdark" {
			
				// Loop over cycle numbers
				forv v = 1/`pcycles' {

					// Check for sunflower cases
					if !inlist(`"`i'"', "sunflowerlight", "sunflowerdark") {

						// Add entry to scheme file
						file write scheme `"areastyle p`v'`i'  p`v'`i'"' _n
					
					} // End If Block for non sunflower plots
					
					// For the sunflower caes
					else {
					
						// Use the generic line style for the sunflower plots
						file write scheme `"areastyle p`v'`i' p`v'"' _n
					
					} // End ELSE Block for sunflower plots
					
				} // End Loop over cycle number
				
				// Write blank line between each of the types
				file write scheme `""' _n

			} // End Loop over marker style generic types
			
			// Loop over lines 592-771 of the theme file
			forv i = 592/771 {
			
				// Write each line to the scheme file
				file write scheme `line`i''
				
			} // End loop over lines 592-771 of the theme file
			
			// Write generic marker styles
			foreach i in "" "box" {
			
				// Loop over cycle numbers
				forv v = 1/`pcycles' {

					// Add entry to scheme file
					file write scheme `"labelstyle p`v'`i'  p`v'`i'"' _n
					
				} // End Loop over cycle number
				
				// Write blank line between each of the types
				file write scheme `""' _n

			} // End Loop over marker style generic types
			
			file write scheme `""' _n
			
			// Loop over lines 772-912 of the theme file
			forv i = 772/912 {
			
				// Write each line to the scheme file
				file write scheme `line`i''
				
			} // End loop over lines 772-912 of the theme file
			
			// Loop over color cycles
			forv i = 1/`pcycles' {

				// Add default entry for each color cycle
				file write scheme `"zyx2style p`i' default"' _n
				
			} // End Loop over number of color cycles
			
			file write scheme `"seriesstyle p1"' _n(2)
			
			file write scheme `"seriesstyle dendrogram dendrogram"' _n(2)
			
			file write scheme `"seriesstyle ilabel ilabel"' _n
			file write scheme `"seriesstyle matrix matrix"' _n(2)
			
			// Write generic marker styles
			foreach i in "" "bar" "box" "pie" "area" "line" "dot" "arrow" {
			
				// Loop over cycle numbers
				forv v = 1/`pcycles' {

					// Add entry to scheme file
					file write scheme `"seriesstyle p`v'`i'  p`v'`i'"' _n
										
				} // End Loop over cycle number
				
				// Write blank line between each of the types
				file write scheme `""' _n

			} // End Loop over marker style generic types

			// Loop over lines 913-977 of the theme file
			forv i = 913/977 {
			
				// Write each line from the theme file to the scheme file
				file write scheme `line`i''
				
			} // End Loop over lines 913-977 of the theme file
			
			// Set generic parameters
			forv i = 1/`pcycles' {
										
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
				// file write scheme `"areastyle p`i'bar p`i'bar"' _n
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
				file write scheme `"yesno p`i'cmissings no"' _n
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
	"http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf" _n 		 ///   
	_skip(15) " & " _n "https://github.com/mbostock/d3/wiki/API-Reference" _n
	
// End of Program		
end

