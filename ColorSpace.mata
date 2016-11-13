/*

	Source code below represents an OOP porting of the source used for the 
	CIE Color Calculator originally appearing on:
	
	http://www.brucelindbloom.com/index.html?ColorCalculator.html
	
*/	


mata:

mata clear

class ColorSpace {

	private:
	real			matrix		x, y, xy, refwhitergb, adaptations
	transmorphic 	matrix 		refWhiteLookup, ColorSpaceLookup, gammaLookup,
								gammaIdxLookup, mod2refwhite, adaptationLookup
	void						makeRefWhiteLookup(), makeRgbModelLookup(),
								makeGammaLookup(), makeGammaIdxLookup(),
								makeMod2RefWhiteLookup(), 
								makeAdaptationMethods()
	real			scalar		gammargb, gammargbidx
	
	public:
	void						new(), setXrgb(), setYrgb(), setRefWhite(), 
								setXY(), setGamma(), setGammaIdx(), setModel()
							
	real			matrix		getXrgb(), getYrgb(), getRefWhite(), 
								MtxTranspose3x3(), MtxInvert3x3()
								
	
	real			scalar 		getGamma(), getGammaIdx(), Determinant3x3()
							
}


void ColorSpace::new() {
	makeRefWhiteLookup()
	makeRgbModelLookup()
	makeGammaLookup()
	makeGammaIdxLookup()
	makeMod2RefWhiteLookup()
	makeAdaptationMethods()
}


void ColorSpace::makeMod2RefWhiteLookup() {
	this.mod2refwhite = asarray_create()
	asarray(mod2refwhite, "adobe", "astmd65")
	asarray(mod2refwhite, "apple", "astmd65")
	asarray(mod2refwhite, "bruce", "astmd65")
	asarray(mod2refwhite, "pal", "astmd65")
	asarray(mod2refwhite, "smpte", "astmd65") 
	asarray(mod2refwhite, "srgb", "astmd65")	
	asarray(mod2refwhite, "best", "astmd50")
	asarray(mod2refwhite, "beta", "astmd50")
	asarray(mod2refwhite, "colorMatch", "astmd50")
	asarray(mod2refwhite, "don", "astmd50")
	asarray(mod2refwhite, "eci", "astmd50")
	asarray(mod2refwhite, "ekta", "astmd50")
	asarray(mod2refwhite, "proPhoto", "astmd50")
	asarray(mod2refwhite, "wideGamut", "astmd50")
	asarray(mod2refwhite, "ntsc", "ntsc")
	asarray(mod2refwhite, "cie", "astme")
}


void ColorSpace::makeRefWhiteLookup() {
	this.refWhiteLookup = asarray_create()
	asarray(refWhiteLookup, "default", (0.96422, 1.0, 0.82521))
	asarray(refWhiteLookup, "astma", (1.09850, 1.0, 0.35585))
	asarray(refWhiteLookup, "wyszeckiStiles", (0.99072, 1.0, 0.85223))
	asarray(refWhiteLookup, "astmc", (0.98074, 1.0, 1.18232))
	asarray(refWhiteLookup, "astmd50", (0.96422, 1.0, 0.82521))
	asarray(refWhiteLookup, "astmd55", (0.95682, 1.0, 0.92149))
	asarray(refWhiteLookup, "astmd65", (0.95047, 1.0, 1.08883))
	asarray(refWhiteLookup, "astmd75", (0.94972, 1.0, 1.22638))
	asarray(refWhiteLookup, "astme", (1.0, 1.0, 1.0))
	asarray(refWhiteLookup, "astmf2", (0.99186, 1.0, 0.67393))
	asarray(refWhiteLookup, "astmf7", (0.95041, 1.0, 1.08747))
	asarray(refWhiteLookup, "astmf11", (1.00962, 1.0, 0.64350))
	asarray(refWhiteLookup, "ntsc", (0.98074, 1.0, 1.18232))
}


void ColorSpace::makeRgbModelLookup() {
	this.ColorSpaceLookup = asarray_create()
	asarray(ColorSpaceLookup, "adobe", (0.64, 0.21, 0.15 \ 0.33, 0.71, 0.06))
	asarray(ColorSpaceLookup, "apple", (0.625, 0.28, 0.155 \ 0.34, 0.595, 0.07))
	asarray(ColorSpaceLookup, "best", (0.7347, 0.215, 0.13 \0.2653, 0.775, 0.035))
	asarray(ColorSpaceLookup, "beta", (0.6888, 0.1986, 0.1265 \ 0.3112, 0.7551, 0.0352))
	asarray(ColorSpaceLookup, "bruce", (0.64, 0.28, 0.15 \ 0.33, 0.65, 0.06))
	asarray(ColorSpaceLookup, "cie", (0.735, 0.274, 0.167 \ 0.265, 0.717, 0.009))
	asarray(ColorSpaceLookup, "colorMatch", (0.63, 0.295, 0.15 \ 0.34, 0.605, 0.075))
	asarray(ColorSpaceLookup, "don", (0.696, 0.215, 0.130 \ 0.300, 0.765, 0.035))
	asarray(ColorSpaceLookup, "eci", (0.67, 0.21, 0.14 \ 0.33, 0.71, 0.08))
	asarray(ColorSpaceLookup, "ekta", (0.695, 0.260, 0.110 \ 0.305, 0.700, 0.005))
	asarray(ColorSpaceLookup, "ntsc", (0.67, 0.21, 0.14 \ 0.33, 0.71, 0.08))
	asarray(ColorSpaceLookup, "pal", (0.64, 0.29, 0.15 \ 0.33, 0.60, 0.06))
	asarray(ColorSpaceLookup, "proPhoto", (0.7347, 0.1596, 0.0366 \ 0.2653, 0.8404, 0.0001))
	asarray(ColorSpaceLookup, "smpte", (0.63, 0.310, 0.155 \ 0.34, 0.595, 0.070))
	asarray(ColorSpaceLookup, "srgb", (0.64, 0.30, 0.15 \ 0.33, 0.60, 0.06))
	asarray(ColorSpaceLookup, "wideGamut", (0.735, 0.115, 0.157 \ 0.265, 0.826, 0.018))
}


