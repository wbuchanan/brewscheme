{smcl}
{* *! version 0.0.1  09APR2015}{...}
{cmd:help brewmeta}
{hline}

{title:Title}

{hi:brewmeta {hline 2}} A Stata interface to color property palettes developed 
by Cynthia Brewer ({browse "http://colorbrewer.org/": Color Brewer}).  

{title:Syntax}

{p 4 4 4}{cmd:brewmeta} {it:palette name}, {cmdab:c:olors(}{it:integer}{opt )} 
[ {cmdab:prop:erties[(}{it:"", "all", "colorblind", "lcd", "print", "photocopy"}{cmd:)]} ] {break}

{title:Description}

{p 4 4 4}{cmd:brewmeta} is a convenience program to quickly access and display 
metadata related to color schemes developed by Brewer.  The program builds a 
same named dataset in `"`c(sysdir_personal)'/b"' containing the meta data for 
each of the color palettes.  {p_end}

{title:Options}
{p 4 4 8}{cmdab:c:olors} is a required argument indicating the total number of 
colors from the specified palette that you would like to incorporate into a new
scheme file. {break}
 
{p 4 4 8}{cmdab:prop:erties[(}{it:"", "all", "colorblind", "lcd", "print", "photocopy"}{cmd:)]} is an optional arguement used to look up a specific property for the 
color palette.  If nothing is specified, the program will assume you would like 
to see the results for all of the properties. {p_end}

{title:References}{break}
{p 1 1 1} Colors from {browse "http://www.ColorBrewer2.org":Color Brewer} by 
Cynthia A. Brewer, Geography, Pennsylvania State University{p_end}

{title:License}
{p 4 4 4}Please view {browse "http://www.personal.psu.edu/cab38/ColorBrewer/ColorBrewer_updates.html": section 4} of the ColorBrewer copyright notice for additional information 
pertaining to the licensing and redistribution of ColorBrew intellectual property.{p_end}

{title: Author}{break}
{p 1 1 1} William R. Buchanan, Ph.D. {break}
Strategic Data Fellow {break}
{browse "http://mde.k12.ms.us":Mississippi Department of Education} {break}
BBuchanan at mde [dot] k12 [dot] ms [dot] us
