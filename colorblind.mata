/*
Code adopted from:

Wickline, M. (????). Color.Vision.Simulate. version 0.1.  Retrieved from:
http://galacticmilk.com/labs/Color-Vision/Chrome/Color.Vision.Simulate.js
Retrieved on: 24nov2015

Code also references work of:

Meyer, G. W., & Greenberg, D. P. (1988). Color-Defective Vision and Computer Graphics Displays. Computer Graphics and Applications, IEEE 8(5), pp. 28-40.

Smith, V. C., & Pokorny, J. (2005).  Spectral sensitivity of the foveal cone photopigments between 400 and 500nm.  Journal of the Optical Society of America A, 22(10) pp. 2060-2071.

Lindbloom, B. ().  RGB working space information. Retrieved from: 
http://www.brucelindbloom.com.  Retrieved on 24nov2015.

*/

// Change to Mata interpreter/compiler
mata:

// Define a generic class to store color blindness constants and methods
class cbtype {
	
	// Private members
	private:
	
	// Constants used to rescale RGB values for different forms of colorblindness
	real 	scalar 		x, y, m, yint

	// Publicly accessible members
	public:
	
	// Accessor methods for the constants
	real 	scalar 		getConfuseX(), getConfuseY(), getConfuseM(), 
						getConfuseYint()
	
	// Setter methods for the constants
	void 				setConfuseX(), setConfuseY(), setConfuseM(), 
						setConfuseYint()

} // End of base class definition

// Accessor for the x member variable
real scalar cbtype::getConfuseX() {
	
	// Returns the x member variable value
	return(this.x)
	
} // End of Accessor method definition

// Accessor for the y member variable
real scalar cbtype::getConfuseY() {
	
	// Returns the y member variable value
	return(this.y)
	
} // End of Accessor method definition

// Accessor for the slope member variable
real scalar cbtype::getConfuseM() {
	
	// Returns the slope member variable value
	return(this.m)
	
} // End of Accessor method definition

// Accessor for the intercept member variable
real scalar cbtype::getConfuseYint() {
	
	// Returns the intercept member variable value
	return(this.yint)
	
} // End of Accessor method definition

// Method used to set the value of the member variable x
void cbtype::setConfuseX(real scalar xarg) {

	// Set the value of the member variable x to the value passed to the method
	this.x = xarg
	
} // End of Setter method definition

// Method used to set the value of the member variable y
void cbtype::setConfuseY(real scalar yarg) {

	// Set the value of the member variable y to the value passed to the method
	this.y = yarg
	
} // End of Setter method definition

// Method used to set the value of the slope member variable 
void cbtype::setConfuseM(real scalar slope) {

	// Set the value of the member variable slope to the value passed to the method
	this.m = slope
	
} // End of Setter method definition

// Method used to set the value of the intercept member variable 
void cbtype::setConfuseYint(real scalar intercept) {

	// Set the value of the member variable intercept to the value passed to the method
	this.yint = intercept
	
} // End of Setter method definition

/* Class for Protanopia (Red Colorblindness) inherits from cbtype;
the constructor will set the values of the parent class and will implement
the getter methods to retrieve those values. */
class Protanopia extends cbtype {
	
	// Public Methods
	public:
	
	// Defines the constructor method
	void new()
	
} // End of class definition for Protanopia

// Protanopia class constructor method
void Protanopia::new() {

	// Sets the x member variable's value
	super.setConfuseX(0.7465)
	
	// Sets the y member variable's value
	super.setConfuseY(0.2535)
	
	// Sets the slope member variable's value
	super.setConfuseM(1.273463)
	
	// Sets the intercept variable's value
	super.setConfuseYint(-0.073894)
	
} // End of constructor method for red-colorblindness class

/* Class for Dueteranopia (Green Colorblindness) inherits from cbtype;
the constructor will set the values of the parent class and will implement
the getter methods to retrieve those values. */
class Deuteranopia extends cbtype {
	
	// Public Methods
	public:
	
	// Defines the constructor method
	void new()
	
} // End of class definition for Dueteranopia

// Deuteranopia class constructor method
void Deuteranopia::new() {

	// Sets the x member variable's value
	super.setConfuseX(1.4)
	
	// Sets the y member variable's value
	super.setConfuseY(-0.4) 
	
	// Sets the slope member variable's value
	super.setConfuseM(0.968437) 
	
	// Sets the intercept variable's value
	super.setConfuseYint(0.003331)
	
} // End of constructor method for green-colorblindness class

