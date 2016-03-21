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
*     56                                                                       *
*                                                                              *
********************************************************************************
		
*! libbrewscheme
*! v 1.0.0
*! 21MAR2016

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
	
	// Run the mata file from the current working directory (programmer's option)
	if `"`locpath'"' != "" qui: do libbrewscheme.mata

	// Run the mata file from the ADO path location
	else qui: do `"`c(sysdir_plus)'l/libbrewscheme.mata"'
	
	// Create libbrewscheme.mlib
	qui: mata: mata mlib create libbrewscheme, `replace' `size'

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

