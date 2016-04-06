/* filesys examples */

// Get the file system attributes for the auto.dta file and print to screen
filesys `c(sysdir_base)'a/auto.dta, attr dis

// Display the SIF version of the last accessed date with display formatting
di %tc `r(accessednum)'

// Make the data set globally executable
filesys `c(sysdir_base)'a/auto.dta, x(on) glo dis

// And undo the change that was just made
filesys `c(sysdir_base)'a/auto.dta, x(off) glo dis
