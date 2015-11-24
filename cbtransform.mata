mata:

mata clear

class cbtype {
	private:
	real scalar x, y, m, yint
	public:
	real scalar getConfuseX(), getConfuseY(), getConfuseM(), getConfuseYint()
	void setConfuseX(), setConfuseY(), setConfuseM(), setConfuseYint()
}

real scalar cbtype::getConfuseX() {
	return(this.x)
}

real scalar cbtype::getConfuseY() {
	return(this.y)
}

real scalar cbtype::getConfuseM() {
	return(this.m)
}

real scalar cbtype::getConfuseYint() {
	return(this.yint)
}

void cbtype::setConfuseX(real scalar xarg) {
	this.x = xarg
}

void cbtype::setConfuseY(real scalar yarg) {
	this.y = yarg
}

void cbtype::setConfuseM(real scalar marg) {
	this.m = marg
}

void cbtype::setConfuseYint(real scalar yarg) {
	this.yint = yarg
}


class Protanopia extends cbtype {
	public:
	void new()
}

void Protanopia::new() {
	super.setConfuseX(0.7465)
	super.setConfuseY(0.2535)
	super.setConfuseM(1.273463)
	super.setConfuseYint(-0.073894)
}

class Deuteranopia extends cbtype {
	public:
	void new()
}

void Deuteranopia::new() {
	super.setConfuseX(1.4)
	super.setConfuseY(-0.4) 
	super.setConfuseM(0.968437) 
	super.setConfuseYint(0.003331)
}

class Tritanopia extends cbtype {
	public:
	void new()
}

void Tritanopia::new() {
	super.setConfuseX(0.1748) 
	super.setConfuseY(0.0) 
	super.setConfuseM(0.062921) 
	super.setConfuseYint(0.292119)
}


class colorblind {

	private:
	string 					rowvector 	types
	real 					scalar 		inputR, inputG, inputB, amount
	real					scalar		gamma
	real					scalar		invgamma
	real 					matrix 		transformedRGB
	class	Protanopia		scalar		protanope
	class	Deuteranopia	scalar		deuteranope
	class	Tritanopia		scalar		tritanope
	public:
	void 								new(), achromatope(), protanope(), 
										deuteranope(), tritanope(), setR(), 
										setG(), setB(), setAmount(), simulate()
	real 					scalar 		getR(), getG(), getB(), getGamma(), 
										getInvGamma(), getConfuseX(), 
										getConfuseY(), getConfuseM(), 
										getConfuseYint(), getAmount()
	string					rowvector	getTypes()
	string					scalar		getType()
	real					matrix		getTransformedRgbs()
	real					rowvector	getTransformedRgb(), checkRange()
	string					scalar		getRgbString()
	string					matrix		getRgbStrings()
	real					matrix		drgb1, drgb2, drgb3, drgb4, drgb5, 
										powrgb, xyz, chroma, sim, diffrgb, 
										fitrgb, trnsconstants

}

void colorblind::new() {
	this.protanope = Protanopia()
	this.deuteranope = Deuteranopia()
	this.tritanope = Tritanopia()
	this.transformedRGB = J(4, 3, .)
	this.types = ("achromatope", "protanope", "deuteranope", "tritanope")
	this.amount = 0.0
	this.gamma = 2.2
	this.invgamma = 1/2.2
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
}

void colorblind::setAmount(real scalar amt) {
	this.amount = amt
}

void colorblind::setR(real scalar red) {
	this.inputR = red
}

void colorblind::setG(real scalar green) {
	this.inputG = green
}

void colorblind::setB(real scalar blue) {
	this.inputB = blue
}

real scalar colorblind::getR() {
	return(this.inputR)
}

real scalar colorblind::getG() {
	return(this.inputG)
}

real scalar colorblind::getB() {
	return(this.inputB)
}

real scalar colorblind::getGamma() {
	return(this.gamma)
}

real scalar colorblind::getInvGamma() {
	return(this.invgamma)
}

string rowvector colorblind::getTypes() {
	return(this.types)
}

string scalar colorblind::getType(real scalar typ) {
	return(this.types[1, typ])
}

real matrix colorblind::getTransformedRgbs() {
	return(this.transformedRGB)
}