/* Class for Tritanopia (Blue Colorblindness) inherits from cbtype;
the constructor will set the values of the parent class and will implement
the getter methods to retrieve those values. */
class Tritanopia extends cbtype {
	
	// Public Methods
	public:
	
	// Defines the constructor method
	void new()
	
} // End of class definition for Tritanopia

// Tritanopia class constructor method
void Tritanopia::new() {

	// Sets the x member variable's value
	super.setConfuseX(0.1748) 
	
	// Sets the y member variable's value
	super.setConfuseY(0.0) 
	
	// Sets the slope member variable's value
	super.setConfuseM(0.062921) 
	
	// Sets the intercept variable's value
	super.setConfuseYint(0.292119)
	
} // End of constructor method for blue-colorblindness class

// Class that implements transformations of RGB values and returns values that 
// simulate various types of colorblindness.
class colorblind {

	// Private member variables
	private:
	
	// A row vector with the types of colorblindness
	string 					rowvector 	types
	
	// The initial RGB values, amount parameter, gamma correction parameter, and
	// inverse gamma correction parameter
	real 					scalar 		inputR, inputG, inputB, amount, gamma,
										invgamma
	
	// Member variable that stores the transformed RGB values
	real 					matrix 		transformedRGB
	
	// Class with constants defined for Red color blindness transformations
	class	Protanopia		scalar		protanope
	
	// Class with constants defined for Green color blindness transformations
	class	Deuteranopia	scalar		deuteranope
	
	// Class with constants defined for Blue color blindness transformations
	class	Tritanopia		scalar		tritanope
	
	// Public member variables
	public:
	
	// Setter methods, class constructor, and simulation method
	void 								new(), achromatope(), protanope(), 
										deuteranope(), tritanope(), setR(), 
										setG(), setB(), setAmount(), setRGB(), 
										simulate()

	// Getter methods for member variables/returning results to users
	real 					scalar 		getR(), getG(), getB(), getGamma(), 
										getInvGamma(), getConfuseX(), 
										getConfuseY(), getConfuseM(), 
										getConfuseYint(), getAmount(), condMax()
										
	// Method to return the string names of the available types									
	string					rowvector	getTypes()
	
	// Returns the name of a single type of color blindness
	string					scalar		getType()
	
	// Returns a matrix with the transformed RGB values
	real					matrix		getTransformedRgbs()

	// Methods that return a single row of numeric data
	real					rowvector	getTransformedRgb(), checkRange()

	// Method used to return the string representation of the transformed RGB 
	string					scalar		getRgbString()
	
	// Method used to return the string representation of all transformed RGB values
	string					colvector	getRgbStrings()
	
	// Member variables used to store data transformed throughout the simulation 
	// method call
	real					matrix		drgb1, drgb2, drgb3, drgb4, drgb5, 
										powrgb, xyz, chroma, sim, diffrgb, 
										fitrgb, trnsconstants

} // End of Class definition

// Class constructor method
void colorblind::new() {

	// Initialize the color blindness class objects
	this.protanope = Protanopia()
	this.deuteranope = Deuteranopia()
	this.tritanope = Tritanopia()
	
	// Initialize the matrix used to store the transformation results
	this.transformedRGB = J(4, 3, .)
	
	// Store the types of colorblindness
	this.types = ("achromatope", "protanope", "deuteranope", "tritanope")

	// Store prototype values for amount, gamma, and inverse gamma parameters
	this.amount = 1
	this.gamma = 2.2
	this.invgamma = 1/2.2
	
	// Initialize null matrices used to store data created in the simulation method
	this.drgb1 = J(4, 3, .)
	this.powrgb = J(4, 3, .)
	this.xyz = J(4, 3, .)
	this.chroma = J(4, 2, .)
	this.sim = J(4, 8, .)
	this.diffrgb = J(4, 5, .)
	this.drgb2 = J(4, 3, .)
	this.drgb3 = J(4, 4, .)
	this.drgb4 = J(4, 3, .)
	this.drgb5 = J(4, 3, .)
	this.fitrgb = J(4, 3, .)
	this.trnsconstants = J(4, 4, .)
	
} // End Colorblind class constructor definition

// Method to set the amount member variable
void colorblind::setAmount(real scalar amt) {

	// Changes the default amount parameter value to the value passed to the method
	this.amount = amt

} // End of Setter method

// Sets the Initial value of the red channel
void colorblind::setR(real scalar red) {

	// Sets the inputR member variable to the value passed to the method
	this.inputR = red

} // End of Setter method

