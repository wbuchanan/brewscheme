// Launch mata interpreter
mata:

// Clear any mata objects from memory
mata clear

// Define function that will recycle a sequence of a shorter vector until it 
// is the same length as the longer vector
real matrix recycle(real scalar shortVec, real scalar longVec) {

	// An n x 2 matrix with sequences 
	real matrix recycled
	
	// An 1 x m row vector containing the result set as a string
	string matrix sequenceString
	
	// Check to identify which argument is greater in magnitude
	if (shortVec <= longVec) {

		/* Create a n x 1 column vector of the shorter sequence repeated v times 
				where v is the length of the longer vector
		   Create a n x 1 column vector of the longer sequence repeated w times
				where w is the length of the shorter vector
		   Place these vectors in an n x 2 matrix. */
		recycled = (J(longVec, 1, (1::shortVec)), J(shortVec, 1, (1::longVec)))
		
		// Get the string values corresponding to the recycled values and
		// transpose the response into a row vector
		sequenceString = strofreal(recycled[1::longVec, 1])'
		
		// Set the local macro sequence in Stata with the resulting sequence 
		// as a set of space delimited elements 
		st_local("sequence", invtokens(sequenceString))
		
		// Return the values of the column vector in Mat[n, 1] containing the 
		// repeated sequence
		return(recycled[1::longVec, 1])
		
	} // End IF Block for shortVec <= longVec
	
	// If arguments are reversed
	else {
	
		/* Create a n x 1 column vector of the shorter sequence repeated v times 
				where v is the length of the longer vector
		   Create a n x 1 column vector of the longer sequence repeated w times
				where w is the length of the shorter vector
		   Place these vectors in an n x 2 matrix. */
		recycled = (J(shortVec, 1, (1::longVec)), J(longVec, 1, (1::shortVec)))
		
		// Get the string values corresponding to the recycled values and
		// transpose the response into a row vector
		sequenceString = strofreal(recycled[1::shortVec, 1])'
		
		// Set the local macro sequence in Stata with the resulting sequence 
		// as a set of space delimited elements 
		st_local("sequence", invtokens(sequenceString))
		
		// Return the values of the column vector in Mat[n, 1] containing the 
		// repeated sequence
		return(recycled[1::shortVec, 1])
			
	} // End ELSE Block for shortVec > longVec
		
} // End of Mata Function definition


/*
// Define function that will recycle a sequence of a shorter vector until it 
// is the same length as the longer vector
real matrix recycle(real matrix shortVec, real matrix longVec) {

	// An n x 2 matrix with sequences 
	real matrix recycled
	
	// An 1 x m row vector containing the result set as a string
	string matrix sequenceString

	/* Create a n x 1 column vector of the shorter sequence repeated v times 
			where v is the length of the longer vector
	   Create a n x 1 column vector of the longer sequence repeated w times
			where w is the length of the shorter vector
	   Place these vectors in an n x 2 matrix. */
	recycled = (J(rows(longVec), 1, shortVec), J(rows(shortVec), 1, longVec))
	
	// Get the string values corresponding to the recycled values and
	// transpose the response into a row vector
	sequenceString = strofreal(recycled[rows(longVec), 1])'
	
	// Set the local macro sequence in Stata with the resulting sequence 
	// as a set of space delimited elements 
	st_local("sequence", invtokens(sequenceString))
	
	// Return the values of the column vector in Mat[n, 1] containing the 
	// repeated sequence
	return(recycled[rows(longVec), 1])
		
} // End of Mata Function definition
*/

// Save the function 
mata mosave recycle(), dir(`"`c(sysdir_personal)'"') replace

// Creates a mata library
mata mlib create librecycle, dir(`"`c(sysdir_personal)'"') replace

// Leave the Mata interpreter
end 