real rowvector colorblind::getTransformedRgb(real scalar type) {
	return(this.transformedRGB[type, .])
}

string matrix colorblind::getRgbStrings() {
	string matrix x
	real scalar i, j
	x = J(rows(getTransformedRgbs()), 3, "")
	
	for(i = 1; i <= rows(getTransformedRgbs()); i++) {
		for(j = 1; j <= cols(getTransformedRgbs()); j++) {
			x[i, j] = strofreal(this.transformedRGB[i, j])
		}
	}
	return(x)
}
	
string scalar colorblind::getRgbString(real scalar type) {
	string rowvector x
	string scalar i
	real scalar j
	x = J(1, 3, "")
	
	for(j = 1; j <= cols(getTransformedRgbs()); j++) {
		x[1, j] = strofreal(this.transformedRGB[type, j])
	}
	i = x[1, 1] + " " + x[1, 2] + " " + x[1, 3]
	return(i)
}
	

	
// Total colorblindness method (type == 1)
void colorblind::achromatope() {
	// Declare local variables for method
	real scalar dr, dg, db
	real rowvector nrgb
	// convert to Monochrome using sRGB WhitePoint	
	dr = (getR() * 0.212656 + getG() * 0.715158 + getB() * 0.072186)
	dg = round((getG() * (1.0 - amount) + dr * amount))
	db = round((getB() * (1.0 - amount) + dr * amount))
	dr = round((getR() * (1.0 - amount) + dr * amount))
	// Construct row vector
	nrgb = checkRange(dr, dg, db)
	this.transformedRGB[1, .] = nrgb
}

real scalar colorblind::getConfuseX(real scalar type) {
	if (type == 2) {
		return(this.protanope.getConfuseX())
	}
	else if (type == 3) {
		return(this.deuteranope.getConfuseX())
	}
	else if (type == 4) {
		return(this.tritanope.getConfuseX())
	}
}

real scalar colorblind::getConfuseY(real scalar type) {
	if (type == 2) {
		return(this.protanope.getConfuseY())
	}
	else if (type == 3) {
		return(this.deuteranope.getConfuseY())
	}
	else if (type == 4) {
		return(this.tritanope.getConfuseY())
	}
}

real scalar colorblind::getConfuseM(real scalar type) {
	if (type == 2) {
		return(this.protanope.getConfuseM())
	}
	else if (type == 3) {
		return(this.deuteranope.getConfuseM())
	}
	else if (type == 4) {
		return(this.tritanope.getConfuseM())
	}
}

real scalar colorblind::getConfuseYint(real scalar type) {
	if (type == 2) {
		return(this.protanope.getConfuseYint())
	}
	else if (type == 3) {
		return(this.deuteranope.getConfuseYint())
	}
	else if (type == 4) {
		return(this.tritanope.getConfuseYint())
	}
}

real rowvector colorblind::checkRange(real scalar red, real scalar green, real scalar blue) {
	real rowvector updateRGB
	// Make sure transformed red value is [0, 255]
	if (red < 0) {
		red = 0
	}
	else if (red > 255) {
		red = 255
	}
	else {
		red = red
	}
	
	// Make sure transformed green value is [0, 255]
	if (green < 0) {
		green = 0
	}
	else if (green > 255) {
		green = 255
	}
	else {
		green = green
	}
	
	// Make sure transformed blue value is [0, 255]
	if (blue < 0) {
		blue = 0
	}
	else if (blue > 255) {
		blue = 255
	}
	else {
		blue = blue
	}

	// Create row vector used to update the transformed color matrix
	updateRGB = (red, green, blue)

	return(updateRGB)
	
}

real scalar colorblind::getAmount() {
	return(this.amount)
}

