/* brewviewer examples */

// Use the D3js palette with upto 6 colors (e.g., 3, 4, 5, and 6) and include 
// how the colors would appear with different forms of color sight impairments
brewviewer category10, im seq c(6)

qui: gr export `"$articledir/img/brewviewerEx1.png"', as(png) replace

// Specify a different number of colors for each palette graphing the colors with 
// the sequential option and combining the results into a single image
brewviewer category10 category20 category20b category20c, c(5 8 10 12)  comb seq

qui: gr export `"$articledir/img/brewviewerEx2.png"', as(png) replace

// Use the same number of colors for multiple palettes and combine the results
brewviewer dark2 mdebar accent pastel2 set1 tableau, c(5) seq comb 

qui: gr export `"$articledir/img/brewviewerEx3.png"', as(png) replace

// Show the same portion of each palette listed in a combined graph
brewviewer dark2 mdebar accent pastel2 set1 tableau, c(5) comb

qui: gr export `"$articledir/img/brewviewerEx4.png"', as(png) replace

