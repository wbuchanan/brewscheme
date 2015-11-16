********************************************************************************
* Description of the Program -												   *
* This program is used to set theme values for things like backgrounds, point  *
* sizes, font sizes, etc...   The purpose is to allow the end user greater	   *
* flexibility in developing graph themes (e.g., create a ggplot2 theme with   *
* a given set of palettes and also create a theme with a more Tufte inspired  *
* set of background/size parameters). 										   *
*                                                                              *
* Data Requirements -														   *
*     Reads a file containing properties/parameters 	                       *
*						  OR												   *
*	  Allows users to build the property file interactively					   *
*																			   *
* System Requirements -														   *
*     none                                                                     *
*                                                                              *
* Program Output -                                                             *
*     none																	   *
*                                                                              *
* Lines -                                                                      *
*     585                                                                      *
*                                                                              *
********************************************************************************
		
*! brewtheme
*! v 0.0.1
*! 08SEP2015

// Drop the program from memory if loaded
cap prog drop brewtheme

// Define program
prog def brewtheme

	// Set version to interpret under
	version 13.1
	
	// Set syntax tree
	syntax [anything(name=themefile id="Theme File Name")] [,				 ///   
						ABOvebelow(string asis) ANGLESTYle(string asis)		 ///   
						AREASTYle(string asis) ARROWSTYle(string asis)		 ///   
						AXISSTYle(string asis) BARLABELPos(string asis)		 ///   
						BARLABELSTYle(string asis) BARSTYle(string asis)	 ///   
						BYGRAPHSTYle(string asis) CLEGENDSTYle(string asis)	 ///   
						CLOCKdir(string asis) COLor(string asis)			 ///   
						COMPASS2dir(string asis) COMPASS3dir(string asis)	 ///   
						CONNECTSTYle(string asis) DOTTYPESTYle(string asis)	 ///   
						GRAPHSIze(string asis) GRAPHSTYle(string asis)		 ///   
						GRIDLINESTYle(string asis) GRIDRINGSTYle(string asis) ///   
						GRIDSTYle(string asis) GSIZE(string asis) 			 ///   
						HORIZontal(string asis) LABELSTYle(string asis)		 ///   
						LEGENDSTYle(string asis) LINEPATtern(string asis)	 ///   
						LINESTYle(string asis) LINEWidth(string asis)		 ///   
						MARGin(string asis) MEDTYPESTYle(string asis)		 ///   
						NUMSTYle(string asis) NUMTICKS(string asis)			 ///   
						PIEGRAPHSTYle(string asis) PIELABELSTYle(string asis) ///   
						PLOTREGIONSTYle(string asis) RELATIVEPos(string asis) ///   
						RELSIze(string asis) SPECial(string asis)			 ///   
						STARSTYle(string asis) SYMBol(string asis)			 ///   
						SYMBOLSIze(string asis) ORIENTSTYle(string asis)	 ///   
						TEXTBOXSTYle(string asis) TICKPosition(string asis)  ///   
						TICKSTYle(string asis) TICKSETSTYle(string asis)	 ///   
						VERTICAL(string asis) VERTICALText(string asis)		 ///   
						YESNo(string asis) ZYX2Rule(string asis) 			 ///   
						ZYX2STYle(string asis) LOADThemedata ]
						
	// Change how some of the arguments are stored to align with class names
	loc above_below `abovebelow'
	loc numticks_g `numticks'
	loc relative_posn `relativepos'
	loc tb_orientstyle `orientstyle'
	loc vertical_text `verticaltext' 
						
	preserve	
	
		// Build dataset with classes, arguments, and parameter values
		qui: themedata

		// Loop over the class names
		foreach v in `r(classes)' {
		
			// Store arguments in new locals
			loc `v'args `r(``v'args')'
			
			// If the user passed values
			if `"``v''"' != "" {
			
				// Loop over arguments
				forv i = 1:`: word count ``v''' {
				
					// Store argument
					loc indi `: word `i' of ``v'''
				
					loc arg `: word 1 of `indi''
					
					loc val `: word 2 of `indi''
				
					// Check if valid argument
					if `"`: list indivarg in `v'args'"' != "" {
					
						// Replace value with user specified value
						qui: replace value = `"`val'"' if classname == `"`v'"' & argname == `"`arg'"'
					
					} // End IF Block for valid arguments
				
				} // End Loop over arguments
			
			} // End IF Block for user supplied values
					
		} // End Loop over class names
		
	// Check for directory and if not build it	
	// dirfile, p(`"`c(sysdir_personal)'b/theme"') rebuild
	
	// Check for help as first argument
	// if `"`themefile'"' == "help" {
	
	// }

	// For all other cases
	//  else {

		// Write the scheme file to a location on the path
		// qui: file open theme using ///
		// 	`"`c(sysdir_personal)'b/theme/theme-`themefile'.theme"', w replace

	// } // End ELSE Block for non-help argument
	
	
	// Close the open file connection
	// file close theme
	
	restore
		
// End Program Definition	
end

	

prog def themedata, rclass

clear 

qui: do brewthemedata.do

tempfile themedata

qui: levelsof classname if substr(classname, 1, 1) != "*", loc(classes)

ret loc classes `classes'

foreach v of loc classes {

	qui: levelsof argname if classname == `"`v'"', loc(args)
	
	ret loc `v'args `args'
	
}

qui: save `themedata'.dta, replace

clear

ret loc themefile `themedata'.dta

end
	
	
