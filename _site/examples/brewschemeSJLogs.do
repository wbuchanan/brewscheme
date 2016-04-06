// libbrewscheme, rep
// brewcolordb, rep over
// brewdb, rep  over

// Used to build and install all of the XKCD colors
// brewcolors xkcd, rep over ma inst 

glo articledir `"~/Desktop/Programs/StataPrograms/b"'

log using examples/brewtheme.log, smcl replace
do `"$articledir/examples/brewthemeExamples.do"'
log c _all

log using examples/brewscheme.log, smcl replace
do `"$articledir/examples/brewschemeExamples.do"'
log c _all

log using examples/brewcolors.log, smcl replace
do `"$articledir/examples/brewcolorsExamples.do"'
log c _all

log using examples/brewmeta.log, smcl replace
do `"$articledir/examples/brewmetaExamples.do"'
log c _all

log using examples/brewproof.log, smcl replace
do `"$articledir/examples/brewproofExamples.do"'
log c _all

log using examples/brewcbsim.log, smcl replace
do `"$articledir/examples/brewcbsimExamples.do"'
log c _all

log using examples/brewterpolate.log, smcl replace
do `"$articledir/examples/brewterpolateExamples.do"'
log c _all

log using examples/brewsearch.log, smcl replace
do `"$articledir/examples/brewsearchExamples.do"'
log c _all

log using examples/hextorgb.log, smcl replace
do `"$articledir/examples/hextorgbExamples.do"'
log c _all

log using examples/filesys.log, smcl replace
do `"$articledir/examples/filesysExamples.do"'
log c _all

log using examples/brewviewer.log, smcl replace
do `"$articledir/examples/brewviewerExamples.do"'
log c _all
