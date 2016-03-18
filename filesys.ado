********************************************************************************
*                                                                              *
* Description -                                                                *
*   Program to access filesystem properties from within Stata                  *
*                                                                              *
* System Requirements -                                                        *
*   JRE 1.8 or Higher.                                                         *
*                                                                              *
* Output -                                                                     *
*   Optionally prints properties to the Stata console.                         *
*                                                                              *
* Lines -                                                                      *
* 	198	                                                                       *
*                                                                              *
********************************************************************************

*! filesys
*! 20jan2016
*! v 0.0.3

// Drop the program if it exists in memory
cap prog drop filesys

// Define the program as an r-class program
prog def filesys, rclass

    // Version of Stata to use for interpreting the command(s)
    version 13.1

    // Syntax used to call program
    syntax anything(name = file id = "The name of the file/path") [,		 ///
    ATTRibutes DISplay GLObal Readable(string asis) Writable(string asis) 	 ///   
	Xecutable(string asis) READOnly ]

	// Clear previous return results
	return clear
	
    // If OS is DOS based
    if lower(`"`c(os)'"') == "windows" loc os "Windoze"
	
    // If OS isn't a horrible atrocity designed to cause pain and suffering
    else loc os "POSIX"

	if !inlist(`"`readable'"', "on", "off", "") loc r ""
	else loc r "`readable'"
	
	if !inlist(`"`writable'"', "on", "off", "") loc w ""
	else loc w "`writable'"
	
	if !inlist(`"`xecutable'"', "on", "off", "") loc x ""
	else loc x "`xecutable'"
	
    // Check for a tilde in the first character on OSX
    if substr(`"`file'"', 1, 1) == "~" & `"`c(os)'"' == "MacOSX" {

        // Replace the tilde with the standard expansion
        loc file `"`: subinstr loc file `"~"' `"`: environment HOME'"', all'"'

    } // End IF Block for tilde expansion on OSX

    // Check for the tilde character on Unix-based systems
    else if substr(`"`file'"', 1, 1) == "~" {

        // Replace the tilde with the standard expansion
        loc file `"`: subinstr loc file `"~"' `"`: environment HOME'"', all'"'

    } // End IF Block for tilde expansion on Unix-based systems

    // For the Windoze case
    else {

        // Replace the tilde with a standard Windoze expansion
        loc file `"`: subinstr loc file `"~"' `"`: environment HOME'"', all'"'

    } // End IF Block for tilde expansion on OSX

    // IF Block for file creation properties
    if `"`attributes'"' != "" {

        // Call java method to access the file creation/modification/access
        // dates
        javacall org.paces.Stata.StataFileSystem fileCreated, args("`file'"  ///
        "`os'" "`display'")
		
	} // End IF Block for attributes method	

    // IF Block for file creation properties
    if `"`r'"' != "" {

        // Makes file readable and returns file properties
        javacall org.paces.Stata.StataFileSystem makeReadable, args("`file'" ///
        "`os'" "`display'")
		
	} // End IF Block for attributes method	

    // IF Block for file creation properties
    if `"`w'"' != "" {

        // Makes file writable and returns file properties
        javacall org.paces.Stata.StataFileSystem makeWritable, args("`file'" ///
        "`os'" "`display'")
		
	} // End IF Block for attributes method	

    // IF Block for file creation properties
    if `"`x'"' != "" {

        // Makes file executable and returns file properties
        javacall org.paces.Stata.StataFileSystem makeExecutable,			 ///   
		args("`file'" "`os'" "`display'")
		
	} // End IF Block for attributes method	
	
    // IF Block for file creation properties
    if `"`readonly'"' != "" {

        // Makes file read only and returns file properties
        javacall org.paces.Stata.StataFileSystem makeReadOnly, args("`file'" ///
        "`os'" "`display'")
		
	} // End IF Block for attributes method	

	// Returns the file creation date
	ret loc created `"`createdon'"'

	// Returns the file modification date
	ret loc modified `"`modifiedon'"'

	// Returns the last accessed date
	ret loc accessed `"`accessedon'"'

    // SIF Formatted creation date
	ret loc creatednum `= clock(`"`createdon'"', "DMYhms")'

    // SIF Formatted modification date
	ret loc modifiednum `= clock(`"`modifiedon'"', "DMYhms")'

    // SIF Formatted last access date
	ret loc accessednum `= clock(`"`accessedon'"', "DMYhms")'

	// Returns the symlink indicator
	ret loc symlink `"`symlink'"'

	// Returns the regular file indicator
	ret loc regularfile `"`regfile'"'

	// Returns the filesize
	ret loc filesize `"`filesize'"'

	// Returns the absolute path
	ret loc absolutepath `"`absolutepath'"'

	// Returns the canonical path
	ret loc canonicalpath `"`canonicalpath'"'

	// Returns the executable indicator
	ret loc isexecutable `"`executable'"'

	// Returns the filename
	ret loc filename `"`filename'"'

	// Returns the hidden indicator
	ret loc ishidden `"`hidden'"'

	// Returns the parent path
	ret loc parentpath `"`parent'"'

	// Returns the readable indicator
	ret loc isreadable `"`readable'"'

	// Returns the writable indicator
	ret loc iswritable `"`writable'"'

	// If Display option is enabled, print the file attributes on the screen
	if `"`display'"' != "" {

		di as res _n(2) "{hline 80}" _continue
		di as res "{p2colset 5 30 30 5}{p2col:Attribute}File Attribute Value{p_end}" 
		di as res "{hline 80}" _continue
		di as res "{p2colset 5 30 30 5}{p2col:Created Date}`createdon'{p_end}" 
		di as res "{p2colset 5 30 30 5}{p2col:Modified Date}`modifiedon'{p_end}" 
		di as res "{p2colset 5 30 30 5}{p2col:Last Accessed Date}`accessedon'{p_end}" 
		di as res "{p2colset 5 30 30 5}{p2col:Absolute File Path}`absolutepath'{p_end}" 
		di as res "{p2colset 5 30 30 5}{p2col:Canonical File Path}`canonicalpath'{p_end}" 
		di as res "{p2colset 5 30 30 5}{p2col:Parent Path}`parent'{p_end}" 
		di as res "{p2colset 5 30 30 5}{p2col:File Name}`filename'{p_end}" 
		di as res "{p2colset 5 30 30 5}{p2col:Is Symbolic Link}`symlink'{p_end}" 
		di as res "{p2colset 5 30 30 5}{p2col:Is Regular File}`regfile'{p_end}" 
		di as res "{p2colset 5 30 30 5}{p2col:Is Executable}`executable'{p_end}" 
		di as res "{p2colset 5 30 30 5}{p2col:Is Hidden}`hidden'{p_end}" 
		di as res "{p2colset 5 30 30 5}{p2col:Is Readable}`readable'{p_end}" 
		di as res "{p2colset 5 30 30 5}{p2col:Is Writable}`writable'{p_end}" 
		di as res "{hline 80}" _n

	} // End IF block for display option

// End of program definition	
end

