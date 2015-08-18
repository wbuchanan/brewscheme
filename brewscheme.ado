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
*     2677                                                                     *
*                                                                              *
********************************************************************************
		
*! brewscheme
*! v 0.0.3
*! 18AUG2015

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
		REFResh ]

		// Preserve data currently loaded in memory
		preserve
		
			// Check for the metadata dataset
			cap confirm file `"`c(sysdir_personal)'b/brewmeta.dta"'

			// If file doesn't exist
			if _rc != 0 {
			
				// Call brewmeta to build lookup data set
				qui: brewmeta "mdebar", colorid(1)
				
			} // End IF Block to build look up data set
				
			// If the file exists load it
			else {
			
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
			if mi("`barstyle'") & mi("`scatstyle'") & mi("`areastyle'") & 		 ///   
			mi("`linestyle'") & mi("`constyle'") & mi("`boxstyle'") & 			 ///  
			mi("`dotstyle'") & mi("`piestyle'") & mi("`sunstyle'") & 			 ///   
			mi("`histstyle'") & mi("`cistyle'") & mi("`matstyle'") & 			 ///   
			mi("`reflstyle'") & mi("`refmstyle'") & mi("`allstyle'") {
			
				// Print error message to the screen
				di as err "Must include either arguments for the all "			 ///   
				"parameters or use a combination of graph type arguments and "	 ///   
				"some arguments to provide default colors to the other graph types"
				
				// Kill the program
				exit	
				
			} // End IF Block for valid arguments
			
			// If all the graph styles are missing and an all style is specified
			else if mi("`barstyle'") & mi("`scatstyle'") & mi("`areastyle'") & 	 ///   
			mi("`linestyle'") & mi("`boxstyle'") & mi("`dotstyle'") & 			 ///   
			mi("`piestyle'") & mi("`sunstyle'") & mi("`histstyle'") & 			 ///   
			mi("`cistyle'") & mi("`matstyle'") & mi("`reflstyle'") & 			 ///   
			mi("`refmstyle'") & mi("`constyle'") & !mi("`allstyle'")  {

				// Set the style parameters for all graph types to the values in the 
				// all parameters
				if `allcolors' <= ``allstyle'c' {
				
					// Check to see if all style was an available palette
					if `: list allstyle in palettes' != 1 {
					
						// Let user know valid values
						di as err "Styles arguments must be one of: " _n		 ///   
						`"`palettes'"'
						
						// Exit program
						exit
						
					} // End IF Block to check for valid color palette
					
					// Loop over graph types and assign the all styles to them
					foreach stile in "bar" "scat" "area" "line" "box" 			 ///   
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
					di as err `"More colors (`allcolors') than "'				 ///   
					`"available (``allstyle'c') in the palette `allstyle'"'
					
					// Kill the program
					exit
					
				} // End ELSE Block for # colors > available colors
				
			} // End ELSEIF Block for missing graph styles with nonmissing all style
			
			// If missing some arguments make sure some parameters have values
			else if ("`barstyle'" == "" |  "`scatstyle'" == "" |   		    	 ///   
				"`areastyle'" == "" |  "`linestyle'" == "" |  		    		 ///   
				"`boxstyle'" == "" |  "`dotstyle'" == "" |						 ///
				"`piestyle'" == "" |  "`sunstyle'" == "" |   		    		 ///   
				"`histstyle'" == "" |  "`cistyle'" == "" |  		    		 ///   
				"`matstyle'" == "" | "`reflstyle'" == "" |  		   		 	 ///   
				"`refmstyle'" == "" | "`constart'" == "" | "`conend'" == "") & 	 ///   
				"`somestyle'" == "" {
				
				// If missing some graph type styles must include defaults in some
				di as err "Must include arguments for somestyle if missing graph types"
				
				// Kill program
				exit	
				
			} // End ELSEIF Block for missing types w/o some argument
			
			// If missing some graph types and defaults provided
			else if ("`barstyle'" == "" |  "`scatstyle'" == "" |   		   		 ///   
				"`areastyle'" == "" |  "`linestyle'" == "" |  		    		 ///   
				"`dotstyle'" == "" |  "`boxstyle'" == "" |  					 ///
				"`piestyle'" == "" |  "`sunstyle'" == "" |   		    		 ///   
				"`histstyle'" == "" |  "`cistyle'" == "" |  		    		 ///   
				"`matstyle'" == "" | "`reflstyle'" == "" |  		    	 	 ///   
				"`refmstyle'" == "" | "`constyle'" == "") & "`somestyle'" != "" {
				
				// Check to see if all style was an available palette
				if `: list somestyle in palettes' != 1 {
												
					// Let user know valid values
					di as err "Styles arguments must be one of: " _n `"`palettes'"'
					
					// Exit program
					exit
					
				} // End IF Block to check for valid color palette
				
				// Loop over # available colors per graph
				foreach stile in "`grstyles'" {
				
					// If the style is missing and valid # colors for default
					if "``stile'style'" == "" & `somecolors' <= ``somestyle'c' {
					
						// Loop over the individual graph types
						foreach x in "bar" "scat" "area" "line" "box" "dot" 	 ///   
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
						
					} // End IF Block checking # colors available for default
					
					// If more colors specified for default than available
					else if "``stile'style'" == "" & `somecolors' > ``somestyle'c' {
					
						// Print error message to screen
						di as err `"More colors (``stile'colors') than "'		 ///   
						`"available (``stile'style') in the palette "`stile'style""'
						
						// Kill the program
						exit
						
					} // End ELSEIF Block for # colors > available for defaults
					
					// Check for # colors available for specific graph types
					else if "``stile'style'" != "" &							 ///   
						``stile'colors' > ```stile'style'c' {
						
						// Print error message to the screen
						di as err `"More colors (``stile'colors') than "'		 ///   
						`"available (``stile'style') in the palette "`stile'style""'
						
						// Kill the program
						exit
						
					} // End ELSEIF Block for # colors > available for graph types
					
				} // End Loop over # colors for specified styles
				
			} // End ELSE Block for valid parameters
				
			// Check for data set containing the color attributes
			cap confirm file `"`c(sysdir_plus)'/b/brew.dta"'
			
			// If data set doesn't exist or user wants to recreate it
			if _rc != 0 | "`refresh'" != "" {
			
				qui: colorfile
				qui: use `"`c(sysdir_plus)'/b/brew.dta"', clear

			} // End IF Block for checking for brewscheme dataset
			
			// Otherwise load the metadata file
			else {
			
				qui: use `"`c(sysdir_plus)'/b/brew.dta"', clear
				
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
			if !inlist(`barsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
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
			if !inlist(`scatsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `scatsaturation' <= 104 {
				
					// Set the value to the nearest decile in [0, 100]
					loc scatsaturation = round(`scatsaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `scatsaturation' > 104 {
				
					// Set to max valid saturation value
					loc scatsaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For scat other cases 
				else {
				
					// Print message to the results screen
					di "Setting scat graph saturation to 100"
					
					// Set value to full saturation
					loc scatsaturation 100
					
				} // End ELSE Block for scat other values of saturation
				
			} // End IF Block for scatsaturation value validation
			
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
			if !inlist(`linesaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `linesaturation' <= 104 {
				
					// Set the value to the nearest decile in [0, 100]
					loc linesaturation = round(`linesaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `linesaturation' > 104 {
				
					// Set to max valid saturation value
					loc linesaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For line other cases 
				else {
				
					// Print message to the results screen
					di "Setting line graph saturation to 100"
					
					// Set value to full saturation
					loc linesaturation 100
					
				} // End ELSE Block for line other values of saturation
				
			} // End IF Block for linesaturation value validation
			
			// If color intensity is not a valid value
			if !inlist(`consaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
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
			if !inlist(`boxsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
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
			if !inlist(`dotsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
				90, 100, 200) {
				
				// If if invalid value is <= 104
				if `dotsaturation' <= 104 {
				
					// Set the value to the nearest decile in [0, 100]
					loc dotsaturation = round(`dotsaturation', 10)
					
				} // End IF Block testing for saturation <= 104
				
				// If saturation is > 104 
				else if `dotsaturation' > 104 {
				
					// Set to max valid saturation value
					loc dotsaturation 200
					
				} // End of ELSEIF Block for saturation > 104
				
				// For dot other cases 
				else {
				
					// Print message to the results screen
					di "Setting dot plot saturation to 100"
					
					// Set value to full saturation
					loc dotsaturation 100
					
				} // End ELSE Block for dot other values of saturation
				
			} // End IF Block for dotsaturation value validation
			
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
			if !inlist(`sunsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
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
			if !inlist(`cisaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
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
			if !inlist(`matsaturation', 0, 10, 20, 30, 40, 50, 60, 70, 80,  ///   
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
			
			// Write the scheme file to a location on the path
			qui: file open scheme using ///
				`"`c(sysdir_plus)'/s/scheme-`schemename'.scheme"', w replace

			// Set the number of colors based on color parameter

			// Find maximum number of colors to set the recycle parameter
			loc pcycles = max(	`barcolors', `scatcolors', `areacolors',	 ///   
								`linecolors', `boxcolors', `dotcolors', 	 ///   
								`piecolors', `suncolors', `histcolors', 	 ///   
								`cicolors', `matcolors', `reflcolors', 		 ///   
								`refmcolors')
							  
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
			file write scheme `"color ci_area "`: char _dta[`cistyle'1]'" "' _n
			file write scheme `"color ci_symbol "`: char _dta[`cistyle'1]'" "' _n
			file write scheme `"color ci2_line black"' _n
			file write scheme `"color ci2_arealine black"' _n
			file write scheme `"color ci2_area "`: char _dta[`cistyle'2]'" "' _n
			file write scheme `"color ci2_symbol "`: char _dta[`cistyle'2]'" "' _n
			file write scheme `"color pieline black"' _n
			file write scheme `"color matrix white"' _n
			file write scheme `"color matrixmarkline black"' _n
			file write scheme `"color refmarker black"' _n
			file write scheme `"color refmarkline black"' _n
			file write scheme `"color histogram "`: char _dta[`histstyle'1]'" "' _n
			file write scheme `"color histback white"' _n
			file write scheme `"color histogram_line black"' _n
			file write scheme `"color dot_line black"' _n
			file write scheme `"color dot_arealine black"' _n
			file write scheme `"color dot_area "`: char _dta[`dotstyle'1]'" "' _n
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
			file write scheme `"color sunflower "`: char _dta[`sunstyle'1]'""' _n
			file write scheme `"color sunflowerlb black"' _n
			file write scheme `"color sunflowerlf "`: char _dta[`sunstyle'1]'""' _n
			file write scheme `"color sunflowerdb black"' _n
			file write scheme `"color sunflowerdf "`: char _dta[`sunstyle'2]'""' _n
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
			forv i = 1/`areacolors' {

				/* Area Graph Styles */
				loc areacolor : char _dta[`areastyle'`i']
				// loc linecolor : char _dta[`linestyle'`i']
				
				/* Connected Plots */
				// Primary connected plot entries
				file write scheme `"color p`i'area "`areacolor'""' _n
				file write scheme `"linewidth p`i'area vvthin"' _n
				file write scheme `"linepattern p`i'area solid"' _n
				file write scheme `"color p`i'arealine "`areacolor'""' _n
				file write scheme `"intensity p`i'area inten`areasaturation'"' _n

			} // End Area Graphs

			// Write the Bar Graph characteristics for the number of colors chosen
			forv i = 1/`barcolors' {

				// Get the style/color parameters for the specified bar graph
				loc barcolor "`: char _dta[`barstyle'`i']'"

				// Define scheme colors for bar graphs
				file write scheme `"color p`i' "`barcolor'""' _n
				file write scheme `"color p`i'bar "`barcolor'""' _n
				file write scheme `"intensity p`i'bar inten`barsaturation'"' _n
				file write scheme `"areatyle p`i'bar p`i'bar"' _n
				file write scheme `"seriesstyle p`i'bar p`i'bar"' _n
				file write scheme `"color p`i'barline black"' _n

			} // End of Bar Graphs
			
			// Write the Box Plot characteristics for the number of colors chosen
			forv i = 1/`boxcolors' {

				/* Boxplots Styles */
				loc boxcolor "`: char _dta[`boxstyle'`i']'"

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
				// file write scheme `"color p`i'boxmarkfill "`scatcolor'""' _n
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
				
			} // End of Box Plots

			// Write the Connected Line Plot characteristics for the number of colors chosen
			forv i = 1/`scatcolors' {

				/* Connected Line Plot Styles */
				loc concolor : char _dta[`linestyle'`i']

				/* Scatterplots Styles */
				loc scatcolor : char _dta[`scatstyle'`i']

				/* Connected Plots */
				// Primary connected plot entries
				file write scheme `"color p`i'line "`scatcolor'""' _n
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

			} // End Connected Graphs

			// Write the Dot Plot characteristics for the number of colors chosen
			forv i = 1/`dotcolors' {

				/* Connected Line Plot Styles */
				loc dotcolor "`: char _dta[`dotstyle'`i']'"

				/* Connected Plots */
				// Primary connected plot entries
				file write scheme `"color p`i'dotmarkfill "`dotcolor'""' _n
				file write scheme `"linewidth p`i'dotmark vthin"' _n
				file write scheme `"symbol p`i'dot diamond"' _n
				file write scheme `"symbolsize p`i'dot medium"' _n

				// Composite entries for connected plots
				file write scheme `"linestyle p`i'dotmark p`i'dotmark"' _n
				file write scheme `"markerstyle p`i'dot p`i'dot"' _n
				file write scheme `"seriesstyle p`i'dot p`i'dot"' _n

			} // End Connected Graphs

			// Write the Line Graph characteristics for the number of colors chosen
			forv i = 1/`linecolors' {

				/* Connected Line Plot Styles */
				loc linecolor "`: char _dta[`linestyle'`i']'"

				/* Connected Plots */
				// Primary connected plot entries
				file write scheme `"color p`i'lineplot "`linecolor'""' _n
				file write scheme `"linewidth p`i'lineplot medium"' _n
				file write scheme `"linepattern p`i'lineplot solid"' _n
				file write scheme `"yesno p`i'cmissings yes"' _n
				file write scheme `"connectstyle p`i' direct"' _n

			} // End Line Graphs

			// Write the Pie Graph characteristics for the number of colors chosen
			forv i = 1/`piecolors' {

				/* Pie Graph Styles */
				loc piecolor "`: char _dta[`piestyle'`i']'"

				// Primary entries for scatter plots
				file write scheme `"color p`i'pie "`piecolor'""' _n
				file write scheme `"color p`i'pieline black"' _n
				file write scheme `"intensity pie inten`piesaturation'"' _n
				file write scheme `"areastyle p`i'pie p`i'pie"' _n
				file write scheme `"seriesstyle p`i'pie p`i'pie"' _n
					
			} // End Pie Graph
			
			// Write the Scatterplot characteristics for the number of colors chosen
			forv i = 1/`scatcolors' {

				/* Scatterplots Styles */
				loc scatcolor : char _dta[`scatstyle'`i']

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
				file write scheme `"color p`i'otherline "`scatcolor'""' _n 

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
			ret loc `metachar' `: char _dta[`metachar']'
			
		} // End Loop to build returned macros
		
	// Return data in memory to user
	restore
		
	// Print reference to console
	di in smcl "For additional information about these color palettes, " _n    
	di "see: http://www.colorbrewer2.org" _n _skip(15) " & " _n				 ///   
	"http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf"
	
// End of Program		
end

// Declare program
prog def colorfile, rclass

	// Set version
	version 13.1

	// Specify syntax tree
	syntax 
	
	// Create local macros to store palettes based on scale types
	loc qual "accent, dark2, paired, pastel1, pastel2, set1, set2, set3"
	loc seq1 "blues, bugn, bupu, gnbu, greens, greys, oranges, orrd, pubu"
	loc seq2 "pubugn, purd, purples, rdpu, reds, ylgn, ylgnbu, ylorbr, ylorrd"
	loc div "brbg, piyg, prgn, puor, rdbu, rdgy, rdylbu, rdylgn, spectral"
	loc sem1 "carsa, carse, foodsa, foodse, featuresa, featurese, activitiesa, "
	loc sem2 "activitiese, fruita, fruite, veggiesa, veggiese, brandsa, "
	loc sem3 "brandse, drinksa, drinkse"
	loc specials "mdebar, mdepoint, tableau"
	
	// Preserve any data in memory
	preserve
	
		// Clear any data currently in memory
		clear
		
		// Set data set to hold 1 observation per palette
		set obs 1
		
		// Add a README as the sole observation
		qui: g palette = "This file contains metadata for color palettes" 
		
		// Mississippi Department of Education specific colors for bar graphs
		char _dta[mdebar1] "255 0 0"
		char _dta[mdebar2] "255 127 0"
		char _dta[mdebar3] "255 255 0"
		char _dta[mdebar4] "0 128 0"
		char _dta[mdebar5] "0 0 255"
		
		// Mississippi Department of Education specific colors for scatter plots
		char _dta[mdepoint1] "0 0 255"
		char _dta[mdepoint2] "255 127 0"
		char _dta[mdepoint3] "0 128 0"
		
		// Define Qualitative Palettes
		char _dta[qualitative] `"`qual'"'
		
		// Define Divergent Palettes
		char _dta[divergent] `"`div'"'
		
		// Define Sequential/Continuous Palettes
		char _dta[sequential] `"`seq1' `seq2'"'
		
		// Define Semantic Palettes
		char _dta[semantic] `"`sem1' `sem2' `sem3'"'
		
		// Define custom/special Palettes
		char _dta[custom] `"`specials'"'
		
		// Color Brewer Palette - Pastel into Dark/Vivid Colors G, Pu, O, Y, etc...
		char _dta[accent1]"127 201 127"
		char _dta[accent2]"190 174 212"
		char _dta[accent3]"253 192 134"
		char _dta[accent4]"255 255 153"
		char _dta[accent5]"56 108 176"
		char _dta[accent6]"240 2 127"
		char _dta[accent7]"191 91 23"
		char _dta[accent8]"102 102 102"

		// Color Brewer Palette - Light to Dark Blues
		char _dta[blues1]"247 251 255"
		char _dta[blues2]"222 235 247"
		char _dta[blues3]"198 219 239"
		char _dta[blues4]"158 202 225"
		char _dta[blues5]"107 174 214"
		char _dta[blues6]"66 146 198"
		char _dta[blues7]"33 113 181"
		char _dta[blues8]"8 81 156"
		char _dta[blues9]"8 48 107"

		// Color Brewer Palette - Browns to Blue-Greens 
		char _dta[brbg1]"84 48 5"
		char _dta[brbg2]"140 81 10"
		char _dta[brbg3]"191 129 45"
		char _dta[brbg4]"223 194 125"
		char _dta[brbg5]"246 232 195"
		char _dta[brbg6]"245 245 245"
		char _dta[brbg7]"199 234 229"
		char _dta[brbg8]"128 205 193"
		char _dta[brbg9]"53 151 143"
		char _dta[brbg10]"1 102 94"
		char _dta[brbg11]"0 60 48"

		// Color Brewer Palette - Light Blues to Dark Greens
		char _dta[bugn1]"247 252 253"
		char _dta[bugn2]"229 245 249"
		char _dta[bugn3]"204 236 230"
		char _dta[bugn4]"153 216 201"
		char _dta[bugn5]"102 194 164"
		char _dta[bugn6]"65 174 118"
		char _dta[bugn7]"35 139 69"
		char _dta[bugn8]"0 109 44"
		char _dta[bugn9]"0 68 27"

		// Color Brewer Palette - Light Blues to Dark Purples
		char _dta[bupu1]"247 252 253"
		char _dta[bupu2]"224 236 244"
		char _dta[bupu3]"191 211 230"
		char _dta[bupu4]"158 188 218"
		char _dta[bupu5]"140 150 198"
		char _dta[bupu6]"140 107 177"
		char _dta[bupu7]"136 65 157"
		char _dta[bupu8]"129 15 124"
		char _dta[bupu9]"77 0 75"

		// Color Brewer Palette - Vivid Dark Colors G, O, Pu, Pi, Lt Gn, etc...
		char _dta[dark21]"27 158 119"
		char _dta[dark22]"217 95 2"
		char _dta[dark23]"117 112 179"
		char _dta[dark24]"231 41 138"
		char _dta[dark25]"102 166 30"
		char _dta[dark26]"230 171 2"
		char _dta[dark27]"166 118 29"
		char _dta[dark28]"102 102 102"

		// Color Brewer Palette - Green to Blue
		char _dta[gnbu1]"247 252 240"
		char _dta[gnbu2]"224 243 219"
		char _dta[gnbu3]"204 235 197"
		char _dta[gnbu4]"168 221 181"
		char _dta[gnbu5]"123 204 196"
		char _dta[gnbu6]"78 179 211"
		char _dta[gnbu7]"43 140 190"
		char _dta[gnbu8]"8 104 172"
		char _dta[gnbu9]"8 64 129"

		// Color Brewer Palette - Light to Dark Greens
		char _dta[greens1]"247 252 245"
		char _dta[greens2]"229 245 224"
		char _dta[greens3]"199 233 192"
		char _dta[greens4]"161 217 155"
		char _dta[greens5]"116 196 118"
		char _dta[greens6]"65 171 93"
		char _dta[greens7]"35 139 69"
		char _dta[greens8]"0 109 44"
		char _dta[greens9]"0 68 27"

		// Color Brewer Palette - Light to Dark Greys
		char _dta[greys1]"255 255 255"
		char _dta[greys2]"240 240 240"
		char _dta[greys3]"217 217 217"
		char _dta[greys4]"189 189 189"
		char _dta[greys5]"150 150 150"
		char _dta[greys6]"115 115 115"
		char _dta[greys7]"82 82 82"
		char _dta[greys8]"37 37 37"
		char _dta[greys9]"0 0 0"

		// Color Brewer Palette - Light Oranges to Dark Reds
		char _dta[orrd1]"255 247 236"
		char _dta[orrd2]"254 232 200"
		char _dta[orrd3]"253 212 158"
		char _dta[orrd4]"253 187 132"
		char _dta[orrd5]"252 141 89"
		char _dta[orrd6]"239 101 72"
		char _dta[orrd7]"215 48 31"
		char _dta[orrd8]"179 0 0"
		char _dta[orrd9]"127 0 0"

		// Color Brewer Palette - Light to Dark Oranges
		char _dta[oranges1]"255 245 235"
		char _dta[oranges2]"254 230 206"
		char _dta[oranges3]"253 208 162"
		char _dta[oranges4]"253 174 107"
		char _dta[oranges5]"253 141 60"
		char _dta[oranges6]"241 105 19"
		char _dta[oranges7]"217 72 1"
		char _dta[oranges8]"166 54 3"
		char _dta[oranges9]"127 39 4"

		// Color Brewer Palette - Purples to Greens
		char _dta[prgn1]"64 0 75"
		char _dta[prgn2]"118 42 131"
		char _dta[prgn3]"153 112 171"
		char _dta[prgn4]"194 165 207"
		char _dta[prgn5]"231 212 232"
		char _dta[prgn6]"247 247 247"
		char _dta[prgn7]"217 240 211"
		char _dta[prgn8]"166 219 160"
		char _dta[prgn9]"90 174 97"
		char _dta[prgn10]"27 120 55"
		char _dta[prgn11]"0 68 27"

		// Color Brewer Palette - Lt/Dk Sets of B, G, R, O, etc...
		char _dta[paired1]"166 206 227"
		char _dta[paired2]"31 120 180"
		char _dta[paired3]"178 223 138"
		char _dta[paired4]"51 160 44"
		char _dta[paired5]"251 154 153"
		char _dta[paired6]"227 26 28"
		char _dta[paired7]"253 191 111"
		char _dta[paired8]"255 127 0"
		char _dta[paired9]"202 178 214"
		char _dta[paired10]"106 61 154"
		char _dta[paired11]"255 255 153"
		char _dta[paired12]"177 89 40"

		// Color Brewer Palette - Pastels starting with R, B, G, Pu, Or, etc...
		char _dta[pastel11]"251 180 174"
		char _dta[pastel12]"179 205 227"
		char _dta[pastel13]"204 235 197"
		char _dta[pastel14]"222 203 228"
		char _dta[pastel15]"254 217 166"
		char _dta[pastel16]"255 255 204"
		char _dta[pastel17]"229 216 189"
		char _dta[pastel18]"253 218 236"
		char _dta[pastel19]"242 242 242"

		// Color Brewer Palette - Pastels starting with lt Gn, O, P, Pi, etc...
		char _dta[pastel21]"179 226 205"
		char _dta[pastel22]"253 205 172"
		char _dta[pastel23]"203 213 232"
		char _dta[pastel24]"244 202 228"
		char _dta[pastel25]"230 245 201"
		char _dta[pastel26]"255 242 174"
		char _dta[pastel27]"241 226 204"
		char _dta[pastel28]"204 204 204"

		// Color Brewer Palette - Pinks to Yellow Greens
		char _dta[piyg1]"142 1 82"
		char _dta[piyg2]"197 27 125"
		char _dta[piyg3]"222 119 174"
		char _dta[piyg4]"241 182 218"
		char _dta[piyg5]"253 224 239"
		char _dta[piyg6]"247 247 247"
		char _dta[piyg7]"230 245 208"
		char _dta[piyg8]"184 225 134"
		char _dta[piyg9]"127 188 65"
		char _dta[piyg10]"77 146 33"
		char _dta[piyg11]"39 100 25"

		// Color Brewer Palette - Light Purple to Dark Blues
		char _dta[pubu1]"255 247 251"
		char _dta[pubu2]"236 231 242"
		char _dta[pubu3]"208 209 230"
		char _dta[pubu4]"166 189 219"
		char _dta[pubu5]"116 169 207"
		char _dta[pubu6]"54 144 192"
		char _dta[pubu7]"5 112 176"
		char _dta[pubu8]"4 90 141"
		char _dta[pubu9]"2 56 88"

		// Color Brewer Palette - Light Purple to Blue-Green to Dark Green
		char _dta[pubugn1]"255 247 251"
		char _dta[pubugn2]"236 226 240"
		char _dta[pubugn3]"208 209 230"
		char _dta[pubugn4]"166 189 219"
		char _dta[pubugn5]"103 169 207"
		char _dta[pubugn6]"54 144 192"
		char _dta[pubugn7]"2 129 138"
		char _dta[pubugn8]"1 108 89"
		char _dta[pubugn9]"1 70 54"

		// Color Brewer Palette - Purples to Oranges
		char _dta[puor1]"127 59 8"
		char _dta[puor2]"179 88 6"
		char _dta[puor3]"224 130 20"
		char _dta[puor4]"253 184 99"
		char _dta[puor5]"254 224 182"
		char _dta[puor6]"247 247 247"
		char _dta[puor7]"216 218 235"
		char _dta[puor8]"178 171 210"
		char _dta[puor9]"128 115 172"
		char _dta[puor10]"84 39 136"
		char _dta[puor11]"45 0 75"

		// Color Brewer Palette - Light Purples to Dark Red
		char _dta[purd1]"247 244 249"
		char _dta[purd2]"231 225 239"
		char _dta[purd3]"212 185 218"
		char _dta[purd4]"201 148 199"
		char _dta[purd5]"223 101 176"
		char _dta[purd6]"231 41 138"
		char _dta[purd7]"206 18 86"
		char _dta[purd8]"152 0 67"
		char _dta[purd9]"103 0 31"

		// Color Brewer Palette - Light to Dark Purples
		char _dta[purples1]"252 251 253"
		char _dta[purples2]"239 237 245"
		char _dta[purples3]"218 218 235"
		char _dta[purples4]"188 189 220"
		char _dta[purples5]"158 154 200"
		char _dta[purples6]"128 125 186"
		char _dta[purples7]"106 81 163"
		char _dta[purples8]"84 39 143"
		char _dta[purples9]"63 0 125"

		// Color Brewer Palette - Reds to Blues
		char _dta[rdbu1]"103 0 31"
		char _dta[rdbu2]"178 24 43"
		char _dta[rdbu3]"214 96 77"
		char _dta[rdbu4]"244 165 130"
		char _dta[rdbu5]"253 219 199"
		char _dta[rdbu6]"247 247 247"
		char _dta[rdbu7]"209 229 240"
		char _dta[rdbu8]"146 197 222"
		char _dta[rdbu9]"67 147 195"
		char _dta[rdbu10]"33 102 172"
		char _dta[rdbu11]"5 48 97"

		// Color Brewer Palette - Reds to Greys
		char _dta[rdgy1]"103 0 31"
		char _dta[rdgy2]"178 24 43"
		char _dta[rdgy3]"214 96 77"
		char _dta[rdgy4]"244 165 130"
		char _dta[rdgy5]"253 219 199"
		char _dta[rdgy6]"255 255 255"
		char _dta[rdgy7]"224 224 224"
		char _dta[rdgy8]"186 186 186"
		char _dta[rdgy9]"135 135 135"
		char _dta[rdgy10]"77 77 77"
		char _dta[rdgy11]"26 26 26"

		// Color Brewer Palette - Light Reds to Dark Purples
		char _dta[rdpu1]"255 247 243"
		char _dta[rdpu2]"253 224 221"
		char _dta[rdpu3]"252 197 192"
		char _dta[rdpu4]"250 159 181"
		char _dta[rdpu5]"247 104 161"
		char _dta[rdpu6]"221 52 151"
		char _dta[rdpu7]"174 1 126"
		char _dta[rdpu8]"122 1 119"
		char _dta[rdpu9]"73 0 106"

		// Color Brewer Palette - Reds to Yellows to Blues
		char _dta[rdylbu1]"165 0 38"
		char _dta[rdylbu2]"215 48 39"
		char _dta[rdylbu3]"244 109 67"
		char _dta[rdylbu4]"253 174 97"
		char _dta[rdylbu5]"254 224 144"
		char _dta[rdylbu6]"255 255 191"
		char _dta[rdylbu7]"224 243 248"
		char _dta[rdylbu8]"171 217 233"
		char _dta[rdylbu9]"116 173 209"
		char _dta[rdylbu10]"69 117 180"
		char _dta[rdylbu11]"49 54 149"

		// Color Brewer Palette - Reds to Yellows to Greens
		char _dta[rdylgn1]"165 0 38"
		char _dta[rdylgn2]"215 48 39"
		char _dta[rdylgn3]"244 109 67"
		char _dta[rdylgn4]"253 174 97"
		char _dta[rdylgn5]"254 224 139"
		char _dta[rdylgn6]"255 255 191"
		char _dta[rdylgn7]"217 239 139"
		char _dta[rdylgn8]"166 217 106"
		char _dta[rdylgn9]"102 189 99"
		char _dta[rdylgn10]"26 152 80"
		char _dta[rdylgn11]"0 104 55"

		// Color Brewer Palette - Light to Dark Reds
		char _dta[reds1]"255 245 240"
		char _dta[reds2]"254 224 210"
		char _dta[reds3]"252 187 161"
		char _dta[reds4]"252 146 114"
		char _dta[reds5]"251 106 74"
		char _dta[reds6]"239 59 44"
		char _dta[reds7]"203 24 29"
		char _dta[reds8]"165 15 21"
		char _dta[reds9]"103 0 13"

		// Color Brewer Palette - Vivid/High Saturation R, B, G, P, O, etc...
		char _dta[set11]"228 26 28"
		char _dta[set12]"55 126 184"
		char _dta[set13]"77 175 74"
		char _dta[set14]"152 78 163"
		char _dta[set15]"255 127 0"
		char _dta[set16]"255 255 51"
		char _dta[set17]"166 86 40"
		char _dta[set18]"247 129 191"
		char _dta[set19]"153 153 153"

		// Color Brewer Palette - Saturation between sets1 & 3, G, O, B, Pu, etc...
		char _dta[set21]"102 194 165"
		char _dta[set22]"252 141 98"
		char _dta[set23]"141 160 203"
		char _dta[set24]"231 138 195"
		char _dta[set25]"166 216 84"
		char _dta[set26]"255 217 47"
		char _dta[set27]"229 196 148"
		char _dta[set28]"179 179 179"

		// Color Brewer Palette - Pastel Gr, Yl, Pu, Rd, Bu, Or, Lt Gn, etc...
		char _dta[set31]"141 211 199"
		char _dta[set32]"255 255 179"
		char _dta[set33]"190 186 218"
		char _dta[set34]"251 128 114"
		char _dta[set35]"128 177 211"
		char _dta[set36]"253 180 98"
		char _dta[set37]"179 222 105"
		char _dta[set38]"252 205 229"
		char _dta[set39]"217 217 217"
		char _dta[set310]"188 128 189"
		char _dta[set311]"204 235 197"
		char _dta[set312]"255 237 111"

		// Color Brewer Palette - Reds to Oranges to Yellows to Greens to Blues
		char _dta[spectral1]"158 1 66"
		char _dta[spectral2]"213 62 79"
		char _dta[spectral3]"244 109 67"
		char _dta[spectral4]"253 174 97"
		char _dta[spectral5]"254 224 139"
		char _dta[spectral6]"255 255 191"
		char _dta[spectral7]"230 245 152"
		char _dta[spectral8]"171 221 164"
		char _dta[spectral9]"102 194 165"
		char _dta[spectral10]"50 136 189"
		char _dta[spectral11]"94 79 162"

		// Color Brewer Palette - Yellow to Green
		char _dta[ylgn1]"255 255 229"
		char _dta[ylgn2]"247 252 185"
		char _dta[ylgn3]"217 240 163"
		char _dta[ylgn4]"173 221 142"
		char _dta[ylgn5]"120 198 121"
		char _dta[ylgn6]"65 171 93"
		char _dta[ylgn7]"35 132 67"
		char _dta[ylgn8]"0 104 55"
		char _dta[ylgn9]"0 69 41"

		// Color Brewer Palette - Yellow to Green to Blue
		char _dta[ylgnbu1]"255 255 217"
		char _dta[ylgnbu2]"237 248 177"
		char _dta[ylgnbu3]"199 233 180"
		char _dta[ylgnbu4]"127 205 187"
		char _dta[ylgnbu5]"65 182 196"
		char _dta[ylgnbu6]"29 145 192"
		char _dta[ylgnbu7]"34 94 168"
		char _dta[ylgnbu8]"37 52 148"
		char _dta[ylgnbu9]"8 29 88"

		// Color Brewer Palette - Yellows to Oranges to Browns
		char _dta[ylorbr1]"255 255 229"
		char _dta[ylorbr2]"255 247 188"
		char _dta[ylorbr3]"254 227 145"
		char _dta[ylorbr4]"254 196 79"
		char _dta[ylorbr5]"254 153 41"
		char _dta[ylorbr6]"236 112 20"
		char _dta[ylorbr7]"204 76 2"
		char _dta[ylorbr8]"153 52 4"
		char _dta[ylorbr9]"102 37 6"

		// Color Brewer Palette - Yellows to Oranges to Reds
		char _dta[ylorrd1]"255 255 204"
		char _dta[ylorrd2]"255 237 160"
		char _dta[ylorrd3]"254 217 118"
		char _dta[ylorrd4]"254 178 76"
		char _dta[ylorrd5]"253 141 60"
		char _dta[ylorrd6]"252 78 42"
		char _dta[ylorrd7]"227 26 28"
		char _dta[ylorrd8]"177 0 38"
		
		// Tableau Color Palette
		char _dta[tableau1]"31 119 180"
		char _dta[tableau2]"255 127 14"
		char _dta[tableau3]"44 160 44"
		char _dta[tableau4]"214 39 40"
		char _dta[tableau5]"148 103 189"
		char _dta[tableau6]"140 86 75"
		char _dta[tableau7]"227 119 194"
		char _dta[tableau8]"127 127 127"
		char _dta[tableau9]"188 189 34"
		char _dta[tableau10]"23 190 207"
		char _dta[tableau11]"174 119 232"
		char _dta[tableau12]"255 187 120"
		char _dta[tableau13]"152 223 138"
		char _dta[tableau14]"255 152 150"
		char _dta[tableau15]"197 176 213"
		char _dta[tableau16]"196 156 148"
		char _dta[tableau17]"247 182 210"
		char _dta[tableau18]"199 199 199"
		char _dta[tableau19]"219 219 141"
		char _dta[tableau20]"158 218 229"
		
		// Fruits corresponding to fruit palettes
		char _dta[fruits]"Apple, Banana, Blueberry, Cherry, Grape, Peach, Tangerine"
		
		// Fruit expert selected palette
		char _dta[fruite1]"146 195 51"
		char _dta[fruite2]"251 222 6"
		char _dta[fruite3]"64 105 166"
		char _dta[fruite4]"200 0 0"
		char _dta[fruite5]"127 34 147"
		char _dta[fruite6]"251 162 127"
		char _dta[fruite7]"255 86 29"
		
		// Fruit algorithm selected palette
		char _dta[fruita1]"44 160 44"
		char _dta[fruita2]"188 189 34"
		char _dta[fruita3]"31 119 180"
		char _dta[fruita4]"214 39 40"
		char _dta[fruita5]"148 103 189"
		char _dta[fruita6]"255 187 120"
		char _dta[fruita7]"255 127 14"
		
		// Vegetables corresponding to veggies palettes
		char _dta[veggies]"Carrot, Celery, Corn, Eggplant, Mushroom, Olive, Tomato"
		
		// Vegetable algorithm selected
		char _dta[veggiesa1]"255 127 14"
		char _dta[veggiesa2]"44 160 44"
		char _dta[veggiesa3]"188 189 34"
		char _dta[veggiesa4]"148 103 189"
		char _dta[veggiesa5]"140 86 75"
		char _dta[veggiesa6]"152 223 138"
		char _dta[veggiesa7]"214 39 40"
		
		// Vegetable export selected
		char _dta[veggiese1]"255 141 61"
		char _dta[veggiese2]"157 212 105"
		char _dta[veggiese3]"245 208 64"
		char _dta[veggiese4]"104 59 101"
		char _dta[veggiese5]"239 197 143"
		char _dta[veggiese6]"139 129 57"
		char _dta[veggiese7]"255 26 34"
		
		// Brands corresponding to brand palettes
		char _dta[brands]"Apple, AT&T, Home Depot, Kodak, Starbucks, Target, Yahoo!"
		
		// Brands algorithm selected
		char _dta[brandsa1]"152 223 138"
		char _dta[brandsa2]"31 119 180"
		char _dta[brandsa3]"255 127 14"
		char _dta[brandsa4]"140 86 75"
		char _dta[brandsa5]"44 160 44"
		char _dta[brandsa6]"214 39 40"
		char _dta[brandsa7]"148 103 189"
		
		// Brands export selected
		char _dta[brandse1]"161 165 169"
		char _dta[brandse2]"44 163 218"
		char _dta[brandse3]"242 99 33"
		char _dta[brandse4]"255 183 0"
		char _dta[brandse5]"0 112 66"
		char _dta[brandse6]"204 0 0"
		char _dta[brandse7]"123 0 153"
		
		// Drinks corresponding to brand palettes
		char _dta[drinks]"A&W Root Beer, Coca-Cola, Dr. Pepper, Pepsi, Sprite, Sunkist, Welch's Grape"
		
		// Drinks algorithm selected
		char _dta[drinksa1]"140 86 75"
		char _dta[drinksa2]"214 39 40"
		char _dta[drinksa3]"227 119 194"
		char _dta[drinksa4]"31 119 180"
		char _dta[drinksa5]"44 160 44"
		char _dta[drinksa6]"255 127 14"
		char _dta[drinksa7]"148 103 189"
		
		// Drinks export selected
		char _dta[drinkse1]"119 67 6"
		char _dta[drinkse2]"254 0 0"
		char _dta[drinkse3]"151 37 63"
		char _dta[drinkse4]"1 106 171"
		char _dta[drinkse5]"1 159 76"
		char _dta[drinkse6]"254 115 20"
		char _dta[drinkse7]"104 105 169"
		
		// Foods corresponding to brand palettes
		char _dta[food]"Sour Cream, Blue Cheese Dressing, Porterhouse Steak, Iceberg Letuce, Onions (Raw), Potato (Baked), Tomato"
		
		// Foods algorithm selected
		char _dta[fooda1]"31 119 180"
		char _dta[fooda2]"255 127 14"
		char _dta[fooda3]"140 86 75"
		char _dta[fooda4]"44 160 44"
		char _dta[fooda5]"255 187 120"
		char _dta[fooda6]"219 219 141"
		char _dta[fooda7]"214 39 40"
		
		// Foods export selected
		char _dta[foodt1]"199 199 199"
		char _dta[foodt2]"31 119 180"
		char _dta[foodt3]"140 86 75"
		char _dta[foodt4]"152 223 138"
		char _dta[foodt5]"219 219 141"
		char _dta[foodt6]"196 156 148"
		char _dta[foodt7]"214 39 40"
		
		// Car Colors corresponding to brand palettes
		char _dta[cars]"Red, Silver, Black, Green, Brown, Blue"
		
		// Car Colors algorithm selected
		char _dta[carsa1]"214 39 40"
		char _dta[carsa2]"199 199 199"
		char _dta[carsa3]"127 127 127"
		char _dta[carsa4]"44 160 44"
		char _dta[carsa5]"140 86 75"
		char _dta[carsa6]"31 119 180"
		
		// Car Colors export selected
		char _dta[carst1]"214 39 40"
		char _dta[carst2]"199 199 199"
		char _dta[carst3]"127 127 127"
		char _dta[carst4]"44 160 44"
		char _dta[carst5]"140 86 75"
		char _dta[carst6]"31 119 180"
		
		// Features corresponding to brand palettes
		char _dta[features]"Speed, Reliability, Comfort, Safety, Efficiency"
		
		// Features algorithm selected
		char _dta[featuresa1]"214 39 40"
		char _dta[featuresa2]"31 119 180"
		char _dta[featuresa3]"140 86 75"
		char _dta[featuresa4]"255 127 14"
		char _dta[featuresa5]"44 160 44"
		
		// Features export selected
		char _dta[featurest1]"214 39 40"
		char _dta[featurest2]"31 119 180"
		char _dta[featurest3]"174 119 232"
		char _dta[featurest4]"44 160 44"
		char _dta[featurest5]"152 223 138"
		
		// Activities corresponding to brand palettes
		char _dta[activities]"Sleeping, Working, Leisure, Eating, Driving"
		
		// Activities algorithm selected
		char _dta[activitiesa1]"140 86 75"
		char _dta[activitiesa2]"255 127 14"
		char _dta[activitiesa3]"31 119 180"
		char _dta[activitiesa4]"227 119 194"
		char _dta[activitiesa5]"214 39 40"
		
		// Activities export selected
		char _dta[activitiest1]"31 119 180"
		char _dta[activitiest2]"214 39 40"
		char _dta[activitiest3]"152 223 138"
		char _dta[activitiest4]"44 160 44"
		char _dta[activitiest5]"127 127 127"
		

		// Create values returned in macros
		foreach metachar in `: char _dta[]' {
		
			// Return the characteristics in self names locals
			ret loc `metachar' `: char _dta[`metachar']'
			
		} // End Loop to build returned macros
		
		// Add notes with sources to the data set
		note : ColorBrewer palettes from http://www.colorbrewer2.org
		note : Tableau and Semantic color palettes from http://vis.stanford.edu/files/2013-SemanticColor-EuroVis.pdf
		
			
		// Save the file for use by the scheme generation file	
		qui: save `"`c(sysdir_plus)'/b/brew.dta"', replace

	// Bring original data back into memory
	restore
	
// End of program
end

