********************************************************************************
* Description of the Program -												   *
* This program is used to compute contrast ratios between two RGB values.      *
* In addition to computing the ratio, the program also checks whether or not   *
* the estimated ratio passes the W3C accessibility standards for color         *
* contrast.  While the standard is primarily relevant to text, it can still be *
* useful to consider the ratio when constructing palettes where the goal is to *
* maximize the color contrast across colors used to define groups.             *
*                                                                              *
* Program Output -                                                             *
*     http://webaim.org/resources/contrastchecker/contrastchecker.js           *
* Lines -                                                                      *
*     101                                                                      *
*                                                                              *
********************************************************************************
		
*! brewcontrastratio
*! v 0.0.2
*! 13APR2017

// Drop the program from memory if loaded
cap prog drop brewcontrastratio

// Define a program
prog def brewcontrastratio, rclass

	// Version of Stata that should be used to interpret the code
	version 13.1

	// Defines syntax structure of program
	syntax anything(name=colors id="RGB Strings to Compare") [, DISplay]
	
	// Check the number of arguments passed to the program
	if !inlist(`: word count `colors'', 2, 6) {
	
		// If not 2 (two RGB strings) or 6 (2 RGB colors w/o string delimiters)
		di as err "Can only pass two RGB strings to the program"
		
		// Throw an exception/error
		err 198
		
	} // End IF Block for illegal number of arguments
	
	// If the RGB colors are passed without string delimiters
	else if `: word count `colors'' == 6 {
	
		// Construct the first RGB color string from the first three elements
		loc col1 `: word 1 of `colors''  `: word 2 of `colors''  `: word 3 of `colors'' 
	
		// Construct the second RGB color string from the last three elements
		loc col2 `: word 4 of `colors''  `: word 5 of `colors''  `: word 6 of `colors'' 
		
	} // End ELSEIF Block for cases w/o string delimiters
	
	// Otherwise
	else {
	
		// Get the first RGB color string
		loc col1 `: word 1 of `colors''
		
		// Get the second RGB color string
		loc col2 `: word 2 of `colors''
		
	} // End ELSE Block for color string construction
	
	// Calls function from libbrewscheme to compute the contrast ratio
	qui: mata: brewContrastChecker("`col1'", "`col2'")
	
	// Check display user option
	if `"`display'"' != "" {
	
		di in smcl "{hline 80}{p2colset 8 50 50 8}"							 ///   
				"{p2col:W3C Accessibility Standard}Pass/Fail{p_end}{hline 80}" ///   
		"{p2colset 8 50 50 8}{p2col:Normal Text Level AA}`normaa'{p_end}"	 ///   
		"{p2colset 8 50 50 8}{p2col:Normal Text Level AAA}`normaaa'{p_end}"	 ///   
		"{p2colset 8 50 50 8}{p2col:Large Text Level AA}`bigaa'{p_end}"		 ///   
		"{p2colset 8 50 50 8}{p2col:Large Text Level AAA}`bigaaa'{p_end}{hline 80}"	 ///   
		"{p2colset 8 50 50 8}{p2col: Color 1 - `col1'}Color 2 - `col2'{p_end}" ///   
		"{break}{p 7 8 8}{hi:Contrast Ratio `ratiolab'}{p_end}"	 ///   

	} // End IF Block for display

	// Sets the returned macro for normal sized text and the Level AA standard
	ret loc normaa `normaa'

	// Sets the returned macro for normal sized text and the Level AAA standard
	ret loc normaaa `normaaa'

	// Sets the returned macro for large text and the Level AA standard
	ret loc bigaa `bigaa'

	// Sets the returned macro for large text and the Level AAA standard
	ret loc bigaaa `bigaaa'

	// Sets the returned macro containing the numeric value of the contrast ratio
	ret loc contrastratio = rationum

	// Sets the returned macro for the string contrast ratio
	ret loc contrastratiolab `ratiolab'
	
// End of program definition	
end


	
