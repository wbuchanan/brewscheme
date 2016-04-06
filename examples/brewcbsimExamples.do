/* brewcbsim examples */

// Simulation with XKCD installed color, RGB strings, and a Stata named color style
brewcbsim xkcd119 "63 210 142" "8 151 233" "182 33 43" bluishgray8

qui: gr export `"$articledir/brewcbsimEx1.eps"', as(eps) replace

// Colors typically associated with color sight impairments
brewcbsim red green blue yellow

qui: gr export `"$articledir/brewcbsimEx2.eps"', as(eps) replace
