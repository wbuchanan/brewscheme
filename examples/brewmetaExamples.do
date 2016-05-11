/* brewmeta examples */

// Get the color blind attribute for the pastel2 palette with 7 colors for color 
// number 5
brewmeta pastel2, colorid(5) colors(7) prop(colorblind)

// Get the meta attribute for the dark2 palette with maximum number of colors for 
// the third color
brewmeta dark2, colorid(3) prop(meta)

// Get all of the attributes for the puor palette with the maximum number of 
// colors for the 6th color
brewmeta puor, colorid(6)

