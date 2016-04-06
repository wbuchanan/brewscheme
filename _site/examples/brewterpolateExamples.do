/* brewterpolate examples */

// Four colors interpolated in RGB color space
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(2)

// Display the returned values
ret li

// Four colors interpolated and returned as web formatted hexadecimal strings
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(3) rcs(web)

// Display the returned values
ret li

// Four colors less saturated colors returned as hex strings with alpha parameters
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(3) rcs(hexa) cm(desaturated)

// Display the returned values
ret li

// Three interpolated colors returned in RGB as a gray scale
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(2) g

// Display the returned values
ret li

// Arbitrariliy brighter version of example above
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(3) g cm(brighter)

// Display the returned values
ret li

/* The use of mata below is primarily for the display/formatting of results but 
would otherwise be completely superfluous. */

// Initalize null matrices to store results for he next three examples
mata: hsb1 = J(6, 3, .)

// Return the inverse of the original results in HSB color space
brewterpolate, sc("197 115 47") ec("5, 37, 249") c(4) rcs("hsb") inv

// Loop over returned results 
forv i = 1/6 {
	
	// Store the results from the command above in a Mata matrix
	mata: hsb1[`i', .] = strtoreal(tokens(st_global("r(terpcolor`i')")))
	
} // End Loop over returned results

// Return the matrices to Stata
mata: st_matrix("hsb1", hsb1)

// Add column names to each of the matrices
mat colnames hsb1 = "Hue" "Saturation" "Brightness"

// Add rownames to each of the matrices
mat rownames hsb1 = "Color 1" "Color 2" "Color 3" "Color 4" "Color 5" "Color 6"

// Print the first result set to the screen 
// RGB input returned in HSB color space
mat li hsb1
