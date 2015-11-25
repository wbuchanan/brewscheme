cap prog drop libbrewscheme
prog def libbrewscheme
	version 13.1
	syntax[, DISplay Locpath ]
	mata: mata clear
	if `"`locpath'"' != "" {
		qui: do colorblind.mata
	}
	else {
		qui: do `"`c(sysdir_plus)'c/colorblind.mata"'
	}
	qui: mata: mata mlib create libbrewscheme, replace size(2048)
	qui: mata: mata mlib add libbrewscheme cbtype() Protanopia() Deuteranopia() Tritanopia() colorblind() translateColor(), complete
	mata: mata mlib index
	if `"`display'"' != "" {
		help libbrewscheme
	}
end