// Sets the Initial value of the green channel
void colorblind::setG(real scalar green) {

	// Sets the inputG member variable to the value passed to the method
	this.inputG = green

} // End of Setter method

// Sets the Initial value of the blue channel
void colorblind::setB(real scalar blue) {

	// Sets the inputB member variable to the value passed to the method
	this.inputB = blue

} // End of Setter method

// Sets the Initial values for the red, green, and blue channels
void colorblind::setRGB(real scalar red, real scalar green, real scalar blue) {

	// Set the red channel
	setR(red)
	
	// Set the green channel
	setG(green)
	
	// Set the blue channel
	setB(blue)
	
} // End of Setter method declaration

// Gets the red channel parameter value
real scalar colorblind::getR() {

	// Returns the user specified red channel value
	return(this.inputR)
	
} // End Accessor method declaration for red channel input

// Gets the green channel parameter value
real scalar colorblind::getG() {

	// Returns the user specified green channel value
	return(this.inputG)
	
} // End Accessor method declaration for green channel input

// Gets the blue channel parameter value
real scalar colorblind::getB() {

	// Returns the user specified blue channel value
	return(this.inputB)
	
} // End Accessor method declaration for blue channel input

// Gets the gamma correction parameter value
real scalar colorblind::getGamma() {

	// Returns the gamma correction parameter value
	return(this.gamma)
	
} // End Accessor method declaration for gamma correction parameter

// Gets the inverse gamma correction parameter value
real scalar colorblind::getInvGamma() {

	// Returns the inverse gamma correction parameter value
	return(this.invgamma)
	
} // End Accessor method declaration for inverse gamma correction parameter

// Gets the color blind types member variable
string rowvector colorblind::getTypes() {
	
	// Returns the names of all of the color blindness types
	return(this.types)
	
} // End Accessor method declaration for color blindness types

// Gets a specific type of color blindness 
string scalar colorblind::getType(real scalar typ) {
	
	// Returns the name of specified color blindness type
	return(this.types[1, typ])
	
} // End Accessor method declaration for individual color blindness type

// Gets the transformed RGB values for all available transformations requested
real matrix colorblind::getTransformedRgbs() {

	// Returns the matrix containing all transformed values
	return(this.transformedRGB)
	
} // End Accessor method declaration for 

// Gets a specific transformed RGB value
real rowvector colorblind::getTransformedRgb(real scalar type) {

	// Returns the RGB values for a specified transformation
	return(this.transformedRGB[type, .])
	
} // End Accessor method declaration for single transformed RGB value

// Method to return a column vector of transformed RGB values
string colvector colorblind::getRgbStrings() {

	// Declares column vector variable to use to build the return value
	string colvector x
	
	// Declares variable to use for looping over elements in the transformed matrix
	real scalar i
	
	// Initializes the column vector with null strings
	x = J(rows(getTransformedRgbs()), 1, "")
	
	// Loop over the rows of the matrix with the transformed results
	for(i = 1; i <= rows(getTransformedRgbs()); i++) {
	
		// Populate each element of the column vector with the numeric values 
		// appended into a single string value
		x[i, 1] =  strofreal(this.transformedRGB[i, 1]) + " " +				 ///   
			       strofreal(this.transformedRGB[i, 2])	+ " " +				 ///   
				   strofreal(this.transformedRGB[i, 3])
		
		// Set Stata locals with return values
		st_local(getType(i), x[i, 1])
		
	} // End Loop over rows of the transformed matrix
	
	// Return the string column vector
	return(x)
	
} // End of getter method
	
// Getter method used to retrieve a single RGB string for the specified transform
string scalar colorblind::getRgbString(real scalar type) {

	// String local variable used to store the retrieved RGB value for return
	string scalar x
	
	// Populate each element of the column vector with the numeric values 
	// appended into a single string value
	x = strofreal(this.transformedRGB[type, 1])  	+ " " +					 ///   
		strofreal(this.transformedRGB[type, 2])		+ " " +					 ///   
		strofreal(this.transformedRGB[type, 3])
		
	// Set return value in Stata
	st_local(getType(type), x)

	// Return the RGB string
	return(x)
	
} // End of getter method
	
// Getter method used to access the amount member variable
real scalar colorblind::getAmount() {

	// Returns the current value of the amount member variable for the object
	return(this.amount)
	
} // End of getter method