void ColorSpace::makeGammaLookup() {
	this.gammaLookup = asarray_create()
	asarray(gammaLookup, "adobe", 2.2)
	asarray(gammaLookup, "apple", 1.8)
	asarray(gammaLookup, "best", 2.2)
	asarray(gammaLookup, "beta", 2.2)
	asarray(gammaLookup, "bruce", 2.2)
	asarray(gammaLookup, "cie", 2.2)
	asarray(gammaLookup, "colorMatch", 1.8)
	asarray(gammaLookup, "don", 2.2)
	asarray(gammaLookup, "eci", 0)
	asarray(gammaLookup, "ekta", 2.2)
	asarray(gammaLookup, "ntsc", 2.2)
	asarray(gammaLookup, "pal", 2.2)
	asarray(gammaLookup, "proPhoto", 1.8)
	asarray(gammaLookup, "smpte", 2.2)
	asarray(gammaLookup, "srgb", -2.2)
	asarray(gammaLookup, "wideGamut", 2.2)
}


void ColorSpace::makeGammaIdxLookup() {

	this.gammaIdxLookup = asarray_create()
	asarray(gammaIdxLookup, "adobe", 2)
	asarray(gammaIdxLookup, "apple", 1)
	asarray(gammaIdxLookup, "best", 2)
	asarray(gammaIdxLookup, "beta", 2)
	asarray(gammaIdxLookup, "bruce", 2)
	asarray(gammaIdxLookup, "cie", 2)
	asarray(gammaIdxLookup, "colorMatch", 1)
	asarray(gammaIdxLookup, "don", 2)
	asarray(gammaIdxLookup, "eci", 4)
	asarray(gammaIdxLookup, "ekta", 2)
	asarray(gammaIdxLookup, "ntsc", 2)
	asarray(gammaIdxLookup, "pal", 2)
	asarray(gammaIdxLookup, "proPhoto", 1)
	asarray(gammaIdxLookup, "smpte", 2)
	asarray(gammaIdxLookup, "srgb", 3)
	asarray(gammaIdxLookup, "wideGamut", 2)
}


void ColorSpace::setRefWhite(string scalar nm) {
	this.refwhitergb = asarray(refWhiteLookup, nm)
}


void ColorSpace::setXrgb(real matrix rgb) {
	this.x = rgb
}


void ColorSpace::setYrgb(real matrix rgb) {
	this.y = rgb
}


void ColorSpace::setXY(string scalar model) {
	this.xy = asarray(ColorSpaceLookup, model)
	this.x = xy[1, 1..3]
	this.y = xy[2, 1..3]
}


void ColorSpace::setGamma(string scalar gamma) {
	this.gammargb = asarray(gammaLookup, gamma)
}


void ColorSpace::setGammaIdx(string scalar gammaidx) {
	this.gammargbidx = asarray(gammaIdxLookup, gammaidx)
}


void ColorSpace::setModel(string scalar model) {
	if (asarray_contains(ColorSpaceLookup, model) != 1) model = "adobe"
	setGammaRgb(model)
	setXY(model)
	setGammaRgbIdx(model)
	setRefWhite(asarray(mod2refwhite, model))
}


void ColorSpace::makeAdaptationMethods() {
	this.adaptationLookup = asarray_create()
	asarray(adaptationLookup, "bradford", (	0.8951, -0.7502, 0.0389 \ 
											0.2664, 1.7135, -0.0685 \
											-0.1614, 0.0367, 1.0296))
	asarray(adaptationLookup, "von kries", (0.40024, -0.22630, 0.0 \
											0.70760, 1.16532,  0.0\ 
											-0.08081, 0.04570, 0.91822))
	asarray(adaptationLookup, "", I(3, 3))
	
}

real matrix ColorSpace::getXrgb() {
	return(this.x)
}	


real matrix ColorSpace::getYrgb() {
	return(this.y)
}


real matrix ColorSpace::getRefWhite() {
	return(this.refwhitergb)
}


real scalar ColorSpace::getGamma() {
	return(this.gammargb)
}


real scalar ColorSpace::getGammaIdx() {
	return(this.gammargbidx)
}


real scalar ColorSpace::Determinant3x3(real matrix m) {
	return(det(m))
}	

real matrix ColorSpace::MtxInvert3x3(real matrix m) {
	return(luinv(i))
}

real matrix ColorSpace::MtxTranspose3x3(real matrix m) {
	return(m')
}


end

