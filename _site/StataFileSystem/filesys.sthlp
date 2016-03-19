{smcl}
{* *! version 0.0.2  15MAR2016}{...}

{hline}
Command to access and manipulate file properties
{hline}

{title:help for filesys}

{p 4 4 8}{hi:filesys {hline 2}} a Java plugin to access filesystem properties of files.{p_end}

{title:Syntax}

{p 4 4 4}{cmd:filesys} {it:filename}, [
{cmdab:attr:ibutes} {cmdab:dis:play} {cmdab:glo:bal} 
{cmdab:r:eadable(}{it:string}{cmd:)} {cmdab:w:ritable(}{it:string}{cmd:)}
{cmdab:x:ecutable(}{it:string}{cmd:)} {cmdab:reado:nly} ] {break}

{title:Description}

{p 4 4 4}{cmd:filesys} is designed to provide access to basic file system properties.  
In addition, it provides some basic functionality to allow setting properties 
on files without having to write OS specific code to do the same from the shell.  
See {help filesys##return:return values} for additional information regarding the 
attributes that are exposed from this program.{p_end}

{title:Options}

{p 4 4 8}{cmdab:attr:ibutes} this option is used to retrieve the properties of a 
file and {hi:does not} make any modifications to the file system properties for 
the file.  {break}

{p 4 4 8}{cmdab:dis:play} prints a table showing the file system properties to 
the Results window. {break}

{p 4 4 8}{cmdab:glo:bal} is an option used in conjunction with {cmdab:r:eadable}, 
{cmdab:w:ritable}, or {cmdab:x:ecutable} to set the property on/off for all users. {p_end}

{p 4 4 8}{cmdab:r:eadable(}{it:on|off}{cmd:)} is an option used to set the readable 
property for the file on or off.  If the global option is not specified it will 
set this property for the current user only.{p_end}

{p 4 4 8}{cmdab:w:ritable(}{it:on|off}{cmd:)} is an option used to set the readable 
property for the file on or off.  If the global option is not specified it will 
set this property for the current user only.{p_end}

{p 4 4 8}{cmdab:x:ecutable(}{it:on|off}{cmd:)} is an option used to set the executable 
property for the file on or off.  ({it:Note: the misspelling here is intended to reflect the way the properties are declared in *nix based systems}).  If the global option is not specified it will set this 
property for the current user only.{p_end}

{p 4 4 8}{cmdab:reado:nly} is an option used to set the file to readonly mode. There is no option to apply this globally vs locally. {p_end}

{marker examples}{title:Examples}

{p 8 8 8} View the properties of the auto.dta dataset {p_end}
{p 8 8 8}{stata filesys `c(sysdir_base)'a/auto.dta, attr dis}{p_end}
{res}{p2colset 10 35 35 10}
{p2line 0 35}{p2col:Attribute}File Attribute Value{p_end}
{p2line 0 35}{p2colset 10 35 35 10}{p2col:Created Date}20nov2015 05:44:54{p_end}
{p2colset 10 35 35 10}{p2col:Modified Date}20nov2015 05:44:54{p_end}
{p2colset 10 35 35 10}{p2col:Last Accessed Date}11dec2015 05:52:23{p_end}
{p2colset 10 35 35 10}{p2col:Absolute File Path}/Applications/Stata/ado/base/a/auto.dta{p_end}
{p2colset 10 35 35 10}{p2col:Canonical File Path}/Applications/Stata/ado/base/a/auto.dta{p_end}
{p2colset 10 35 35 10}{p2col:Parent Path}/Applications/Stata/ado/base/a{p_end}
{p2colset 10 35 35 10}{p2col:File Name}auto.dta{p_end}
{p2colset 10 35 35 10}{p2col:Is Symbolic Link}false{p_end}
{p2colset 10 35 35 10}{p2col:Is Regular File}true{p_end}
{p2colset 10 35 35 10}{p2col:Is Executable}false{p_end}
{p2colset 10 35 35 10}{p2col:Is Hidden}false{p_end}
{p2colset 10 35 35 10}{p2col:Is Readable}true{p_end}
{p2colset 10 35 35 10}{p2col:Is Writable}true{p_end}
{p2line 0 35}
{text}{break}

{p 8 8 8} Make the file globally executable {p_end}
{p 8 8 8}{stata filesys `c(sysdir_base)'a/auto.dta, glo x(on) dis}{p_end}
{res}{p2colset 10 35 35 10}
{p2line 0 35}{p2col:Attribute}File Attribute Value{p_end}
{p2line 0 35}{p2colset 10 35 35 10}{p2col:Created Date}20nov2015 05:44:54{p_end}
{p2colset 10 35 35 10}{p2col:Modified Date}20nov2015 05:44:54{p_end}
{p2colset 10 35 35 10}{p2col:Last Accessed Date}11dec2015 05:52:23{p_end}
{p2colset 10 35 35 10}{p2col:Absolute File Path}/Applications/Stata/ado/base/a/auto.dta{p_end}
{p2colset 10 35 35 10}{p2col:Canonical File Path}/Applications/Stata/ado/base/a/auto.dta{p_end}
{p2colset 10 35 35 10}{p2col:Parent Path}/Applications/Stata/ado/base/a{p_end}
{p2colset 10 35 35 10}{p2col:File Name}auto.dta{p_end}
{p2colset 10 35 35 10}{p2col:Is Symbolic Link}false{p_end}
{p2colset 10 35 35 10}{p2col:Is Regular File}true{p_end}
{p2colset 10 35 35 10}{p2col:Is Executable}true{p_end}
{p2colset 10 35 35 10}{p2col:Is Hidden}false{p_end}
{p2colset 10 35 35 10}{p2col:Is Readable}true{p_end}
{p2colset 10 35 35 10}{p2col:Is Writable}true{p_end}
{p2line 0 35}
{text}{break}

{p 8 8 8} Turn off the executable property {p_end}
{p 8 8 8}{stata filesys `c(sysdir_base)'a/auto.dta, glo x(off) dis}{p_end}
{res}{p2colset 10 35 35 10}
{p2line 0 35}{p2col:Attribute}File Attribute Value{p_end}
{p2line 0 35}{p2colset 10 35 35 10}{p2col:Created Date}20nov2015 05:44:54{p_end}
{p2colset 10 35 35 10}{p2col:Modified Date}20nov2015 05:44:54{p_end}
{p2colset 10 35 35 10}{p2col:Last Accessed Date}11dec2015 05:52:23{p_end}
{p2colset 10 35 35 10}{p2col:Absolute File Path}/Applications/Stata/ado/base/a/auto.dta{p_end}
{p2colset 10 35 35 10}{p2col:Canonical File Path}/Applications/Stata/ado/base/a/auto.dta{p_end}
{p2colset 10 35 35 10}{p2col:Parent Path}/Applications/Stata/ado/base/a{p_end}
{p2colset 10 35 35 10}{p2col:File Name}auto.dta{p_end}
{p2colset 10 35 35 10}{p2col:Is Symbolic Link}false{p_end}
{p2colset 10 35 35 10}{p2col:Is Regular File}true{p_end}
{p2colset 10 35 35 10}{p2col:Is Executable}false{p_end}
{p2colset 10 35 35 10}{p2col:Is Hidden}false{p_end}
{p2colset 10 35 35 10}{p2col:Is Readable}true{p_end}
{p2colset 10 35 35 10}{p2col:Is Writable}true{p_end}
{p2line 0 35}
{text}{break}

{p 8 8 8} Turn on the writable property {p_end}
{p 8 8 8}{stata filesys `c(sysdir_base)'a/auto.dta, glo w(on) dis}{p_end}

{p 8 8 8} Turn off the writable property {p_end}
{p 8 8 8}{stata filesys `c(sysdir_base)'a/auto.dta, glo w(off) dis}{p_end}

{p 8 8 8} Turn off the writable property for the current user only{p_end}
{p 8 8 8}{stata filesys `c(sysdir_base)'a/auto.dta, w(off) dis}{p_end}

{p 8 8 8} Turn on the readable property and suppress output{p_end}
{p 8 8 8}{stata filesys `c(sysdir_base)'a/auto.dta, glo r(on)}{p_end}

{p 8 8 8} Turn off the readable property {p_end}
{p 8 8 8}{stata filesys `c(sysdir_base)'a/auto.dta, glo r(off) dis}{p_end}

{marker return}{title:Returned values}

{p2colset 10 35 35 10}
{p2line 0 0}{p2col:Macro Name}Value{p_end}
{p2line 0 0}{p2colset 10 35 35 10}{p2col:r(iswritable)}Boolean indicator if file is writable{p_end}
{p2colset 10 35 35 10}{p2col:r(isreadable)}Boolean indicator if file is readable{p_end}
{p2colset 10 35 35 10}{p2col:r(parentpath)}String with path to parent directory{p_end}
{p2colset 10 35 35 10}{p2col:r(ishidden)}Boolean indicator if file is hidden{p_end}
{p2colset 10 35 35 10}{p2col:r(filename)}String name of the file w/o filepath{p_end}
{p2colset 10 35 35 10}{p2col:r(isexecutable)}Boolean indicator if file is executable{p_end}
{p2colset 10 35 35 10}{p2col:r(canonicalpath)}OS specific absolute path{p_end}
{p2colset 10 35 35 10}{p2col:r(absolutepath)}Generic absolute path{p_end}
{p2colset 10 35 35 10}{p2col:r(filesize)}Size of the file in bytes{p_end}
{p2colset 10 35 35 10}{p2col:r(regularfile)}Boolean indicator if file is a regular file (not directory/symbolic link){p_end}
{p2colset 10 35 35 10}{p2col:r(symlink)}Boolean indicator if file is a symbolic link{p_end}
{p2colset 10 35 35 10}{p2col:r(accessednum)}SIF Value of the last accessed date {it: use %tc for the display format}{p_end}
{p2colset 10 35 35 10}{p2col:r(modifiednum)}SIF Value of the modified date {it: use %tc for the display format}{p_end}
{p2colset 10 35 35 10}{p2col:r(creatednum)}SIF Value of the created date {it: use %tc for the display format}{p_end}
{p2colset 10 35 35 10}{p2col:r(accessed)}String containing the date last modified{p_end}
{p2colset 10 35 35 10}{p2col:r(modified)}String containing the modified date{p_end}
{p2colset 10 35 35 10}{p2col:r(created)}String containing the created date{p_end}
{p2line 0 0}

{title:Author}{break}
{p 4 4 8}William R. Buchanan, Ph.D.{p_end}
{p 4 4 8}Data Scientist{p_end}
{p 4 4 8}{browse "http://mpls.k12.mn.us":Minneapolis Public Schools}{p_end}
{p 4 4 8}William.Buchanan at mpls [dot] k12 [dot] mn [dot] us{p_end}