// Getter method used to access the x member variable of the IDd colorblind object
real scalar colorblind::getConfuseX(real scalar type) {
	
	// If value passed to method is 2
	if (type == 2) {
		
		// Return the constant for Protanopia transformation
		return(this.protanope.getConfuseX())
		
	} // End IF Block for Protanopia
	
	// If value 3 is passed
	else if (type == 3) {
	
		// Return the constant for Deuteranopia transformation
		return(this.deuteranope.getConfuseX())
		
	} // End ELSEIF Block for Deuteranopia
	
	// Otherwise
	else {
	
		// Return the constant for Tritanopia transformation
		return(this.tritanope.getConfuseX())
		
	} // End ELSE Block for Tritanopia
	
} // End of getter method for the color blind x variable

// Getter method used to access the y member variable of the IDd colorblind object
real scalar colorblind::getConfuseY(real scalar type) {
	
	// If value passed to method is 2
	if (type == 2) {
		
		// Return the constant for Protanopia transformation
		return(this.protanope.getConfuseY())
		
	} // End IF Block for Protanopia
	
	// If value 3 is passed
	else if (type == 3) {
	
		// Return the constant for Deuteranopia transformation
		return(this.deuteranope.getConfuseY())
		
	} // End ELSEIF Block for Deuteranopia
	
	// Otherwise
	else {
	
		// Return the constant for Tritanopia transformation
		return(this.tritanope.getConfuseY())
		
	} // End ELSE Block for Tritanopia
	
} // End of getter method for the color blind y variable

// Getter method used to access the slope member variable of the IDd colorblind object
real scalar colorblind::getConfuseM(real scalar type) {
	
	// If value passed to method is 2
	if (type == 2) {
		
		// Return the constant for Protanopia transformation
		return(this.protanope.getConfuseM())
		
	} // End IF Block for Protanopia
	
	// If value 3 is passed
	else if (type == 3) {
	
		// Return the constant for Deuteranopia transformation
		return(this.deuteranope.getConfuseM())
		
	} // End ELSEIF Block for Deuteranopia
	
	// Otherwise
	else {
	
		// Return the constant for Tritanopia transformation
		return(this.tritanope.getConfuseM())
		
	} // End ELSE Block for Tritanopia
	
} // End of getter method for the color blind slope variable

// Getter method used to access the intercept member variable of the IDd colorblind object 
real scalar colorblind::getConfuseYint(real scalar type) {
	
	// If value passed to method is 2
	if (type == 2) {
		
		// Return the constant for Protanopia transformation
		return(this.protanope.getConfuseYint())
		
	} // End IF Block for Protanopia
	
	// If value 3 is passed
	else if (type == 3) {
	
		// Return the constant for Deuteranopia transformation
		return(this.deuteranope.getConfuseYint())
		
	} // End ELSEIF Block for Deuteranopia
	
	// Otherwise
	else {
	
		// Return the constant for Tritanopia transformation
		return(this.tritanope.getConfuseYint())
		
	} // End ELSE Block for Tritanopia
	
} // End of getter method for the color blind intercept variable

// Method to ensure that RGB values are within [0, 255]
real rowvector colorblind::checkRange(real rowvector rgb) {
	
	// Row vector to store updated RGB values 
	real rowvector updateRGB
	
	// Scalar used for iterator in loop below
	real scalar i
	
	// Initialized a null row vector to store updated values
	updateRGB = J(1, cols(rgb), .)
	
	// Loop over the elements of the row vector
	for(i = 1; i <= cols(rgb); i++) {
	
		// If the value is < 0
		if (rgb[1, i] < 0) {
			
			// Force value to 0
			updateRGB[1, i] = 0
			
		} // End IF Block for values < 0
		
		// If the value is > 255
		else if (rgb[1, i] > 255) { 

			// Force the value to 255
			updateRGB[1, i] = 255
			
		} // End ELSEIF Block for values > 255
		
		// Otherwise
		else {
		
			// Truncate the value and store only the integer portion of it
			updateRGB[1, i] = trunc(rgb[1, i])
			
		} // End ELSE Block for values in [0, 255]
		
	} // End Loop over row vector elements
	
	// Return the updated/validated RGB values
	return(updateRGB)
	
} // End of method to validate range for RGB values

