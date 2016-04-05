libbrewscheme, rep
brewcolordb, rep over
brewdb, rep  over

// Used to build and install all of the XKCD colors
brewcolors xkcd, rep over ma inst 

glo articledir `"~/Desktop/Articles/StataJournal/brewscheme"'


sjlog using `"$articledir/brewthemeExamples"', replace
do `"$articledir/brewthemeExamples.do"'
sjlog close, nolog

sjlog using `"$articledir/brewschemeExamples"', replace
do `"$articledir/brewschemeExamples.do"'
sjlog close, nolog

sjlog using `"$articledir/brewcolorsExamples"', replace
do `"$articledir/brewcolorsExamples.do"'
sjlog close, nolog

sjlog using `"$articledir/brewmetaExamples"', replace
do `"$articledir/brewmetaExamples.do"'
sjlog close, nolog

sjlog using `"$articledir/brewproofExamples"', replace
do `"$articledir/brewproofExamples.do"'
sjlog close, nolog

sjlog using `"$articledir/brewcbsimExamples"', replace
do `"$articledir/brewcbsimExamples.do"'
sjlog close, nolog

sjlog using `"$articledir/brewterpolateExamples"', replace
do `"$articledir/brewterpolateExamples.do"'
sjlog close, nolog

sjlog using `"$articledir/brewsearchExamples"', replace
do `"$articledir/brewsearchExamples.do"'
sjlog close, nolog

sjlog using `"$articledir/hextorgbExamples"', replace
do `"$articledir/hextorgbExamples.do"'
sjlog close, nolog

sjlog using `"$articledir/filesysExamples"', replace
do `"$articledir/filesysExamples.do"'
sjlog close, nolog

sjlog using `"$articledir/brewviewerExamples"', replace
do `"$articledir/brewviewerExamples.do"'
sjlog close, nolog
