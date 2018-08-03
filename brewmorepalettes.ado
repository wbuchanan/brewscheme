
// Drops the program if already defined
cap prog drop brewmorepalettes

// Defines the program 
prog def brewmorepalettes

	// Version to use for Stata's internal version control
	version 14.1
	
	// Defines calling syntax
	syntax [ anything(name = pals id = "Must specify the palettes to add") ]
	
	// Palette names for the color palettes below
	loc nms grmg budrd12 budrd18 budor12 budor18 bugr14 brbu10 brbu12 bugy8  ///   
	buor8 buor10 buor12 buorr14 rdylbu11 bu10 bu7 cat12 stepseq25 kelly22 kelly7
	
	// If no palettes are specified assume the user wants all the palettes
	if `"`pals'"' == "" loc pals `"`nms'"'
	
	// Test whether or not palette names exist in the names of valid additional
	// palettes
	if `: list pals in nms' == 0 {
	
		// Print error message to screen
		di as err `"The palette(s) `pals' contains invalid arguments."' _n	 ///   
		`"The names of the available palettes are:"' as res `"`nms'"'
		
		// Return error code
		err 198
	
	} // End IF Block to test for valid palettes

	// Defines location where brewscheme user files are stored
	loc brewuser `c(sysdir_personal)'brewuser
	
	// Maximum colors for color palettes below
	loc maxc 16 18 18 18 18 14 12 12 8 12 12 12 14 11 10 10 12 25 20 7

	// pcolor values for the color palettes below
	loc pcolor 16 12 18 12 18 14 10 12 8 8 10 12 14 11 10 7 12 25 20 7

	// Meta data properties for the color palettes below
	loc meta "Diverging" "Diverging" "Diverging" "Diverging" "Diverging" 	 ///   
	"Diverging" "Diverging" "Diverging" "Diverging" "Diverging" "Diverging"  ///   
	"Diverging" "Diverging" "Diverging" "Sequential" "Sequential" 			 ///   
	"Qualitative" "Sequential" "Qualitative" "Qualitative"

	// Links to the file definitions for the color palettes to be added
	loc files "http://geog.uoregon.edu/datagraphics/color/GrMg_16tn.txt"	 ///   
	"http://geog.uoregon.edu/datagraphics/color/BuDRd_12.txt"				 ///   
	"http://geog.uoregon.edu/datagraphics/color/BuDRd_18.txt"				 ///   
	"http://geog.uoregon.edu/datagraphics/color/BuDOr_12.txt"				 ///   
	"http://geog.uoregon.edu/datagraphics/color/BuDOr_18.txt"				 ///   
	"http://geog.uoregon.edu/datagraphics/color/BuGr_14.txt" 				 ///   
	"http://geog.uoregon.edu/datagraphics/color/BrBu_10.txt"				 ///   
	"http://geog.uoregon.edu/datagraphics/color/BrBu_12.txt"				 ///   
	"http://geog.uoregon.edu/datagraphics/color/BuGy_8.txt"					 ///   
	"http://geog.uoregon.edu/datagraphics/color/BuOr_8.txt"					 ///   
	"http://geog.uoregon.edu/datagraphics/color/BuOr_10.txt"				 ///   
	"http://geog.uoregon.edu/datagraphics/color/BuOr_12.txt"				 ///   
	"http://geog.uoregon.edu/datagraphics/color/BuOrR_14.txt"				 ///   
	"http://geog.uoregon.edu/datagraphics/color/RdYlBu_11b.txt"				 ///   
	"http://geog.uoregon.edu/datagraphics/color/Bu_10.txt"					 ///   
	"http://geog.uoregon.edu/datagraphics/color/Bu_7.txt"					 ///   
	"http://geog.uoregon.edu/datagraphics/color/Cat_12.txt"					 ///   
	"http://geog.uoregon.edu/datagraphics/color/StepSeq_25.txt" 			 ///   
	"kelly22.txt"	///   
	"kelly7.txt"
	
	// Define colorblind friendly palettes
	loc cbfriendly kelly22 kelly7

	// Loop over files containing color palettes
	forv i = 1/`: word count `pals'' {
	
		// Store the current palette
		loc thispalette "`: word `i' of `pals''"
		
		// Store the macro position for the other look up macros
		loc idx `: list posof "`thispalette'" in nms'
		
		// Define colorblind friendly lookup value
		if `"`thispalette'"' != "" loc cbfriend `: list thispalette in cbfriendly'

		// Makes the value 0 if the thispalette macro is empty
		else loc cbfriend 0
		
		di as res `"`: word `idx' of `files''"'
		
		// Load data from remote site
		qui: import delimited using `: word `idx' of `files'', clear varn(2) ///   
		delim(" ", collapse) 

		// Create RGB string
		qui: g rgb = strofreal(v12) + " " + strofreal(v13) + " " + strofreal(v14)
		
		// Keep the RGB string
		qui: keep rgb
		
		// Create palette name
		qui: g palette = "`: word `idx' of `nms''"
		
		// Create meta data properties
		qui: g meta = "`: word `idx' of `meta''"
		
		// Maximum number of colors for the palette
		qui: g byte maxcolors = `: word `idx' of `maxc''
		
		// Pcolor value for the palette
		qui: g byte pcolor = `: word `idx' of `pcolor''
		
		// Color ID variable
		qui: g byte colorid = _n
		
		// Sequence ID variable
		qui: g seqid = palette + strofreal(pcolor) + strofreal(colorid)
		
		// Other metadata properties
		foreach v in print photocopy lcd colorblind {
		
			// Generate missing properties
			if `"`v'"' != "colorblind" qui: g byte `v' = .n
			
			// For the Kelly paper palettes set the colorblind friendly field
			else if `cbfriend' == 1 & `"`v'"' == "colorblind" qui: g byte `v' = 1
			
		} // End Loop over properties
		
		// Set display order
		qui: order palette colorblind print photocopy lcd colorid pcolor rgb  ///   
		maxcolors meta
		
		// Save to brewuser directory
		qui: save `"`brewuser'/`: word `idx' of `nms''.dta"', replace
		
		// Add to the extra's file
		brewextra, files(`"`brewuser'/`: word `idx' of `nms''.dta"')
		
	} // End Loop over files
	
// End of program
end

	