// Total colorblindness method (type == 1)
void colorblind::achromatope() {

	// Declare local variables for method
	real scalar dr, dg, db

	// Declare rowvector used to store the transformed RGB values
	real rowvector nrgb
	
	// Convert to Monochrome using sRGB WhitePoint	
	dr = (getR() * 0.212656 + getG() * 0.715158 + getB() * 0.072186)
	
	// Anomylize colors
	dr = (getR() * (1.0 - getAmount())) + dr * getAmount()
	dg = (getG() * (1.0 - getAmount())) + dg * getAmount()
	db = (getB() * (1.0 - getAmount())) + db * getAmount()
	
	// Pass the values and check that they are in [0, 255]
	nrgb = checkRange((dr, dg, db))
	
	// Update the matrix containing the transformed values
	this.transformedRGB[1, .] = nrgb
	
} // End Method used to transform value to complete colorblind values

// Conditional maximum method for simulations
real scalar colorblind::condMax(real rowvector fits) {
	
	// Declares variable used for loop
	real scalar i
	
	// Declares variable used to store the new RGB rowvector
	real rowvector x
	
	// Initializes a null rowvector
	x = J(1, 3, .)
	
	// Loop over the elements of the rowvector passed as an argument
	for(i = 1; i <= cols(fits); i++) {
	
		// If the value is [0, 1] use that value
		if (fits[1, i] >= 0 & fits[1, i] <= 1) {
			
			// Populate element with passed value
			x[1, i] = fits[1, i]
			
		} // End IF Block to check for range in [0, 1]
		
		// If the value is not [0, 1]
		else {
		
			// Set a default value of 0
			x[1, i] = 0
		
		} // End ELSE Block for values outside of [0, 1]
		
	} // End Loop over elements of rowvector argument
	
	// Return the adjusted rowvector
	return(max(x))
	
} // End method declaration for conditional maximum value

