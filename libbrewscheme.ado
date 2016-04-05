********************************************************************************
* Description of the Program -												   *
* This program is a utility to compile the libbrewscheme Mata library locally  *
* on the end user's computer.  												   *
*                                                                              *
* Program Output -                                                             *
* 	libbrewscheme.mlib - a Mata library with classes, methods, and functions   * 
*						 used by programs in the brewscheme package.		   *
*                                                                              *
* Lines -                                                                      *
*     75                                                                       *
*                                                                              *
********************************************************************************
		
*! libbrewscheme
*! v 1.0.1
*! 03APR2016

// Drop program if loaded in memory
cap prog drop libbrewscheme

// Define program
prog def libbrewscheme

	// Version for Stata interpreter to use
	version 13.1
	
	// Syntax of the program
	syntax[, DISplay Locpath REPlace SIze(passthru) ]

	// Clear all objects, classes, methods, and functions from Mata's cache
	mata: mata clear
	
	// Find the file location for libbrewscheme
	qui: findfile libbrewscheme.mata

	// Run the mata file from the current working directory (programmer's option)
	if `"`locpath'"' != "" {
	
		// Compile the mata classes/methods/functions
		qui: do libbrewscheme.mata
		
		// Compile in place
		loc dir 
		
	} // End IF Block for local build	
	
	// Run the mata file from the ADO path location
	else {
	
		// Otherwise compile the source that was found with findfile
		qui: do `"`r(fn)'"'
		
		// Specifies where to build the compiled library
		loc dir dir(`"`c(sysdir_plus)'l/"')
	
	} // End ELSE Block
	
	// Create libbrewscheme.mlib
	qui: mata: mata mlib create libbrewscheme, `replace' `size' `dir'

	// Add the classes, methods, and functions defined in libbrewscheme.mata to 
	// the mata library file
	qui: mata: mata mlib add libbrewscheme cbtype() Protanopia() 			 ///   
	Deuteranopia() Tritanopia() colorblind() translateColor() 				 ///   
	brewcolors(), complete

	// Prints the current search path for mata functions/libraries to the console
	qui: mata: mata mlib index
	
	// The display option also opens the help file for the program
	if `"`display'"' != ""  help libbrewscheme

// End Program definition	
end