// Simulate colorblind RGB values and populate the transformed matrix with new values
void colorblind::simulate(| real rowvector types) {

	real scalar 	dr, dg, db, powr, powg, powb, x, y, z, chromax, 
					chromay, m, yint, deviatex, deviatey, neutralx, 
					neutralz, diffx, diffz, diffr, diffg, diffb, 
					fitr, fitg, fitb, adjust, i, thetype

	real rowvector 	tomax, updateRGB
	
	// If no value specified iterate over all values
	if (args() == 0) types = (1, 2, 3, 4)

	// Loop over the arguments passed to the method
	for(i = 1; i <= cols(types); i++) {
	
		// Get the transformation/simulation type
		thetype = types[1, i]
		
		if (thetype == 1) {
		
			achromatope()
		
		}

		else {
		
			// Transform value variables
			dr = getR() 
			dg = getG()
			db = getB()

			this.drgb1[thetype, 1..3] = (dr, dg, db)
			
			// RGB Adjusted for gamma level 2.2
			powr = dr^2.2
			powg = dg^2.2
			powb = db^2.2
						
			this.powrgb[thetype, .] = (powr, powg, powb)

			// XYZ color space representation of RGB values
			x = powr * 0.412424 + powg * 0.357579 + powb * 0.180464
			y = powr * 0.212656 + powg * 0.715158 + powb * 0.0721856
			z = powr * 0.0193324 + powg * 0.119193 + powb * 0.950444

			this.xyz[thetype, .] = (x, y, z)
			
			// Convert XYZ into xyY Chromacity Coordinates (xy) and Luminance (Y)
			chromax = x / (x + y + z)
			chromay = y / (x + y + z)

			this.chroma[thetype, .] = (chromax, chromay)

			this.trnsconstants[thetype, .] = (getConfuseX(thetype), getConfuseY(thetype), getConfuseM(thetype), getConfuseYint(thetype))
			
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

			this.sim[thetype, .] = (yint, m, deviatex, deviatey, neutralx, neutralz, x, z)
			
			// Difference between simulated color and neutral grey
			diffx = neutralx - x
			diffz = neutralz - z
			
			// Used to compensate transformed values into RGB color space 
			diffr = diffx * 3.24071 + diffz * -0.498571 
			diffg = diffx * -0.969258 + diffz * 0.0415557
			diffb = diffx * 0.0556352 + diffz * 1.05707

			this.diffrgb[thetype, .] = (diffr, diffg, diffb, diffx, diffz)
			
			// Convert XYZ to RGB color space (xyz -> rgb (sRGB:D65))
			dr = x * 3.24071 + y * -1.53726 + z * -0.498571
			dg = x * -0.969258 + y * 1.87599 + z * 0.0415557
			db = x * 0.0556352 + y * -0.203996 + z * 1.05707

			this.drgb2[thetype, .] = (dr, dg, db)
			
			// Compensate simulated color towards a neutral fit in RGB space
			if (dr < 0) fitr = 1 - dr / diffr
			else fitr = 0 - dr / diffr

			if (dg < 0) fitg = 1 - dg / diffg
			else fitg = 0 - dg / diffg

			if (db < 0) fitb = 1 - db / diffb
			else fitb = 0 - db / diffb

			this.fitrgb[thetype, .] = (fitr, fitg, fitb)
			
			// Used to get the maxmimum parameter value across r, g, and b parameters
			tomax = (fitb, fitg, fitr)

			// Maximum value across all parameters
			adjust = max(tomax)

			// Shift proportional to the greatest shift
			dr = dr + (adjust * diffr)
			dg = dg + (adjust * diffg)
			db = db + (adjust * diffb)

			this.drgb3[thetype, .] = (dr, dg, db, adjust)
			
			// Apply gamma correction
			dr = dr^(1/2.2)
			dg = dg^(1/2.2)
			db = db^(1/2.2)

			this.drgb4[thetype, .] = (dr, dg, db)
			
			// Anomylize colors
			dr = round((getR() * (1.0 - getAmount()) + dr * getAmount()))
			dg = round((getG() * (1.0 - getAmount()) + dg * getAmount()))
			db = round((getB() * (1.0 - getAmount()) + db * getAmount()))
			
			this.drgb5[thetype, .] = (dr, dg, db)

			// Check to make sure ranges are in [0, 255]
			updateRGB = checkRange(dr, dg, db)
			
			// Update the matrix
			this.transformedRGB[thetype, .] = updateRGB
			
		} // End ELSE Block for non achromatope types of color blindness
		
	} // End Loop over the number of transformations

} // End Method definition

end 