// Simulate colorblind RGB values and populate the transformed matrix with new values
void colorblind::simulate(| real rowvector types) {

	// Declares scalar variables local to this method
	real scalar 	dr, dg, db, powr, powg, powb, x, y, z, chromax, 
					chromay, m, yint, deviatex, deviatey, neutralx, 
					neutralz, diffx, diffz, diffr, diffg, diffb, 
					fitr, fitg, fitb, adjust, i, thetype

	// Declares row vector variables local to this method
	real rowvector 	tomax, updateRGB
	
	// If no value specified iterate over all values
	if (args() == 0) {
	
		// Create a row vector with all possible values
		types = (1, 2, 3, 4)
		
	} // End IF Block for optional argument handling
	
	// Loop over the arguments passed to the method
	for(i = 1; i <= cols(types); i++) {
	
		// Get the transformation/simulation type
		thetype = types[1, i]
		
		// For type = 1 (Full Color Blindness
		if (thetype == 1) {
		
			// Transform values for full/complete color blindness
			achromatope()
		
		} // End IF Block for full color blindness

		/* For all other types of color blindness the type codes are:
		2 = Protanopia (Red Color Blindness)
		3 = Deuteranopia (Green Color Blindness)
		4 = Tritanopia (Blue Color Blindness) 
		*/
		else {
		
			// Transform value variables
			dr = getR() 
			dg = getG()
			db = getB()

			// Stores the starting RGB values for this iteration
			this.drgb1[thetype, .] = (dr, dg, db)
			
			// RGB Adjusted for gamma level 2.2
			powr = dr^getGamma()
			powg = dg^getGamma()
			powb = db^getGamma()
					
			// Stores the RGB values raised to Gamma for debugging
			this.powrgb[thetype, .] = (powr, powg, powb)

			// XYZ color space representation of RGB values
			x = powr * 0.412424 + powg * 0.357579 + powb * 0.180464
			y = powr * 0.212656 + powg * 0.715158 + powb * 0.0721856
			z = powr * 0.0193324 + powg * 0.119193 + powb * 0.950444

			// Stores the xyz color space transformation values for debugging
			this.xyz[thetype, .] = (x, y, z)
			
			// Convert XYZ into xyY Chromacity Coordinates (xy) and Luminance (Y)
			chromax = x / (x + y + z)
			chromay = y / (x + y + z)

			// Stores the chroma transformation values for debugging
			this.chroma[thetype, .] = (chromax, chromay)

			// Stores the transformation constants for debugging
			this.trnsconstants[thetype, .] = (getConfuseX(thetype), 
			getConfuseY(thetype), getConfuseM(thetype), getConfuseYint(thetype))
			
			// Generate the "Confusion Line" between the source color and the Confusion Point
			// slope of the confusion line
			m = (chromay - getConfuseY(thetype)) / (chromax - getConfuseX(thetype)) 

			// Intercept for confusion line
			yint = chromay - chromax * m

			// How far the xy coords deviate from the simulation
			deviatex = (getConfuseYint(thetype) - yint) / (m - getConfuseM(thetype))
			deviatey = (m * deviatex) + yint

			// Compute the simulated color's XYZ coords
			x = deviatex * y / deviatey
			z = (1.0 - (deviatex + deviatey)) * y / deviatey
			
			// Neutral grey calculated from luminance (in D65)
			neutralx = 0.312713 * y / 0.329016 
			neutralz = 0.358271 * y / 0.329016 
			
			// Stores simulation variable values for debugging
			this.sim[thetype, .] = (yint, m, deviatex, deviatey, neutralx, neutralz, x, z)
			
			// Difference between simulated color and neutral grey
			diffx = neutralx - x
			diffz = neutralz - z
			
			// Used to compensate transformed values into RGB color space 
			diffr = diffx * 3.24071 + diffz * -0.498571 
			diffg = diffx * -0.969258 + diffz * 0.0415557
			diffb = diffx * 0.0556352 + diffz * 1.05707

			// Stores difference variables for debugging
			this.diffrgb[thetype, .] = (diffr, diffg, diffb, diffx, diffz)
			
			// Convert XYZ to RGB color space (xyz -> rgb (sRGB:D65))
			dr = x * 3.24071 + y * -1.53726 + z * -0.498571
			dg = x * -0.969258 + y * 1.87599 + z * 0.0415557
			db = x * 0.0556352 + y * -0.203996 + z * 1.05707

			// Stores initial transform values for debugging
			this.drgb2[thetype, .] = (dr, dg, db)
			
			// Compensate simulated color towards a neutral fit in RGB space
			// If the transformed red is >= 0
			if (dr >= 0) {
				
				// Fitted value for red is 1 - transformedRed / red residual
				fitr = (1 - dr) / diffr
				
			} // End IF Block for transformed red values >= 0
			
			// Otherwise
			else {
			
				// Value is 0 - transformedRed / red residual
				fitr = (0 - dr) / diffr
				
			} // End ELSE Block for fitted red values
			
			// If the transformed green is >= 0
			if (dg >= 0) {
				
				// Fitted value for green is 1 - transformedRed / green residual
				fitg = (1 - dg) / diffg
				
			} // End IF Block for transformed green values >= 0
			
			// Otherwise
			else {
			
				// Value is 0 - transformedGreen / green residual
				fitg = (0 - dg) / diffg
				
			} // End ELSE Block for fitted green values
			
			// If the transformed blue is >= 0
			if (db >= 0) {
				
				// Fitted value for blue is 1 - transformedBlue / blue residual
				fitb = (1 - db) / diffb
				
			} // End IF Block for transformed blue values >= 0
			
			// Otherwise
			else {
			
				// Value is 0 - transformedBlue / blue residual
				fitb = (0 - db) / diffb
				
			} // End ELSE Block for fitted blue values
			
			// Store the fitted values for debugging
			this.fitrgb[thetype, .] = (fitr, fitg, fitb)
			
			// Used to get the maxmimum parameter value across r, g, and b parameters
			tomax = (fitb, fitg, fitr)

			// Maximum value across all parameters
			adjust = condMax(tomax)

			// Shift proportional to the greatest shift
			dr = dr + (adjust * diffr)
			dg = dg + (adjust * diffg)
			db = db + (adjust * diffb)

			// Store the proportionally adjusted RGB values and the adjustment factor
			this.drgb3[thetype, .] = (dr, dg, db, adjust)
			
			// Apply gamma correction
			dr = dr^getInvGamma()
			dg = dg^getInvGamma()
			db = db^getInvGamma()

			// Store RGB values after gamma correction
			this.drgb4[thetype, .] = (dr, dg, db)
			
			// Anomylize colors
			dr = (getR() * (1.0 - getAmount())) + dr * getAmount()
			dg = (getG() * (1.0 - getAmount())) + dg * getAmount()
			db = (getB() * (1.0 - getAmount())) + db * getAmount()
			
			// Store anomylized colors
			this.drgb5[thetype, .] = (dr, dg, db)

			// Check to make sure ranges are in [0, 255]
			updateRGB = (dr, dg, db)
			
			// Update the matrix with the RGB values
			this.transformedRGB[thetype, .] = checkRange(updateRGB)
			
		} // End ELSE Block for non achromatope types of color blindness
		
	} // End Loop over the number of transformations

} // End Method definition

// Exit mata and return to Stata prompt
end 

