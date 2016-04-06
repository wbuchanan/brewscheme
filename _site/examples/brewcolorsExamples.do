/* brewcolors examples */

// Make the color database for the XKCD colors
brewcolors xkcd, ma

// Make the color database for the XKCD colors and install the named color styles
brewcolors xkcd, ma inst

// Add a new color to the color database
brewcolors new, ma inst colors("117 200 47")

// Add the same color but use the name mycolor
brewcolors new, ma inst colors(`""mycolor 117 200 47""')
