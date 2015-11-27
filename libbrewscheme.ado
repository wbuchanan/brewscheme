// Drop program if loaded in memory
cap prog drop libbrewscheme

// Define program
prog def libbrewscheme

	// Version for Stata interpreter to use
	version 13.1
	
	// Syntax of the program
	syntax[, DISplay Locpath ]

	// Clear all objects, classes, methods, and functions from Mata's cache
	mata: mata clear
	
	// Run the mata file from the current working directory (programmer's option)
	if `"`locpath'"' != "" qui: do libbrewscheme.mata

	// Run the mata file from the ADO path location
	else qui: do `"`c(sysdir_plus)'l/libbrewscheme.mata"'
	
	// Create libbrewscheme.mlib
	qui: mata: mata mlib create libbrewscheme, replace size(2048)

	// Add the classes, methods, and functions defined in libbrewscheme.mata to 
	// the mata library file
	qui: mata: mata mlib add libbrewscheme cbtype() Protanopia() 			 ///   
	Deuteranopia() Tritanopia() colorblind() translateColor() 				 ///   
	brewNameSearch() brewColorSearch(), complete

	// Prints the current search path for mata functions/libraries to the console
	mata: mata mlib index
	
	// The display option also opens the help file for the program
	if `"`display'"' != ""  help libbrewscheme

// End Program definition	
end

