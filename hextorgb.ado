********************************************************************************
* Description of the Program -												   *
* Utility to convert hexadecimal RGB colors to decimal formatted RGB values.   *
*                                                                              *
* System Requirements -														   *
*     none                                                                     *
*                                                                              *
* Lines -                                                                      *
*     165                                                                      *
*                                                                              *
********************************************************************************

*! hextorgb
*! v 0.0.1
*! 08NOV2015

// Drop program if already loaded in memory
cap prog drop hextorgb

// Define program as rclass
prog def hextorgb, rclass

	// Set version to interpret syntax under
	version 12
	
	// Syntax for hex to RGB converter
	syntax, HEXcolor(string asis) 
	
	// Check to see if argument is a variable or not
	cap confirm v `hexcolor'
	
	// If it is a variable
	if _rc == 0 {

		// Create vector of temporary variables
		tempvar tmp v1 v2 v3 v4 v5 v6 red green blue
	
		// Create temp copy of original
		qui: g `tmp' = trim(itrim(subinstr(`hexcolor', `"#"', "", .)))
		
		// Split the string into component parts
		forv i = 1/6 {
		
			// Move each character into a new variable
			qui: g `v`i'' = substr(`tmp', `i', 1)
			
			// Convert the individual hex value to decimal form
			qui: replace `v`i'' =  	cond(`v`i'' == "f", "15", 				 ///   
									cond(`v`i'' == "e", "14",				 ///   
									cond(`v`i'' == "d", "13", 				 ///    
									cond(`v`i'' == "c", "12",				 ///   
									cond(`v`i'' == "b", "11", 				 ///   
									cond(`v`i'' == "a", "10",  `v`i''))))))
				 
			// Recast the value to numeric	 
			qui: destring `v`i'', replace
			
		} // End Loop over the hexadecimal characters

		// Convert the two character hexadecmial values to decimal values
		qui: g `red' = (`v1' * 16^1) + (`v2' * 16^0) 
		qui: g `green' =  (`v3' * 16^1) + (`v4' * 16^0)
		qui: g `blue' =  (`v5' * 16^1) + (`v6' * 16^0)
		
		// Concatenate the three values together and then clean up the other data
		qui: egen rgb = concat(`red' `green' `blue'), p(" ")
		
	} // End IF Block for variable argument
	
	// If argument is not a variable
	else {
	
		// Loop over hex strings
		forv j = 1/`: word count `hexcolor'' {
	
			// Use same process as above
			loc clnstring `: di trim(itrim(subinstr("`: word `j' of `hexcolor''", `"#"', "", .)))'
		
			// Loop to generate individual strings
			forv i = 1/6 {
			
				// Parse the value
				loc v`i' `: di lower(substr("`clnstring'", `i', 1))'
				
				// Substitute decimal value for a
				if `"`v`i''"' == "a" {
					loc v`i' = 10
				}
				
				else if `"`v`i''"' == "b" {
					loc v`i' = 11
				}
				
				else if `"`v`i''"' == "c" {
					loc v`i' = 12
				}
				
				else if `"`v`i''"' == "d" {
					loc v`i' = 13
				}
				
				else if `"`v`i''"' == "e" {
					loc v`i' = 14
				}
				
				else if `"`v`i''"' == "f" {
					loc v`i' = 15
				}
				
				else {
					loc v`i' = `v`i''
				}
					
			} // End Loop to parse the string
	
			// Red component
			loc red = (`v1' * 16^1) + (`v2' * 16^0) 
			
			// Green component
			loc green =  (`v3' * 16^1) + (`v4' * 16^0)
			
			// Blue component
			loc blue =  (`v5' * 16^1) + (`v6' * 16^0)
			
			// Comma delimited RGB values
			loc rgb `red', `green', `blue'
			
			// Stata RGB string
			loc rgbstring "`red' `green' `blue'"
			
			if `j' == 1 {

				// Display values on screen
				di as text _dup(80) `"_"' _n _skip(10) "Red" _skip(7) 		 ///   
				"Green" _skip(5) "Blue" _skip(6) "RGB" _skip(15) 			 ///   
				"RGB String" _skip(17) _n _dup(80) "_" _n 
				
			} // End IF Block for Header Row
			
			// Print a record in the display table
			di as res _skip(10) "`red'"_column(20) "`green'" _column(30) 	 ///   
			"`blue'" _column(40) "`rgb'" _column(58) `""`rgbstring'""' _n 	 ///   
			_continue
		
			// To print Footer
			else if `j' == `: word count `hexcolor'' {

				// Print footer to the screen
				di as text _dup(80) `"_"' _n
				
			} // End ELSEIF Block for footer
			
			// Return local macros
			ret loc red`j' `red'
			ret loc green`j' `green'
			ret loc blue`j' `blue'
			ret loc rgb`j' `rgbstring'
			ret loc rgbcomma`j' `rgb'

		} // End Loop over Hex Color strings	
			
	} // End ELSE Block for string/macro argument

// End of program
end

