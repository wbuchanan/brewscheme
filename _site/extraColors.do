// Maximum colors for color palettes below
loc maxc 16 18 18 18 18 14 12 12 8 12 12 12 14 11 10 10 12 25

// pcolor values for the color palettes below
loc pcolor 16 12 18 12 18 14 10 12 8 8 10 12 14 11 10 7 12 25

// Palette names for the color palettes below
loc nms "grmag" "budkred" "budkred" "budkor" "budkor" "bugr" "brbu" "brbu" 	 ///   
"blor" "blor" "blor" "blorrd" "modspectral" "ltbudkbu" "ltbudkbu" "paircat"  ///   
"stepped"

// Meta data properties for the color palettes below
loc meta "Diverging" "Diverging" "Diverging" "Diverging" "Diverging" 		 ///   
"Diverging" "Diverging" "Diverging" "Diverging" "Diverging" "Diverging" 	 ///   
"Diverging" "Diverging" "Diverging" "Sequential" "Sequential" "Qualitative"  ///   
"Sequential"

// Links to the file definitions for the color palettes to be added
loc files "http://geog.uoregon.edu/datagraphics/color/GrMg_16tn.txt"		 ///   
"http://geog.uoregon.edu/datagraphics/color/BuDRd_12.txt"					 ///   
"http://geog.uoregon.edu/datagraphics/color/BuDRd_18.txt"					 ///   
"http://geog.uoregon.edu/datagraphics/color/BuDOr_12.txt"					 ///   
"http://geog.uoregon.edu/datagraphics/color/BuDOr_18.txt"					 ///   
"http://geog.uoregon.edu/datagraphics/color/BuGr_14.txt" 					 ///   
"http://geog.uoregon.edu/datagraphics/color/BrBu_10.txt"					 ///   
"http://geog.uoregon.edu/datagraphics/color/BrBu_12.txt"					 ///   
"http://geog.uoregon.edu/datagraphics/color/BuGy_8.txt"						 ///   
"http://geog.uoregon.edu/datagraphics/color/BuOr_8.txt"						 ///   
"http://geog.uoregon.edu/datagraphics/color/BuOr_10.txt"					 ///   
"http://geog.uoregon.edu/datagraphics/color/BuOr_12.txt"					 ///   
"http://geog.uoregon.edu/datagraphics/color/BuOrR_14.txt"					 ///   
"http://geog.uoregon.edu/datagraphics/color/RdYlBu_11b.txt"					 ///   
"http://geog.uoregon.edu/datagraphics/color/Bu_10.txt"						 ///   
"http://geog.uoregon.edu/datagraphics/color/Bu_7.txt"						 ///   
"http://geog.uoregon.edu/datagraphics/color/Cat_12.txt"						 ///   
"http://geog.uoregon.edu/datagraphics/color/StepSeq_25.txt" 

// Loop over files containing color palettes
forv i = 1/`: word count `files'' {

	// Load data from remote site
	qui: import delimited using `: word `i' of `files'', clear varn(2)		 ///   
	delim(" ", collapse) 

	// Create RGB string
	qui: g rgb = strofreal(v12) + " " + strofreal(v13) + " " + strofreal(v14)
	
	// Keep the RGB string
	qui: keep rgb
	
	// Create palette name
	qui: g palette = "`: word `i' of `nms''"
	
	// Create meta data properties
	qui: g meta = "`: word `i' of `meta''"
	
	// Maximum number of colors for the palette
	qui: g maxcolors = `: word `i' of `maxc''
	
	// Pcolor value for the palette
	qui: g pcolor = `: word `i' of `pcolor''
	
	// Color ID variable
	qui: g colorid = _n
	
	// Other metadata properties
	foreach v of print photocopy lcd colorblind {
	
		// Generate missing properties
		qui: g `v' = .n
		
	} // End Loop over properties
	
	// Set display order
	qui: order palette colorblind print photocopy lcd colorid pcolor rgb 	 ///   
	maxcolors meta
	
	// Save to brewuser directory
	qui: save `"`c(sysdir_personal)'brewuser/`: word `i' of `nms''.dta"', replace
	
	// Add to the extra's file
	brewextra, files(`"`c(sysdir_personal)'brewuser/`: word `i' of `nms''.dta"')
	
} // End Loop over files
